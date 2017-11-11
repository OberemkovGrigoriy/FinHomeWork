//
//  StorageManager.swift
//  homework
//
//  Created by Gregory Oberemkov on 04.11.17.
//  Copyright © 2017 Gregory Oberemkov. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol StorageProtocol: class{
    func recieveMessage(text: String, fromUser: String, toUser: String)
    func didFoundUser(userID: String, userName: String?)
    func didLostUser(userID: String)
}


class StorageManager: StorageProtocol  {

    let coreDataStack = StackCoreData.sharedInstance
    
    func save(object: ProfileDataToSave, closure: @escaping () -> ()){
        if let context = coreDataStack.saveContext {
            let appUser = AppUser.findOrInserAppUser(in: context)
            appUser?.name = object.profileName
            appUser?.aboutText = object.profileAbout
            appUser?.avatar = object.profileImage
            
            coreDataStack.performSave(context: context, completionHandler: nil)
            closure()
        }
        else{
            print ("No saveContext")
        }
    }
    
    func retrive(closure: @escaping (ProfileDataToSave?)->()){
        if let context = coreDataStack.mainContext {
            let appUser = AppUser.findOrInserAppUser(in: context)
            if let appUser = appUser{
                if appUser.avatar == nil && appUser.aboutText == nil && appUser.avatar == nil{
                    closure(nil)
                }
                else{
                    let retrieve = ProfileDataToSave(profileName: appUser.name, profileAbout: appUser.aboutText, profileImage: appUser.avatar as? UIImage)
                    DispatchQueue.main.async {
                        closure(retrieve)
                    }
                }
            }
        }
        else{
            print ("No mainContext")
        }
    }
    
    
    func recieveMessage(text: String, fromUser: String,toUser:String){
        if let context = coreDataStack.saveContext {
            let message = Message.insertMessage(text: text, recieverId: toUser, senderId: fromUser, in: context)
            message?.isUnread = true
            let conversation = Conversation.findOrInsertConversation(with: String.generateConversationId(id1: fromUser, id2: toUser), in: context)
            conversation?.lastMessage = message
            coreDataStack.performSave(context: context, completionHandler: nil)
        }
    }
    func didFoundUser(userID:String,userName:String?){
        if let context = coreDataStack.saveContext {
            let user = User.findOrInsertUser(with: userID, in: context)
            user?.name = userName
            user?.isOnline = true
            // probably add save before
            let conversation = Conversation.findOrInsertConversation(with: String.generateConversationId(id1: userID, id2: UIDevice.current.name), in: context)
            let me = User.findOrInsertUser(with: UIDevice.current.name, in: context) // check then on AppUser
            conversation?.addToParticipants(user!)
            conversation?.addToParticipants(me!)
            conversation?.isOnline = true
            print (conversation?.conversationId)
            coreDataStack.performSave(context: context, completionHandler: nil)
        }
        
    }
    func didLostUser(userID:String){
        if let context = coreDataStack.saveContext {
            let user = User.findOrInsertUser(with: userID, in: context)
            user?.isOnline = false
            let conversation = Conversation.findOrInsertConversation(with: String.generateConversationId(id1: userID, id2: UIDevice.current.name), in: context)
            conversation?.isOnline = false
            coreDataStack.performSave(context: context, completionHandler: nil)
        }
        
    }
    
}

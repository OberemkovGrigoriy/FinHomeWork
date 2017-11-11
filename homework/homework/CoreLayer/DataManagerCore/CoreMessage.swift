//
//  CoreMessage.swift
//  homework
//
//  Created by Gregory Oberemkov on 11.11.17.
//  Copyright © 2017 Gregory Oberemkov. All rights reserved.
//


import Foundation
import UIKit
import CoreData


extension String {
    
    static func generateMessageId()-> String{
        let string = "\(arc4random_uniform(UINT32_MAX))+\(Date.timeIntervalSinceReferenceDate)+\(arc4random_uniform(UINT32_MAX))".data(using: .utf8)?.base64EncodedString()
        return string!
    }
    
    static func generateConversationId(id1:String,id2:String)->String{
        if id1>id2{
            return id1+id2;
        }
        else{
            return id2+id1;
        }
    }
}


extension Message {
    static func insertMessage(text: String,recieverId: String,senderId: String,in context:NSManagedObjectContext)->Message?{
        if let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as? Message {
            message.isUnread = true
            message.messageId = String.generateMessageId()
            message.date = Date()
            message.text = text
            let reciverUser = User.findOrInsertUser(with: recieverId, in: context)
            let senderUser = User.findOrInsertUser(with: senderId, in: context)
            message.reciever = reciverUser
            message.sender = senderUser
            let convId = String.generateConversationId(id1: recieverId, id2: senderId)
            let conversation = Conversation.findConversation(with:convId, in: context)
            message.conversation = conversation
            return message
        }
        return nil
    }
    
    
    
    static func findMessagesByConversation(with Id: String, in context:NSManagedObjectContext) -> [Message]?{
        guard let model = context.persistentStoreCoordinator?.managedObjectModel else {
            print ("Model is not available in context")
            assert(false)
            return nil
        }
        var messages : [Message]?
        guard let fetchRequest = Message.fetchRequestMessageByConversation(with: Id,model: model) else {
            return nil
        }
        
        do {
            messages = try context.fetch(fetchRequest)
        } catch {
            print ("Failed to fetch appUser: \(error)")
        }
        return messages
    }
    
    static func fetchRequestMessageByConversation(with Id:String, model: NSManagedObjectModel) -> NSFetchRequest<Message>? {
        let templateName = "MessagesByConversationId"
        
        guard let fetchRequest = model.fetchRequestFromTemplate(withName: templateName, substitutionVariables: ["Id" : Id]) as? NSFetchRequest<Message> else{
            assert(false,"No template with name \(templateName)")
            return nil
        }
        return fetchRequest
    }
    
}


//
//  ConversationModel.swift
//  homework
//
//  Created by Gregory Oberemkov on 30.10.17.
//  Copyright © 2017 Gregory Oberemkov. All rights reserved.
//

import Foundation

class ConversationModel: MessageReciever{
    
    var dialoges: [cellData] = []
    
    var controller: ConversationsListViewController
    
    init(controller: ConversationsListViewController){
        self.controller = controller 
    }
    
    func recieveMessage(text: String, fromUser: String, read: Bool) -> Bool {
        for (index,dialog) in dialoges.enumerated(){
            if dialog.userID == fromUser{
                dialoges[index].message = text
                dialoges[index].date = Date()
                // make unread
                if !read{
                    dialoges[index].hasUnreadedMessages = true
                    controller.setup()
                }
                else{
                    dialoges[index].hasUnreadedMessages = false
                    controller.setup()
                }
            }
        }
        return false
    }
    
    func deleteUser(userID:String){
        print("delete")
        for (index,dialog) in dialoges.enumerated(){
            if dialog.userID == userID{
                dialoges.remove(at: index)
            }
            controller.setup()
        }
    }
    
    func addUser(userID:String,userName:String?){
        let data:cellData = cellData(name: userName,userID:userID, message: nil, date: Date(), online: true, hasUnreaded: false)
        dialoges.insert(data, at: 0)
        controller.setup()
    }
    
    func showAlert(error:Error){
        print("ERROR:")
        print(error.localizedDescription)
    }
}

//
//  DialogueModel.swift
//  homework
//
//  Created by Gregory Oberemkov on 30.10.17.
//  Copyright © 2017 Gregory Oberemkov. All rights reserved.
//

import Foundation

class DialogueModel: MessageReciever{
    
   // var comManager: CommunicationManager?
    var controller: DialogueViewController
    
    init(controller: DialogueViewController){
        self.controller = controller
    }
    
    func recieveMessage(text: String, fromUser: String,read: Bool)->Bool{

        if controller.userID == fromUser{
            controller.messages.append((text,true))
            self.controller.setup()
            
            return true
        }
        self.controller.setup()
        
        return false
    }
    
    func deleteUser(userID:String){
        if controller.userID == userID{
            controller.online = false
            DispatchQueue.main.async {
                self.controller.messageField.isHidden = true
            }
        }
    }
    
    func addUser(userID:String,userName:String?){
        if controller.userID == userID{
            controller.online = true
            DispatchQueue.main.async {
                self.controller.messageField.isHidden = false
            }
        }
    }
    
    func showAlert(error:Error){
        print(error.localizedDescription)
    }
    
}

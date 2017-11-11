//
//  DialogueViewController.swift
//  homework
//
//  Created by Gregory Oberemkov on 08.10.17.
//  Copyright © 2017 Gregory Oberemkov. All rights reserved.
//

import UIKit
import CoreData

class DialogueViewController: UIViewController,UITableViewDataSource,UITextFieldDelegate, MessageReciever {
    
    var userID: String?
    var comManager: CommunicationManager?
    var online = true
    var conversationId: String?
    var messages:[(String,Bool)] = []
    var fetchedResultsController: NSFetchedResultsController<Message>?
    var provider: ConversationDataProvider?
    
    @IBOutlet weak var messagesTable: UITableView!
    @IBOutlet weak var messageField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configurateTable()
        messageField.delegate = self
        if(conversationId != nil){
        provider = ConversationDataProvider(tableView: messagesTable,conversationId: conversationId!)
        }
        fetchedResultsController = provider?.fetchedResultsController
        do {
            try self.fetchedResultsController?.performFetch()
        } catch {
            print("Error fetching: \(error)")
        }

    }
    
    func configurateTable(){
        messagesTable.dataSource = self
        messagesTable.rowHeight = UITableViewAutomaticDimension
        messagesTable.estimatedRowHeight = 88
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(messages[indexPath.row].1 == true){
            let cell = tableView.dequeueReusableCell(withIdentifier: "firstId", for: indexPath) as? MessageViewCell
            cell?.configurate(text: (messages[indexPath.row].0))
            return cell!
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "secondId", for: indexPath) as? MessageViewCell
            cell?.configurate(text: (messages[indexPath.row].0))
            return cell!
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let txt = textField.text{
            messages.append((txt,false))
            sendMessage(message: txt)
            
            setup()
            
            textField.text = ""
        }
        textField.endEditing(true)
        
        return true;
    }
    
    func sendMessage(message:String){
        comManager?.sendMessage(string: message, to: userID!, completionHandler: sendMessageHandler)
    }
    
    func sendMessageHandler(_ success: Bool,_ error: Error?)->(){
        if !success{
            if let er = error{
                print(er)
            }
        }
    }
    
    func setup(){
        DispatchQueue.main.async {
            self.messagesTable.reloadData()
        }
    }

    func recieveMessage(text: String, fromUser: String,read: Bool)->Bool{
        
        if userID == fromUser{
            messages.append((text,true))
            setup()
            return true
        }
        setup()
        
        return false
    }
    
    func deleteUser(userID:String){
        if userID == userID{
            online = false
            DispatchQueue.main.async {
                self.messageField.isHidden = true
            }
        }
    }
    
    func addUser(userID:String,userName:String?){
        if userID == userID{
            online = true
            DispatchQueue.main.async {
                self.messageField.isHidden = false
            }
        }
    }
    
    func showAlert(error:Error){
        print(error.localizedDescription)
    }
}

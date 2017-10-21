//
//  DialogueViewController.swift
//  homework
//
//  Created by Gregory Oberemkov on 08.10.17.
//  Copyright © 2017 Gregory Oberemkov. All rights reserved.
//

import UIKit
import QuartzCore
class DialogueViewController: UIViewController,UITableViewDataSource,UITextFieldDelegate,MessageReciever {
    
    var messages:[(String,Bool)] = []
    var userID: String?
    var online = true
    var comManager: CommunicationManager?
    
    
    @IBOutlet weak var messagesTable: UITableView!
    @IBOutlet weak var messageField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configurateTable()
        messageField.delegate = self
        // Do any additional setup after loading the view.
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
            cell?.configurate(text: messages[indexPath.row].0)
            return cell!
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "secondId", for: indexPath) as? MessageViewCell
            cell?.configurate(text: messages[indexPath.row].0)
            return cell!
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let txt = textField.text{
            messages.append((txt,false))
            sendMessage(message: txt)
            DispatchQueue.main.async{
                self.messagesTable.reloadData()
            }
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
                showAlert(error: er)
            }
        }
    }
    
    // MARK: - MessageReciever
    func recieveMessage(text: String, fromUser: String,read: Bool)->Bool{
        if self.userID == fromUser{
            print("recieved")
            self.messages.append((text,true))
            DispatchQueue.main.async{
                self.messagesTable.reloadData()
            }
            return true
        }
        return false
    }
    
    func deleteUser(userID:String){
        if self.userID == userID{
            online = false
            DispatchQueue.main.async{
                self.messageField.isHidden = true
            }
        }
    }
    
    func addUser(userID:String,userName:String?){
        if self.userID == userID{
            online = true
            DispatchQueue.main.async{
                self.messageField.isHidden = false
            }
        }
    }
    
    func showAlert(error:Error){
        let alert = UIAlertController(title: error.localizedDescription, message:nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Ок", style: .default) { action in
        })
        self.present(alert,animated: true)
    }
    
}

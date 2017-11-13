//
//  DialogueViewController.swift
//  homework
//
//  Created by Gregory Oberemkov on 08.10.17.
//  Copyright © 2017 Gregory Oberemkov. All rights reserved.
//

import UIKit
import CoreData

class DialogueViewController: UIViewController,UITableViewDataSource,UITextFieldDelegate {

    var userID: String?
    var online = true
    var conversationId: String?
    var comManager: CommunicationManager?
    var fetchedResultsController: NSFetchedResultsController<Message>?
    var provider: ConversationDataProvider?
    @IBOutlet weak var messagesTable: UITableView!
    @IBOutlet weak var messageField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configurateTable()
        messageField.delegate = self
        provider = ConversationDataProvider(tableView: messagesTable,conversationId: conversationId!)
        fetchedResultsController = provider?.fetchedResultsController
        do {
            try self.fetchedResultsController?.performFetch()
        } catch {
            print("Error fetching: \(error)")
        }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {

        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
  
    }
    
    func configurateTable(){
        messagesTable.dataSource = self
        messagesTable.rowHeight = UITableViewAutomaticDimension
        messagesTable.estimatedRowHeight = 88
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let user = User.findOrInsertUser(with: userID!, in: StackCoreData.sharedInstance.mainContext!)
        if (user?.isOnline)!{
            if let txt = textField.text{
                sendMessage(message: txt)
                textField.text = ""
            }
            textField.endEditing(true)
        }else{
            let alert = UIAlertController(title: "К сожалению \((user?.name)!) покинул сеть", message:nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Ок", style: .default) { action in
            })
            self.present(alert,animated: true)
            
        }
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
    
    func showAlert(error:Error){
        let alert = UIAlertController(title: error.localizedDescription, message:nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Ок", style: .default) { action in
        })
        self.present(alert,animated: true)
    }
    
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let frc = fetchedResultsController, let sectionsCount =
            frc.sections?.count else {
                return 0
        }
        return sectionsCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let frc = fetchedResultsController, let sections = frc.sections else {
            return 0
        }
        return sections[section].numberOfObjects
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //UIDevice.current.name
        if let message = fetchedResultsController?.object(at: indexPath) {
            if message.reciever?.userId == UIDevice.current.name {
                let cell = tableView.dequeueReusableCell(withIdentifier: "firstId", for: indexPath) as! MessageViewCell
                cell.configurate(with: message)
                return cell
            }
            else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "secondId", for: indexPath) as! MessageViewCell
                cell.configurate(with: message)
                return cell
                
            }
        }
     
        return MessageViewCell()
    }
}

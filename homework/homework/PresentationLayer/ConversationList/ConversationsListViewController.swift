//
//  ConversationsListViewController.swift
//  homework
//
//  Created by Gregory Oberemkov on 08.10.17.
//  Copyright © 2017 Gregory Oberemkov. All rights reserved.
//


import UIKit

class ConversationsListViewController: UIViewController,UITableViewDataSource{
    
    let comManager = CommunicationManager()
    var conversModel: ConversationModel?
    
    @IBOutlet var dialoguesTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        dialoguesTable.dataSource = self
        conversModel = ConversationModel(controller: self)
        comManager.controller = conversModel
    }
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dialogue"{
            if let cell = sender as? TableViewCell{
                if let dest = segue.destination as? DialogueViewController{
                    dest.userID = cell.userID
                    dest.comManager = comManager
                    comManager.chatController = dest
                    cell.hasUnreadedMessages = false
                    if let msg = cell.message{
                        dest.messages.append((msg,true))
                    }
                }
                segue.destination.navigationItem.title = cell.name
            }
        }
    }
    
    // MARK: - UITableViewDelegate
    
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // в будущем считать элементы массива
        return conversModel!.dialoges.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Online"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        conversModel?.dialoges.sort(by: {$0.date! > $1.date!})
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath)
        if let cell = cell as? TableViewCell{
            cell.configurate(data: (conversModel?.dialoges[indexPath.row])!)
            return cell
        }
        return cell
    }
    
    func setup(){
        DispatchQueue.main.async {
            self.dialoguesTable.reloadData()
        }
    }
    
}
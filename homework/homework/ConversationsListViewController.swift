//
//  ConversationsListViewController.swift
//  homework
//
//  Created by Gregory Oberemkov on 08.10.17.
//  Copyright © 2017 Gregory Oberemkov. All rights reserved.
//

import UIKit


var onlineAndHistorySectionMassive: [[DataOfButton]] = [[],[]]

class ConversationsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var section = ["online", "history"]
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as? TableViewCell  else {
            fatalError("The dequeued cell is not an instance of TableViewCell.")
        }

        if let mess = onlineAndHistorySectionMassive[indexPath.section][indexPath.row].message {
            cell.message.text =  mess
            if onlineAndHistorySectionMassive[indexPath.section][indexPath.row].hasUnreadedMessages == true{
                cell.message.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
            }
        }
        else {
            cell.message.text = "No messages yet"
        }
        if let date = onlineAndHistorySectionMassive[indexPath.section][indexPath.row].date {
            let currentData = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM"
            let cellDate = dateFormatter.string(from: date)
            let cellCureentDate = dateFormatter.string(from: currentData)
            
            if cellDate != cellCureentDate{
                cell.date.text = cellDate
            }
            else{
                dateFormatter.dateFormat = "HH:mm"
                cell.date.text = dateFormatter.string(from: date)
            }
        }
        
        if onlineAndHistorySectionMassive[indexPath.section][indexPath.row].online == true {
            cell.backgroundColor = UIColor(red: 1, green: 1, blue: 0.8, alpha: 1.0)
        } else {
            cell.backgroundColor = .white
        }
        
        
        if let notOptionalName =  onlineAndHistorySectionMassive[indexPath.section][indexPath.row].name {
            cell.name.text = notOptionalName
        }
   
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return section.count
    }
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        loadNewMassive()
    
        return onlineAndHistorySectionMassive[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.section[section]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? TableViewCell{
            segue.destination.navigationItem.title = cell.name.text
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

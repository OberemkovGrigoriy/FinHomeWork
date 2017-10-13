//
//  ConversationsListViewController.swift
//  homework
//
//  Created by Gregory Oberemkov on 08.10.17.
//  Copyright © 2017 Gregory Oberemkov. All rights reserved.
//

import UIKit

class ConversationsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var onlineAndHistorySectionMassive: [[DataOfButton]] = [[],[]]

    func loadNewMassive() {
        let user1 = DataOfButton(hasUnreadedMessages: false, name: "Dima", message: "Hi", date: convertStringToData(dateString: "15 June 15:00"), online: false)
        let user2 = DataOfButton(hasUnreadedMessages: false, name: "Gregoriy", message: nil, date: convertStringToData(dateString: "13 May 16:30"), online: true)
        let user3 = DataOfButton(hasUnreadedMessages: true, name: "Masha", message: "I haven't seen you since childhood", date: convertStringToData(dateString: "14 October 00:00"), online: true)
        let user4 = DataOfButton(hasUnreadedMessages: false, name: "Sally", message: "I hate Mondays", date: convertStringToData(dateString: "11 November 09:00"), online: false)
        let user5 = DataOfButton(hasUnreadedMessages: false, name: "Dave", message: "Check your mistakes", date: convertStringToData(dateString: "11 October 15:51"), online: true)
        let user6 = DataOfButton(hasUnreadedMessages: false, name: "Mike", message: "Hello guy, open the door please", date: convertStringToData(dateString: "20 January 01:42"), online: false)
        let user7 = DataOfButton(hasUnreadedMessages: false, name: "Calvin", message: nil, date: convertStringToData(dateString: "13 January 5:00"), online: true)
        let user8 = DataOfButton(hasUnreadedMessages: false, name: "son", message: "I have some news for you", date: convertStringToData(dateString: "02 October 23:30"), online: false)
        let user9 = DataOfButton(hasUnreadedMessages: true, name: "Joel", message: "What about football today?", date: convertStringToData(dateString: "11 October 22:00"), online: true)
        let user10 = DataOfButton(hasUnreadedMessages: false, name: "Christian", message: nil, date: convertStringToData(dateString: "17 July 21:00"), online: true)
        let user11 = DataOfButton(hasUnreadedMessages: false, name: "Kim", message: "Sorry, I'm late", date: convertStringToData(dateString: "01 August 00:00"), online: false)
        let user12 = DataOfButton(hasUnreadedMessages: true, name: "Nina", message: nil, date: convertStringToData(dateString: "01 September 19:15"), online: true)
        let user13 = DataOfButton(hasUnreadedMessages: false, name: "Sindy", message: "Do you want to play the computer game tonight?", date: convertStringToData(dateString: "09 September 13:00"), online: true)
        let user14 = DataOfButton(hasUnreadedMessages: false, name: "Michael", message: "Hey! Help me!", date: convertStringToData(dateString: "31 December 11:30"), online: false)
        let user15 = DataOfButton(hasUnreadedMessages: false, name: "Nelly", message: "Buy some food for yourself", date: convertStringToData(dateString: "8 October 21:20"), online: true)
        let user16 = DataOfButton(hasUnreadedMessages: false, name: "Mary", message: nil, date: convertStringToData(dateString: "8 October 04:00"), online: true)
        let user17 = DataOfButton(hasUnreadedMessages: true, name: "Sergio", message: "Did you read this awesome book?", date: convertStringToData(dateString: "16 October 01:20"), online: false)
        let user18 = DataOfButton(hasUnreadedMessages: false, name: "eminem", message: nil, date: convertStringToData(dateString: "8 October 06:30"), online: true)
        let user19 = DataOfButton(hasUnreadedMessages: true, name: "Garrison", message: nil, date: convertStringToData(dateString: "17 October 08:00"), online: true)
        let user20 = DataOfButton(hasUnreadedMessages: true, name: "Marie", message: "I've already cooked dinner", date: convertStringToData(dateString: "17 October 08:00"), online: true)
        

        var onlineSectionMassive: [DataOfButton] = []
        var historySectionMassive: [DataOfButton] = []
        
        let users = [user1, user2, user3, user4, user5, user6, user7, user8, user9, user10, user11, user12, user13, user14, user15, user16, user17, user18, user19, user20]
        
        for index in 0..<users.count {
            if users[index].online == true {
                onlineSectionMassive.append(users[index])
                
            }
            else {
                historySectionMassive.append(users[index])
            }
        }
        
        onlineAndHistorySectionMassive[0] = onlineSectionMassive
        onlineAndHistorySectionMassive[1] = historySectionMassive
        print(onlineAndHistorySectionMassive)
    }

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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 57
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
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20
    }
    
}

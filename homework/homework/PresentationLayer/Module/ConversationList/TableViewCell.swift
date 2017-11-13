//
//  TableViewCell.swift
//  homework
//
//  Created by Gregory Oberemkov on 08.10.17.
//  Copyright © 2017 Gregory Oberemkov. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var conversationId:String?
    
    var name: String?{
        didSet{
            nameLabel.text = name
        }
    }
    var message: String?{
        didSet{
            if(message==nil || message == ""){ 
                messageLabel.font =  UIFont (name: "Menlo", size: 16.0)
                messageLabel.text = "No messages yet"
                
            }
            else{
                messageLabel.font = UIFont.systemFont(ofSize: 17.0)
                messageLabel.text = message
            }
        }
    }
    var date:Date?{
        didSet{
            if(date != nil && (messageLabel.text != nil) ){
                let currentDate = Date()
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                formatter.timeStyle = .none
                if(formatter.string(from: date!) != formatter.string(from: currentDate)){
                    timeLabel.text = "\(formatter.string(from: date!))"
                }
                else{
                    formatter.dateStyle = .none
                    formatter.timeStyle = .short
                    timeLabel.text = "\(formatter.string(from: date!))"
                }
            }
        }
    }
    
    var userID: String?
    
    var online:Bool = false
    {
        didSet{
            if (online == true){
                self.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue:
                    210.0/255.0, alpha: 1)
            }
            else {
                self.backgroundColor = UIColor.white
            }
        }
    }
    
    var hasUnreadedMessages:Bool = false{
        didSet{
            if(!(message==nil || message == "")){
                if hasUnreadedMessages==false{
                    messageLabel.font = UIFont.systemFont(ofSize: 17.0)
                }
                else{
                    messageLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
                }
            }
        }
    }
    
    func configurate(data: cellData){
        name = data.name
        message = data.message
        date = data.date
        online = data.online
        hasUnreadedMessages = data.hasUnreadedMessages
        userID = data.userID
    }
    
    func configurate(data:Conversation){
        let participants = data.participants?.allObjects as! [User]
        var opponent:User?
        if participants.first?.userId == UIDevice.current.name{
            opponent = participants.last
        }
        else {
            opponent = participants.first
        }
        print ("Configurate")
        print(opponent?.name)
        let lastMessage = data.lastMessage
        name = opponent?.name
        date = lastMessage?.date as Date?
        online = data.isOnline
        message = lastMessage?.text
        print(lastMessage?.isUnread)
        if let cond = lastMessage?.isUnread{
            hasUnreadedMessages = cond // time decision
        }
        else{
            hasUnreadedMessages = false
        }
        userID = opponent?.userId
        conversationId = data.conversationId
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

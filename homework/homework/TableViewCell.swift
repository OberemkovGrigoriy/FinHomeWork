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
    

    
    var name: String?{
        didSet{
            nameLabel.text = name
        }
    }
    
    var message: String?{
        didSet{
            if(message==nil){
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
    
    var userID: String?
    
    
    var hasUnreadedMessages: Bool = false{
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

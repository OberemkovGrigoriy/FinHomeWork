//
//  MessageTableViewCell.swift
//  homework
//
//  Created by Gregory Oberemkov on 08.10.17.
//  Copyright © 2017 Gregory Oberemkov. All rights reserved.
//

import UIKit

class MessageViewCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    var msgText:String?{
        didSet{
            messageLabel.text = msgText
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configurate(text:String){
        msgText = text
    }

    func configurate(with msg:Message){
        print("configurate with MSG::::::::")
        msgText = msg.text
        messageLabel.layer.masksToBounds = true
        messageLabel.layer.cornerRadius = 10
        if msg.reciever?.userId! == UIDevice.current.name { 
            messageLabel.backgroundColor = UIColor(red: 100/255, green: 86/255, blue: 143/255, alpha: 0.2)
        }
        else{
            messageLabel.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 0/255, alpha: 1)
        }
    }
    
}

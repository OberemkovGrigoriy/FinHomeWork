//
//  MessageTableViewCell.swift
//  homework
//
//  Created by Gregory Oberemkov on 08.10.17.
//  Copyright © 2017 Gregory Oberemkov. All rights reserved.
//

import UIKit

protocol MessageCellConfiguration: class{
    var textOfMessage: String {get set}
}


class MessageTableViewCell: UITableViewCell, MessageCellConfiguration {
   
    func configurate(cellData: String){
        textOfMessage = cellData
    }
    
    var textOfMessage: String = "" {
        didSet{
            message.text = textOfMessage
        }
    }

    @IBOutlet weak var message: UILabel!
    var messageTextFromMassive : String?{
        didSet{
            message.text = messageTextFromMassive
        }
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

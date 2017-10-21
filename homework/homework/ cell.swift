//
//   cell.swift
//  homework
//
//  Created by Gregory Oberemkov on 21.10.17.
//  Copyright © 2017 Gregory Oberemkov. All rights reserved.
//


import Foundation

struct cellData {
    init(name:String?,userID:String,message:String?,date:Date?,online:Bool,hasUnreaded:Bool) {
        self.userID = userID
        self.name = name
        self.message = message
        self.date = date
        self.online = online
        self.hasUnreadedMessages = hasUnreaded
    }
    var name: String?
    var userID: String
    var message: String?
    var date:Date?
    var online:Bool
    var hasUnreadedMessages:Bool
}


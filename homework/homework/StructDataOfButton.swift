import UIKit

protocol ConversationCellConfiguration: class {
    var name: String? {get set}
    var message: String? {get set}
    var date:Date? {get set}
    var online:Bool {get set}
    var hasUnreadedMessages:Bool {get set}
}


class DataOfButton: ConversationCellConfiguration {
    var hasUnreadedMessages: Bool
    var name: String?
    var message: String?
    var date: Date?
    var online: Bool
    var userID: String
 
    init(hasUnreadedMessages: Bool, name: String?, message: String?, date: Date?, online: Bool, userID:String){
        self.hasUnreadedMessages = hasUnreadedMessages
        self.name = name
        self.date = date
        self.message = message
        self.online = online
        self.userID = userID
    }
}


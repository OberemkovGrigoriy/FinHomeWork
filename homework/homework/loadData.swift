//
//  loadData.swift
//  table
//
//  Created by Gregory Oberemkov on 07.10.17.
//  Copyright © 2017 Gregory Oberemkov. All rights reserved.
//

import UIKit

func convertStringToData (dateString: String) -> Date?{
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMM HH:mm"
    
    let date = dateFormatter.date(from: dateString)
    
    return date
}


func loadNewMassive() {
    
    let user1 = DataOfButton(hasUnreadedMessages: false, name: "Divan", message: "Hi", date: convertStringToData(dateString: "15 June 15:00"), online: false)
    let user2 = DataOfButton(hasUnreadedMessages: false, name: "Gregoriy", message: nil, date: convertStringToData(dateString: "13 May 16:30"), online: true)
    let user3 = DataOfButton(hasUnreadedMessages: true, name: "Masha", message: "lallalaa", date: convertStringToData(dateString: "14 October 00:00"), online: true)
    let user4 = DataOfButton(hasUnreadedMessages: false, name: "Kent", message: "eta shtuka", date: convertStringToData(dateString: "15 November 09:00"), online: false)
    let user5 = DataOfButton(hasUnreadedMessages: false, name: "nastya", message: "Hi124", date: convertStringToData(dateString: "8 October 15:51"), online: true)
    let user6 = DataOfButton(hasUnreadedMessages: false, name: "volodya", message: "oooy", date: convertStringToData(dateString: "20 January 01:42"), online: false)
    let user7 = DataOfButton(hasUnreadedMessages: false, name: "marl", message: nil, date: convertStringToData(dateString: "13 January 5:00"), online: true)
    let user8 = DataOfButton(hasUnreadedMessages: false, name: "son", message: "zidan", date: convertStringToData(dateString: "02 October 23:30"), online: false)
    let user9 = DataOfButton(hasUnreadedMessages: true, name: "obama", message: "barakaka", date: convertStringToData(dateString: "11 September 22:00"), online: true)
    let user10 = DataOfButton(hasUnreadedMessages: false, name: "putin", message: nil, date: convertStringToData(dateString: "17 July 21:00"), online: false)
    let user11 = DataOfButton(hasUnreadedMessages: false, name: "arshavin", message: "footbal", date: convertStringToData(dateString: "01 August 00:00"), online: false)
    let user12 = DataOfButton(hasUnreadedMessages: true, name: "kokorin", message: "alcohol", date: convertStringToData(dateString: "01 September 19:15"), online: false)
    let user13 = DataOfButton(hasUnreadedMessages: false, name: "sindy", message: "meh", date: convertStringToData(dateString: "09 September 13:00"), online: true)
    let user14 = DataOfButton(hasUnreadedMessages: false, name: "dzhumandzhi", message: "kiss", date: convertStringToData(dateString: "31 December 11:30"), online: false)
    let user15 = DataOfButton(hasUnreadedMessages: false, name: "cat", message: "meyw", date: convertStringToData(dateString: "8 October 21:20"), online: true)
    let user16 = DataOfButton(hasUnreadedMessages: false, name: "dog", message: "gaw", date: convertStringToData(dateString: "8 October 04:00"), online: false)
    let user17 = DataOfButton(hasUnreadedMessages: true, name: "grandfather", message: "hello where is my money", date: convertStringToData(dateString: "16 October 01:20"), online: false)
    let user18 = DataOfButton(hasUnreadedMessages: false, name: "eminem", message: nil, date: convertStringToData(dateString: "8 October 06:30"), online: true)
    let user19 = DataOfButton(hasUnreadedMessages: true, name: "kpss", message: nil, date: convertStringToData(dateString: "17 October 08:00"), online: true)
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




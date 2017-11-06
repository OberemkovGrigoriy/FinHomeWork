//
//  StorageManager.swift
//  homework
//
//  Created by Gregory Oberemkov on 04.11.17.
//  Copyright © 2017 Gregory Oberemkov. All rights reserved.
//

import Foundation
import UIKit
import CoreData
//ProfileDataToSave
class StorageManager {
    let coreDataStack = StackCoreData()
    
    func save(object: ProfileDataToSave, closure: @escaping () -> ()){
        if let context = coreDataStack.saveContext {
            let appUser = AppUser.findOrInserAppUser(in: context)
            appUser?.name = object.profileName
            appUser?.aboutText = object.profileAbout
            appUser?.avatar = object.profileImage
            
            coreDataStack.performSave(context: context, completionHandler: nil)
            closure()
        }
        else{
            print ("No saveContext")
        }
    }
    
    func retrive(closure: @escaping (ProfileDataToSave?)->()){
        if let context = coreDataStack.mainContext {
            let appUser = AppUser.findOrInserAppUser(in: context)
            if let appUser = appUser{
                if appUser.avatar == nil && appUser.aboutText == nil && appUser.avatar == nil{
                    closure(nil)
                }
                else{
                    let retrieve = ProfileDataToSave(profileName: appUser.name, profileAbout: appUser.aboutText, profileImage: appUser.avatar as? UIImage)
                    DispatchQueue.main.async {
                        closure(retrieve)
                    }
                }
            }
        }
        else{
            print ("No mainContext")
        }
    }
}

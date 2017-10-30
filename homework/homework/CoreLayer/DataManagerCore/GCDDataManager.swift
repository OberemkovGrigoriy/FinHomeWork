//
//  GCDDataManager.swift
//  homework
//
//  Created by Gregory Oberemkov on 14.10.17.
//  Copyright © 2017 Gregory Oberemkov. All rights reserved.
//

import Foundation
import UIKit


protocol DataManagerMustSave{
    func save(dataToSave: ProfileDataToSave, closure: @escaping ()->())
}

class GCDDataManager: DataManagerMustSave{
    func save(dataToSave: ProfileDataToSave, closure: @escaping ()->()){
        let queueToSaveData = DispatchQueue.global(qos: .userInitiated)
        queueToSaveData.async {
            let savedData = NSKeyedArchiver.archivedData(withRootObject: dataToSave)
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "userSaveData")
            DispatchQueue.main.async {
                closure()
            }
        }
        
    }
    
    func load(closure: @escaping (ProfileDataToSave?)->())->(){
        let defaults = UserDefaults.standard
        let queueToLoadData = DispatchQueue.global(qos: .userInitiated)
        queueToLoadData.async{
            var user: ProfileDataToSave? = nil
            if let savedData = defaults.object(forKey: "userSaveData"){
                user = NSKeyedUnarchiver.unarchiveObject(with: savedData as! Data) as? ProfileDataToSave 
            }
            DispatchQueue.main.async {
                closure(user)
            }
        }
    }
}

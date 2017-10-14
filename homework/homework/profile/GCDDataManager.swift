//
//  GCDDataManager.swift
//  homework
//
//  Created by Gregory Oberemkov on 14.10.17.
//  Copyright © 2017 Gregory Oberemkov. All rights reserved.
//

import Foundation
import UIKit

class GCDDataManager{
    func save(dataToSave: ProfileDataToSave, closure: @escaping ()->()){
        let queueToSaveData = DispatchQueue.global(qos: .utility)
        queueToSaveData.async {
            let savedData = NSKeyedArchiver.archivedData(withRootObject: dataToSave)
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "userSaveData")
            DispatchQueue.main.async {
                closure()
            }
        }
        
    }
    func load(closure: @escaping (ProfileDataToSave?)->()){
        let defaults = UserDefaults.standard
        let queueToLoadData = DispatchQueue.global(qos: .utility)
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

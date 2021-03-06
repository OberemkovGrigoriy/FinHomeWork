//
//  OperationDataManager.swift
//  homework
//
//  Created by Gregory Oberemkov on 15.10.17.
//  Copyright © 2017 Gregory Oberemkov. All rights reserved.
//

import Foundation
import UIKit


class OperationDataManager: DataManagerMustSave{
    
    func save(dataToSave: ProfileDataToSave,closure: @escaping ()->()){
        let queue = OperationQueue()
        let op = myOperationSave(object: dataToSave, closure: closure)
        queue.addOperation(op)
    }
    
    func load(closure: @escaping (ProfileDataToSave?)->()){
        let queue = OperationQueue()
        let op = myOperationDownload(closure: closure)
        queue.addOperation(op)
    }
    
}

class myOperationSave: Operation{
    
    init(object: ProfileDataToSave,closure: @escaping ()->()){
        self.toSave = object
        self.clos = closure
        super.init()
    }
    var toSave: ProfileDataToSave
    var clos:()->()
    
    
    override var isAsynchronous: Bool {
        return true
    }
    
    override func start() {
        execute()
    }
 
    
    func execute() {
        let savedData = NSKeyedArchiver.archivedData(withRootObject: toSave)
        let defaults = UserDefaults.standard
        defaults.set(savedData, forKey: "user")
        DispatchQueue.main.async {
            self.clos()
        }
    }
 
    
}

class myOperationDownload: Operation{
    
    init(closure: @escaping (ProfileDataToSave?)->()){
        self.clos = closure
        super.init()
    }
    var clos:(ProfileDataToSave?)->()
    override var isAsynchronous: Bool {
        return true
    }
    
    override func start() {
        execute()
    }
    
    
    func execute() {
        let defaults = UserDefaults.standard
        var user:ProfileDataToSave? = nil
        if let savedData = defaults.object(forKey: "user") as? Data {
            user = NSKeyedUnarchiver.unarchiveObject(with: savedData) as? ProfileDataToSave
        }
        DispatchQueue.main.async {
            self.clos(user)
        }
    }
  
    
}

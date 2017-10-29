//
//  ProfileDataToSave.swift
//  homework
//
//  Created by Gregory Oberemkov on 14.10.17.
//  Copyright © 2017 Gregory Oberemkov. All rights reserved.
//

import Foundation
import UIKit

class ProfileDataToSave: NSObject, NSCoding{
    //NSobject, NSCODe, - позволяют классу соответствовать NSKeyArchive
    
    func encode(with aCoder: NSCoder) {
        //encode - закодирует для свойст profileName, profileAbout, profileImage соответственные  ключи
        aCoder.encode(profileName, forKey: "Key.profileName")
        aCoder.encode(profileAbout, forKey: "Key.profileAbout")
        aCoder.encode(profileImage, forKey: "Key.profileImage")
    }
    
    required init?(coder aDecoder: NSCoder) {
        //извлекает сохраненный объект и передает его как строку и как изображение
        profileName = aDecoder.decodeObject(forKey: "Key.profileName") as? String
        profileAbout = aDecoder.decodeObject(forKey: "Key.profileAbout") as? String
        profileImage = aDecoder.decodeObject(forKey: "Key.profileImage") as? UIImage
    }
    
    var profileName: String?
    var profileAbout: String?
    var profileImage: UIImage?
    
    init(profileName: String?, profileAbout: String?, profileImage: UIImage?){
        self.profileName = profileName
        self.profileAbout = profileAbout
        self.profileImage = profileImage
    }
}

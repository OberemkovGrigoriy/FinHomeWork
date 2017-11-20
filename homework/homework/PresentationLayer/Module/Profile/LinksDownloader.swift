//
//  LinksDownloader.swift
//  homework
//
//  Created by Gregory Oberemkov on 19.11.17.
//  Copyright © 2017 Gregory Oberemkov. All rights reserved.
//

import Foundation
import UIKit

class LinksDownloader{
    let apiKey:String
    let sender = RequestSender()
    init(apiKey: String){
        self.apiKey = apiKey
    }
    
    func requestImagesLinks(tag:String,closure:@escaping ([String])->()){
        let url = URL(string:"https://pixabay.com/api/?key=\(apiKey)&q=\(tag)&image_type=photo&per_page=100")!
        sender.send(url: url) { (data, error) in
            var answer = [String]()
            if let data = data{
                do{ let json = try JSON(data: data)
                    let images = json["hits"]
                    for (_,subJson):(String, JSON) in images {
                        answer.append(subJson["webformatURL"].stringValue)
                    }
                }
                catch{
                    print(print("Error"))
                }
            }
        closure(answer)
        }
    }
    
}

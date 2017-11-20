//
//  RequestSender.swift
//  homework
//
//  Created by Gregory Oberemkov on 19.11.17.
//  Copyright © 2017 Gregory Oberemkov. All rights reserved.
//

import Foundation

class RequestSender{
    let session = URLSession.shared
    func send(url: URL, completionHandler: @escaping (_ data:Data?,_ error:Error?)->()) {
        let task = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            completionHandler(data,error)
        }
        task.resume()
    }
}

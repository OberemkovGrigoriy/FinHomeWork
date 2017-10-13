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


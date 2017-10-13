//
//  DialogueViewController.swift
//  homework
//
//  Created by Gregory Oberemkov on 08.10.17.
//  Copyright © 2017 Gregory Oberemkov. All rights reserved.
//

import UIKit

let arrayDataToCellMessageInDialog: [String] = ["1", "303303303303303303303303303", "303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303", "1", "303303303303303303303303303", "303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303303"]

class DialogueViewController: UIViewController, UITableViewDataSource  {
    
    @IBOutlet weak var mesTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayDataToCellMessageInDialog.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if(indexPath.row%2==0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "first", for: indexPath) as? MessageTableViewCell
            cell?.configurate(cellData: arrayDataToCellMessageInDialog[indexPath.row])

            return cell!
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "second", for: indexPath) as? MessageTableViewCell
            
            cell?.configurate(cellData: arrayDataToCellMessageInDialog[indexPath.row])
      
            return cell!
        }

    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        mesTable.dataSource = self
        mesTable.rowHeight = UITableViewAutomaticDimension
        mesTable.estimatedRowHeight = 88
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
}

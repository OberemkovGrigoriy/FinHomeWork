//
//  ViewController.swift
//  homework
//
//  Created by Gregory Oberemkov on 24.09.17.
//  Copyright © 2017 Gregory Oberemkov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var nameState = "name"
    
    func printStateName(name: String){
        print(name)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        nameState = "viewDidLoad"
        printStateName(name: nameState)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameState = "viewWillAppear"
        printStateName(name: nameState)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameState = "viewDidAppear"
        printStateName(name: nameState)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        nameState = "viewWillLayoutSubviews"
        printStateName(name: nameState)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nameState = "viewDidLayoutSubviews"
        printStateName(name: nameState)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        nameState = "viewDidDisappear"
        printStateName(name: nameState)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        nameState = "viewWillDisappear"
        printStateName(name: nameState)
    }

}


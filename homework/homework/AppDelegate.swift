//
//  AppDelegate.swift
//  homework
//
//  Created by Gregory Oberemkov on 24.09.17.
//  Copyright © 2017 Gregory Oberemkov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    enum StateOfProgram {
        case Inactive
        case Active
        case Background
        case Exit
    }
    
    
    var oldState = StateOfProgram.Exit
    var newState: StateOfProgram?
    var methodName: String = "name"
    
    func printState() {
        
        print("Application moved from", terminator: " ")
        
        switch oldState {
        case .Active: print("ACTIVE ")
        case .Inactive: print("INACTIVE ")
        case .Background: print("BACKGORUND ")
        case .Exit: print("EXIT ")
        }
        
        print("to", terminator: " ")
        
        if let stat = newState{
            
            switch stat {
            case .Active: print("ACTIVE ", terminator: " ")
            case .Inactive: print("INACTIVE ", terminator: " ")
            case .Background: print("BACKGORUND ", terminator: " ")
            case .Exit: print("EXIT ", terminator: " ")
            }
            
            oldState = stat
        }
        
        print(": \(methodName)")
    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {//1
        // Override point for customization after application launch.
        newState = .Inactive
        methodName = "application"
        printState()
        newState = .Active
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {//3
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        newState = .Inactive
        methodName = "applicationWillResignActive"
        printState()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {//5
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        newState = .Background
        methodName = "applicationDidEnterBackground"
        printState()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {//4
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        newState = .Inactive
        methodName = "applicationWillEnterForeground"
        printState()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {//2
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        newState = .Active
        methodName = "applicationDidBecomeActive"
        printState()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        newState = .Exit
        methodName = "applicationWillTerminate"
        printState()
    }


}


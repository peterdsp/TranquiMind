//
//  AppDelegate.swift
//  TranquiMind


import UIKit
import AVFoundation
import Purchases

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var audioSession = AVAudioSession.sharedInstance()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        Purchases.logLevel = .debug
        Purchases.configure(withAPIKey: "appl_rqKzdNizctgXVjoeUKGobtFJzDG")
        do {
            try audioSession.setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.moviePlayback)
            application.beginReceivingRemoteControlEvents()
        }
        catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }
        
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//        application.beginReceivingRemoteControlEvents()
        let playerViewController = window?.rootViewController as! PlayerViewController
        playerViewController.disconnectAVPlayer()
        let videoViewController = window?.rootViewController as! VideoViewController
        videoViewController.disconnectAVPlayer()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
//        application.beginReceivingRemoteControlEvents()
        let playerViewController = window?.rootViewController as! PlayerViewController
        playerViewController.reconnectAVPlayer()
        let videoViewController = window?.rootViewController as! VideoViewController
        videoViewController.reconnectAVPlayer()
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

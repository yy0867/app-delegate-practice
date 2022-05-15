//
//  AppDelegate.swift
//  AppDelegatePractice
//
//  Created by 김세영 on 2022/05/14.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var notificationId: Int = 0

    // MARK: - App Become Launching
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.badge, .alert, .sound]
        ) { (granted, error) in
            if granted {
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            }
        }
        
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }
    
    // MARK: - App Become Active
    func applicationDidBecomeActive(_ application: UIApplication) {
        let request = createNotificationRequest(title: "active", body: "app become active.")
        
        UNUserNotificationCenter.current().add(request)
    }
    
    // MARK: - App Become Inactive
    func applicationWillResignActive(_ application: UIApplication) {
        let request = createNotificationRequest(title: "inactive", body: "app become inactive.")
        
        UNUserNotificationCenter.current().add(request)
    }
    
    // MARK: - App Become Background
    func applicationDidEnterBackground(_ application: UIApplication) {
        let request = createNotificationRequest(title: "background", body: "app become background.")
        
        UNUserNotificationCenter.current().add(request)
    }
    
    // MARK: - App Become Terminate
    func applicationWillTerminate(_ application: UIApplication) {
        let request = createNotificationRequest(title: "terminate", body: "app terminated.")
        
        UNUserNotificationCenter.current().add(request)
    }
    
    private func createNotificationRequest(title: String, body: String) -> UNNotificationRequest {
        let content = UNMutableNotificationContent()
        content.title = "AppDelegatePractice 상태 변화"
        content.subtitle = title
        content.body = body

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1.5, repeats: false)
        
        notificationId += 1
        return UNNotificationRequest(
            identifier: "AppDelegatePractices \(notificationId)",
            content: content,
            trigger: trigger
        )
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .badge, .sound, .banner])
    }
}

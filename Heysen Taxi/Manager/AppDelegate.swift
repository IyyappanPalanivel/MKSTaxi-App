//
//  AppDelegate.swift
//  HyraApp
//
//  Created by muthuraja on 21/03/21.
//

import UIKit
import GoogleMaps
import GooglePlaces
import FirebaseCore
import FirebaseMessaging
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window:UIWindow?
    let locationManager = CLLocationManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        FirebaseApp.configure()
        registerForPushNotifications()
        Messaging.messaging().delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        GMSPlacesClient.provideAPIKey(Constant.Googlekey.key)
        GMSServices.provideAPIKey(Constant.Googlekey.key)
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        if #available(iOS 10.0, *) {
          UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        } else {
          let settings: UIUserNotificationSettings =
          UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()
        print("APP DELEGETE ::\(UserDefaults.standard.string(forKey: Userdefaultskey.authToken))")
        if UserDefaults.standard.bool(forKey: Userdefaultskey.logintype) {
            Switcher.SwitcherVc(type: .home)
        } else {
            Switcher.SwitcherVc(type: .login)
        }
        return true
    }
    
    func registerForPushNotifications() {
      //1
      UNUserNotificationCenter.current()
        //2
        .requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
          //3
          print("Permission granted: \(granted)")
        }
    }
}

extension AppDelegate : MessagingDelegate, UNUserNotificationCenterDelegate, CLLocationManagerDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("TOkensssss", fcmToken)
        UserDefaults.standard.set(fcmToken ?? "", forKey: Userdefaultskey.fcmToken)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        print(userInfo)
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print(userInfo)
        completionHandler()
    }
}

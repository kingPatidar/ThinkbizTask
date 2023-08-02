//
//  Alert.swift
//  TestiTuneDemo
//
//  Created by Apple on 02/08/23.
//

import UIKit

class Alert{
    
    private var alertWindow: UIWindow
    static var shared = Alert()
    
    init() {
        alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindow.Level.alert + 1
        alertWindow.makeKeyAndVisible()
        alertWindow.isHidden = true
    }
    
    //MARK: - Single button with default titles (OK) 
    
    func showAlert(title:String? = appName, message:String?){
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title:title, message: message, preferredStyle:.alert)
            alert.addAction(UIAlertAction(title: "OK", style:.default, handler:{(alert) in
                self.alertWindow.isHidden = true
            }))
            self.alertWindow.isHidden = false
            self.alertWindow.rootViewController?.present(alert, animated: false)
        }
    }
}

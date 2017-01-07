//
//  ViewController.swift
//  FirebaseAuth
//
//  Created by Rama Milaneh on 12/17/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class MainViewController: UIViewController {
    
    
   var logoutButton = UIButton()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("main VC")
        view.backgroundColor = UIColor.white
        setupLogoutButton()
        
    }
    
    func setupLogoutButton() {
        
        logoutButton.frame = CGRect(x: 12, y: 15, width: 80, height: 50)
        view.addSubview(logoutButton)
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setTitleColor(UIColor.blue, for: .normal)
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
    }

    
    
    func logout() {
        
        do{
            try FIRAuth.auth()?.signOut()
            GIDSignIn.sharedInstance().signOut()
        }catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        NotificationCenter.default.post(name: .closeMainVC, object: nil)
    }
}


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
import FBSDKLoginKit
import FBSDKShareKit
import FBSDKCoreKit
import TwitterKit

class MainViewController: UIViewController {
    
    
   var logoutButton = UIButton()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
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
            if FirebaseManager.sharedInstance.facebookBool {
                let alertController = UIAlertController(title: "Alert", message: "If you want to log out and sign in with different Facebook account, you should logout from your Facebook page first then log in to the app again", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alertController.addAction(action)
                    self.present(alertController, animated: true, completion: nil)
                FBSDKLoginManager().logOut()
            }
            if FirebaseManager.sharedInstance.gooleBool {
                GIDSignIn.sharedInstance().signOut()
            }
            if FirebaseManager.sharedInstance.twitterBool {
                let store = Twitter.sharedInstance().sessionStore
                if let userID = store.session()?.userID {
                    store.logOutUserID(userID)
                }
            }
            try FIRAuth.auth()?.signOut()
            
    
        }catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        NotificationCenter.default.post(name: .closeMainVC, object: nil)

    }
}


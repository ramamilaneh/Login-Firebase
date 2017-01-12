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
        print("logout tapped")
        
        
        do{
            if FirebaseManager.sharedInstance.faceBool {
                let alertController = UIAlertController(title: "Alert", message: "If you want to log out and sign in with different Facebook account, you should logout from your Facebook page first then log in to the app again", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alertController.addAction(action)
              //  DispatchQueue.main.async {
                    self.present(alertController, animated: true, completion: nil)
                    
            //    }
                FBSDKLoginManager().logOut()
                
            }

            try FIRAuth.auth()?.signOut()
            GIDSignIn.sharedInstance().signOut()
            
    
        }catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        NotificationCenter.default.post(name: .closeMainVC, object: nil)

    }
}


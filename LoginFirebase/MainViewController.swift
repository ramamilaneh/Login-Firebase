//
//  ViewController.swift
//  FirebaseAuth
//
//  Created by Rama Milaneh on 12/17/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController {
    
    
   var logoutButton = UIButton()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        logoutButton.frame = CGRect(x: 12, y: 15, width: 80, height: 50)
        view.addSubview(logoutButton)
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setTitleColor(UIColor.blue, for: .normal)
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        
    }
    
    

    func logout() {
        
        do{
            try FIRAuth.auth()?.signOut()

        }catch let error{
            print(error)
            print("errrrrror")
        }
      let destVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login-view-controller") as! LoginViewController
        present(destVC, animated: true)
        
    }
}


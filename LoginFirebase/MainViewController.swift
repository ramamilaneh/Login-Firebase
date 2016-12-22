//
//  ViewController.swift
//  FirebaseAuth
//
//  Created by Rama Milaneh on 12/17/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
       view.backgroundColor = UIColor.white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
    }

    func logout() {
        
      let destVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login-view-controller") as! LoginViewController
        present(destVC, animated: true)
        
    }
}


//
//  FirebaseManager.swift
//  LoginFirebase
//
//  Created by Rama Milaneh on 12/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import UIKit

class FirebaseManager {
    
    class func createAccount(with email: String, and password: String) {
        
        FIRAuth.auth()!.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                FirebaseManager.signIn(with: email, and: password, completion: { (success) in
                    if success {
                        print("sing in successful")
                    }else{
                        print("sing in faild")
                        
                    }
                })
                
            } else {
                
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: .closeAccountVC, object: nil)
                    
                }
            }
        })
    }
    
    class func signIn(with email: String, and password: String, completion:@escaping (Bool)->Void) {
        
        FIRAuth.auth()!.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                DispatchQueue.main.async {
                    
                    NotificationCenter.default.post(name: .closeLoginVC, object: nil)
                    completion(true)
                }
            }else{
                print("errrrrror")
                completion(false)
            }
        })
    }
}

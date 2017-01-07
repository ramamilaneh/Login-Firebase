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
    
    class func createAccount(with email: String, and password: String, completion:@escaping (Bool)->Void) {
        
        FIRAuth.auth()!.createUser(withEmail: email, password: password, completion: { (user, error) in
            if user != nil {
                FirebaseManager.signIn(with: email, and: password, completion: { (success) in
                    if success {
                        print("sing in successful")
                        completion(true)
                    }else{
                        print("sing in faild")
                        completion(false)
                    }
                })

            }
        })
    }
    
    class func signIn(with email: String, and password: String, completion:@escaping (Bool)->Void) {
        
        FIRAuth.auth()!.signIn(withEmail: email, password: password, completion: { (user, error) in
            if user != nil {
                    completion(true)
            }else{
                print("errrrrror")
                completion(false)
            }
        })
    }
}

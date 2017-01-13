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
import GoogleSignIn
import TwitterKit

class FirebaseManager: NSObject {
    
    static let sharedInstance = FirebaseManager()
    var faceBool = false
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
    
    class func signInWithTwitter() {
        Twitter.sharedInstance().logIn(withMethods: .webBased) { (session, error) in

            if error != nil {
                print(error?.localizedDescription)
            }else{
            if session != nil {
                if let unwrappedSession = session {
                    let token = unwrappedSession.authToken
                    let secret = unwrappedSession.authTokenSecret
                    let credentials = FIRTwitterAuthProvider.credential(withToken: token, secret: secret)
                    FIRAuth.auth()?.signIn(with: credentials, completion: { (user, error) in
                        if let error = error {
                            print(error.localizedDescription)
                            let alert = UIAlertController(title: "error", message: "\(error.localizedDescription)", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                            alert.addAction(okAction)
                        }else{
                            DispatchQueue.main.async {
                                NotificationCenter.default.post(name: .closeLoginVC, object: nil)
                            }
                        }
                        
                    })
                }
            }
        }
        }
    }
}
extension FirebaseManager: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            print(error.localizedDescription)
            let alert = UIAlertController(title: "error", message: "\(error.localizedDescription)", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)

        }else{
            print("successful login")
        }
        if let user = user {
        let idtoken = user.authentication.idToken ?? ""
        let accessToken = user.authentication.accessToken ?? ""
        let credentials = FIRGoogleAuthProvider.credential(withIDToken: idtoken, accessToken: accessToken)
        FIRAuth.auth()?.signIn(with: credentials, completion: { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                let alert = UIAlertController(title: "error", message: "\(error.localizedDescription)", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alert.addAction(okAction)
            }else{
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: .closeLoginVC, object: nil)
                }
            }
            
        })
        }
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
        }else{
            print("successful login")
            do{
                try FIRAuth.auth()?.signOut()
                
            }catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }

        }
    }
    
}


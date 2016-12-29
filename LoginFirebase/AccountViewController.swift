//
//  CreateAccountViewController.swift
//  FirebaseAuth
//
//  Created by Rama Milaneh on 12/20/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import UIKit
import Whisper
import Firebase

class AccountViewController: UIViewController, UITextFieldDelegate {
    
    
    var createView: CreateAccountView!
    var password: String? = nil
    var isEmailValid: Bool = false
    var isPasswordValid: Bool = false
    var isConfirmPasswordValid: Bool = false
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("create VC")

        self.createView = CreateAccountView(frame: self.view.frame)
        self.view.addSubview(createView)
        self.createView.translatesAutoresizingMaskIntoConstraints = false
        self.createView.constrainEdges(to: self.view)
        self.createView.delegate = self
        self.createView.emailTextField.delegate = self
        self.createView.passwordTextField.delegate = self
        self.createView.confirmPasswordTextField.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.createView.contentView.insertGradianPinkColor()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case createView.emailTextField:
            isEmailValid = validateEmail(text: createView.emailTextField.text!)
            break
        case createView.passwordTextField:
            isPasswordValid = validatePassword(text: createView.passwordTextField.text!)
            break
        case createView.confirmPasswordTextField:
            isConfirmPasswordValid = validatePasswordConfirm(text: createView.confirmPasswordTextField.text!)
            break
        default:
            break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.createView.emailTextField {
            self.createView.emailTextField.becomeFirstResponder()
        }
        if textField == self.createView.passwordTextField {
            self.createView.passwordTextField.resignFirstResponder()
        }
        if textField == self.createView.confirmPasswordTextField {
            self.createView.confirmPasswordTextField.resignFirstResponder()
        }
        
        
        return true
    }
    
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
}

extension AccountViewController: CreateAccountDelegate {
    
    func signUpTapped(with sender: CreateAccountView) {
        
        if checkIfAllFieldsValid() {
        
        if let email = self.createView.emailTextField.text, let password = self.createView.passwordTextField.text {
                FirebaseManager.createAccount(with: email, and: password)

            }
                    
        let destVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "main-view-controller") as! MainViewController
            self.present(destVC, animated: true, completion: nil)
           
       }
        
    }
    
    func cancelTapped(with sender: CreateAccountView) {
        dismiss(animated: true, completion: nil)
    }
}

extension AccountViewController {
    
    func validateEmail(text: String) -> Bool {
        if !(text.characters.count > 0) {
            print("check validation")
            UserNotification.showError(ErrorMessage.emailEmpty)
            return false
        }
        
        if text.contains("@") && text.contains(".") {
            return true
        } else {
            print("check validation")
            
            UserNotification.showError(ErrorMessage.emailFormat)
            return false
        }
    }
    
    func validatePassword(text: String) -> Bool {
        if !(text.characters.count > 0) {
            print("check validation")
            
            UserNotification.showError(ErrorMessage.passwordEmpty)
            return false
        }
        if text.characters.count >= 6 {
            password = text
            return true
        }
        UserNotification.showError(ErrorMessage.passwordLength)
        return false
    }
    
    func validatePasswordConfirm(text: String) -> Bool {
        if !(text.characters.count > 0) {
            UserNotification.showError(ErrorMessage.confirmPasswordEmpty)
            return false
        }
        if let password = password {
            let isMatch = text == password
            if !isMatch {
            }
            return isMatch
        }
        UserNotification.showError(ErrorMessage.confirmPasswordMatch)
        return false
    }
    
    func checkIfAllFieldsValid() -> Bool {
        if isEmailValid && isPasswordValid && isConfirmPasswordValid {
            return true
        }
        UserNotification.showError(ErrorMessage.fieldsNotCorrect)
        return false
    }
}

//
//  Constant.swift
//  FirebaseAuth
//
//  Created by Rama Milaneh on 12/21/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import UIKit
import Whisper

struct UserNotification {
    
    
    
    static func show(_ notification: String) {
        
        var murmur = Murmur(title: notification)
        murmur.titleColor = UIColor.red
        murmur.backgroundColor = UIColor.white
        let whistleAction = WhistleAction.show(3.0)
        Whisper.show(whistle: murmur, action: whistleAction)
    }
    
    static func showError(_ notification: String) {
        
        var murmur = Murmur(title: notification)
        murmur.titleColor = UIColor.red
        murmur.backgroundColor = UIColor.white
        let whistleAction = WhistleAction.show(3.0)
        Whisper.show(whistle: murmur, action: whistleAction)
        
    }
}


struct ErrorMessage {
    
    static var authFailed = "User authentication failed. Please make sure password is correct"
    static var passwordEmpty = "Current password cannot be empty"
    static var confirmPasswordEmpty = "Confirm password cannot be empty"
    static var newPasswordEmpty = "New password cannot be empty"
    static var confirmPasswordMatch = "New and confirm passwords do not match"
    static var passwordLength = "Password length must be at least 6 characters"
    static var passwordUpdate = "Failed to change password"
    static var emailEmpty = "Email cannot be empty"
    static var emailFormat = "Email format is incorrect"
    static var emailAlreadyInUse = "Email is already in use"
    static var invalidEmail = "Email is invalid"
    static var generalEmail = "Error changing email"
    static var fieldsNotCorrect = "Please make sure email or password are correct"
    static var changePasswordFieldsNotCorrect = "Please make sure all password fields are valid"
}

struct SuccessMessage {
    
    static var passwordChanged = "Password successfully changed"
    static var emailChanged = "Email successfully changed"
}

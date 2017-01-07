//
//  Extensions.swift
//  LoginFirebase
//
//  Created by Rama Milaneh on 12/29/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UIView Extension
extension UIView {
    
    // create gradient color for the CreateAccount view
    func insertGradianPinkColor() {
        let firstColor = UIColor(red: 76/255, green: 48/255, blue: 57/255, alpha: 1).cgColor
        let secondColor = UIColor(red: 158/255, green: 100/255, blue: 117/255, alpha: 1).cgColor
        let thirdColor = UIColor(red: 255/255, green: 161/255, blue: 189/255, alpha: 1).cgColor
        let gradian: CAGradientLayer
        gradian = CAGradientLayer()
        gradian.colors = [ firstColor,secondColor,thirdColor]
        gradian.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradian.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradian.frame = self.frame
        self.layer.insertSublayer(gradian, at: 0)
        
        
    }
    
    // constrain the view to the edges of the super view
    func constrainEdges(to view: UIView) {
        
        leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    // create gradient color for the login view
    func insertgradianPinkColor() {
        let firstColor = UIColor(red: 76/255, green: 48/255, blue: 57/255, alpha: 1).cgColor
        let secondColor = UIColor(red: 158/255, green: 100/255, blue: 117/255, alpha: 1).cgColor
        let gradian: CAGradientLayer
        gradian = CAGradientLayer()
        gradian.colors = [ firstColor,secondColor,firstColor]
        gradian.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradian.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradian.frame = self.frame
        self.layer.insertSublayer(gradian, at: 0)
        
        
    }

    
}

// MARK: - Notification Extension
extension Notification.Name {
    
    static let closeLoginVC = Notification.Name("close-login-view-controller")
    static let closeAccountVC = Notification.Name("create-account-view-controller")
    static let closeMainVC = Notification.Name("close-main-view-controller")
    
}

// MARK: - TextField Extension
extension UITextField {
    
    // add padding to the text
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    // Setup the TextField
    func setup() {
        
        let textcolor = UIColor(red: 253/255, green: 255/255, blue: 169/255, alpha: 1)
        self.backgroundColor = UIColor.clear
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor(red: 158/255, green: 100/255, blue: 117/255, alpha: 1).cgColor
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        self.textColor = textcolor
        self.setLeftPaddingPoints(25)
        self.isSecureTextEntry = true
        
    }
}

// MARK: - UIButton Extension
extension UIButton {
    
    func setup() {
        
        let textcolor = UIColor(red: 253/255, green: 255/255, blue: 169/255, alpha: 1)
        self.backgroundColor = UIColor(red: 255/255, green: 161/255, blue: 189/255, alpha: 1)
        self.titleLabel?.font = UIFont(name: "Times New Roman Bold", size: 19)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        self.setTitleColor(textcolor, for: .normal)
        self.clipsToBounds = true
        self.layer.cornerRadius = 27
        
    }
}

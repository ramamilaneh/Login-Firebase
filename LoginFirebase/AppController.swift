//
//  AppController.swift
//  FirebaseAuth
//
//  Created by Rama Milaneh on 12/20/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import Firebase
import FacebookLogin
import FacebookCore



 final class AppController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    var actingVC: UIViewController!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInitialViewController()
       

    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        containerView.insertGradianPinkColor()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


    // MARK: - Notficiation Observers
    extension AppController {
        
        func addNotificationObservers() {
            NotificationCenter.default.addObserver(self, selector: #selector(switchViewController(with:)), name: .closeLoginVC, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(switchViewController(with:)), name: .closeMainVC, object: nil)
        }
        
    }

// MARK: - Loading VC's
extension AppController {
    
    func loadInitialViewController() {
//        let id: StoryboardID = FIRAuth.auth()?.currentUser != nil ? .mainVC : .loginVC
        let id: StoryboardID = .loginVC
       self.actingVC = self.loadViewController(withID: id)
       self.add(viewController: self.actingVC, animated: true)
    }
    
    func loadViewController(withID id: StoryboardID) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: id.rawValue)
    }
    
}


// MARK: - Displaying VC's
extension AppController {
    
    func add(viewController: UIViewController, animated: Bool = false) {
        self.addChildViewController(viewController)
        containerView.addSubview(viewController.view)
        containerView.alpha = 0.0
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParentViewController: self)
        
        guard animated else { containerView.alpha = 1.0; return }
        
        UIView.transition(with: containerView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.containerView.alpha = 1.0
        }) { _ in }
    }
    
    func switchViewController(with notification: Notification) {
        switch notification.name {
        case Notification.Name.closeLoginVC:
            switchToViewController(with: .mainVC)
        case Notification.Name.closeMainVC:
            switchToViewController(with: .loginVC)
        default:
            fatalError("\(#function) - Unable to match notficiation name.")
        }
        
    }
    
    private func switchToViewController(with id: StoryboardID) {
        let existingVC = actingVC
        existingVC?.willMove(toParentViewController: nil)
        actingVC = loadViewController(withID: id)
        add(viewController: actingVC)
        actingVC.view.alpha = 0.0
        
        UIView.animate(withDuration: 0.8, animations: {
            self.actingVC.view.alpha = 1.0
            existingVC?.view.alpha = 0.0
        }) { success in
            existingVC?.view.removeFromSuperview()
            existingVC?.removeFromParentViewController()
            self.actingVC.didMove(toParentViewController: self)
        }
        
    }
    
    
}


// MARK: - Notification Extension
extension Notification.Name {
    
    static let closeLoginVC = Notification.Name("close-login-view-controller")
    static let closeMainVC = Notification.Name("close-main-view-controller")
    
}


// MARK: - UIView Extension


extension UIView {
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

}

//
//  AppController.swift
//  FirebaseAuth
//
//  Created by Rama Milaneh on 12/20/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import Firebase
//import FacebookLogin
//import FacebookCore



 final class AppController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    var actingVC: UIViewController!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        addNotificationObservers()
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
            NotificationCenter.default.addObserver(self, selector: #selector(switchViewController(with:)), name: .openMainVC, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(switchViewController(with:)), name: .openCreateVC, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(switchViewController(with:)), name: .closeCreateVC, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(switchViewController(with:)), name: .closeCreateVCToLogin, object: nil)
            
        }
        
    }

// MARK: - Loading VC's
extension AppController {
    
    func loadInitialViewController() {
        
       let id: StoryboardID = FIRAuth.auth()?.currentUser?.uid != nil ? .mainVC : .loginVC
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
        case Notification.Name.closeCreateVC:
            switchToViewController(with: .mainVC)
        case Notification.Name.closeCreateVCToLogin:
            switchToViewController(with: .loginVC)
        case Notification.Name.openMainVC:
            switchToViewController(with: .mainVC)
        case Notification.Name.openCreateVC:
            switchToViewController(with: .accountVC)
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
        
        UIView.animate(withDuration: 0.3, animations: {
            self.actingVC.view.alpha = 1.0
            existingVC?.view.alpha = 0.0
        }) { success in
            existingVC?.view.removeFromSuperview()
            existingVC?.removeFromParentViewController()
            self.actingVC.didMove(toParentViewController: self)
        }
        
    }
    
        
    
}






//
//  ViewController.swift
//  NumberLogin
//
//  Created by mahavir on 10/07/17.
//  Copyright © 2017 mobileFirst. All rights reserved.
//

import UIKit
import AccountKit


class ViewController: UIViewController{
    
    let ACCOUNT_KIT = AKFAccountKit(responseType: .accessToken)
    
    @IBOutlet var lblShow: UILabel!
    
    @IBAction func loginWithNum(_ sender: UIButton)
    {
    
        if let accountKitPhoneLoginVC = ACCOUNT_KIT.viewControllerForPhoneLogin(with: nil, state: nil) as? AKFViewController{
            
            accountKitPhoneLoginVC.whitelistedCountryCodes = ["IN"]
            let theme = AKFTheme(primaryColor: UIColor.orange, primaryTextColor: UIColor.white, secondaryColor: UIColor.lightGray, secondaryTextColor: UIColor.black, statusBarStyle: .lightContent)
            accountKitPhoneLoginVC.setTheme(theme)
            
            let image :UIImage = UIImage(named: "ABC.png")!
            
            accountKitPhoneLoginVC.uiManager = AKFSkinManager(skinType: .contemporary, primaryColor: UIColor.orange, backgroundImage: image, backgroundTint: .black, tintIntensity: 0.1)
            
            
            accountKitPhoneLoginVC.enableSendToFacebook = true

            accountKitPhoneLoginVC.delegate = self
            
            present(accountKitPhoneLoginVC as! UIViewController, animated: true, completion: nil)
            
        }
    }
    
    

    @IBAction func loginWithEmail(_ sender: UIButton) {
        
        if let accountKitEmailLoginVC = ACCOUNT_KIT.viewControllerForEmailLogin(withEmail: nil, state: nil) as? AKFViewController{
            
            let image1 :UIImage = UIImage(named: "ABC.png")!
            
            accountKitEmailLoginVC.uiManager = AKFSkinManager(skinType: .contemporary, primaryColor: UIColor.orange, backgroundImage: image1, backgroundTint: .black, tintIntensity: 0.1)
            

            accountKitEmailLoginVC.enableSendToFacebook = true
            
            accountKitEmailLoginVC.delegate = self
            
            present(accountKitEmailLoginVC as! UIViewController, animated: true, completion: nil)
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
}


extension ViewController : AKFViewControllerDelegate{
    
    
    
    func viewController(viewController: UIViewController!, didCompleteLoginWithAuthorizationCode code: String!, state: String!) {
        
        print("didCompleteLoginWithAuthorizationCode")
        
    }
    
    func viewController(viewController: UIViewController!, didCompleteLoginWithAccessToken accessToken: AKFAccessToken!, state: String!) {
        
        ACCOUNT_KIT.requestAccount({ (account:AKFAccount?, error:NSError?) in
            
            if let phoneNumber = account?.phoneNumber?.stringRepresentation(){
                
                print(phoneNumber)
                
                self.lblShow.text = "LoggedIn with \(phoneNumber)"
            }
            if let emailAddress = account?.emailAddress{
                
                print(emailAddress)
                
                self.lblShow.text = "LoggedIn with \(emailAddress)"
                
            }
            
            if let accountID = account?.accountID{
                
                print(accountID)
            }
            
            } as! AKFRequestAccountHandler)
        
    }
    
    func viewController(viewController: UIViewController!, didFailWithError error: NSError!) {
        
        print("didFailWithError: \(error)")
        
    }
    
    func viewControllerDidCancel(viewController: UIViewController!) {
        
        print("viewControllerDidCancel")
        
    }
 
}

//extension ViewController:AKFConfiguring{
//
//}

    

//
//  ViewController.swift
//  AppleAuth
//
//  Created by Swayam Infotech on 24/09/20.
//  Copyright © 2020 Swayam Infotech. All rights reserved.
//

import UIKit
import AuthenticationServices

class Login: UIViewController {

    // define outlets for apple button.
    @IBOutlet weak var viewAppleButton: UIView!
    @IBOutlet weak var viewNotSupport: UIView!
    @IBOutlet weak var custonAppleButton: UIButton!
    @IBOutlet weak var lblContinueWithApple: UILabel!
    @IBOutlet weak var lblNotSupport: UILabel!
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        //to add apple button
        if #available(iOS 13.0, *) {
            // to add default apple button for login.
            addAppleButton()
        }else{
            // to show apple button support errors.
            viewNotSupport.isHidden = false
            viewAppleButton.isHidden = true
        }
        
        // set localized strings for the screen.
        setLocalizedStrings()
    }

    func setLocalizedStrings() {

        lblNotSupport.text = "apple_sign_in_not_support".localized
        lblContinueWithApple.text = "login_apple".localized
    }
    
    func setUpSignInAppleButton() {

        if #available(iOS 13.0, *) {
            let authorizationAppleButton = ASAuthorizationAppleIDButton()
            authorizationAppleButton.addTarget(self, action: #selector(self.handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
            authorizationAppleButton.center = view.center
            self.view.addSubview(authorizationAppleButton)
        } else {
           
        }
    }
    
    func addAppleButton() {

        if showCustomButton == 0 {
            setUpSignInAppleButton()
            viewAppleButton.isHidden = true
        }else{
            custonAppleButton.addTarget(self, action: #selector(self.handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
            viewAppleButton.isHidden = false
        }
    }

    //to handle apple sign in button action
    @objc func handleAuthorizationAppleIDButtonPress() {

        if #available(iOS 13.0, *) {

            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        } else {
            viewNotSupport.isHidden = false
        }
    }
}

extension Login: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        switch authorization.credential {

        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            //save detail of your in your system.
            let firstName = appleIDCredential.fullName?.givenName ?? "N/A"
            let lastName = appleIDCredential.fullName?.familyName ?? "N/A"
            let fullName = appleIDCredential.fullName?.description ?? "N/A"
            let email = appleIDCredential.email ?? "N/A"
            let userId = appleIDCredential.user
                
            let userDics = ["fullName": fullName, "firstName":firstName, "lastName": lastName, "email": email, "userId": userId]
            
            let vc = Util.getStoryboard().instantiateViewController(withIdentifier: "Profile") as! Profile
            vc.user = User(data: userDics)
            SharedAppDelegate.navigationControl.pushViewController(vc, animated: true)
            
        default:
            print("error in apple login")
            break
        }
        
    }
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
}

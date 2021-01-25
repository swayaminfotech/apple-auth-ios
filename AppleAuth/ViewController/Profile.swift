//
//  Profile.swift
//  AppleAuth
//
//  Created by Swayam Infotech on 24/09/20.
//  Copyright © 2020 Swayam Infotech. All rights reserved.
//

import UIKit

class Profile: UIViewController {
    
    // define outlets for profile detail.
    @IBOutlet weak var viewProfile: UIView!
    @IBOutlet weak var lblFirstName: UILabel!
    @IBOutlet weak var lblLastName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblAppleID: UILabel!

    var user = User(data: [:])

    override func viewDidLoad() {

        super.viewDidLoad()
        
        // set theme color to profile details
        lblFirstName.textColor = theamColor
        lblLastName.textColor = theamColor
        lblEmail.textColor = theamColor
        lblAppleID.textColor = theamColor
        
        // to get apple user details.
        getUserDetail()
    }
    
    func getUserDetail() {

        // to display logged in user data.
        lblFirstName.text = "First Name: " + "N/A"
        lblLastName.text = "Last Name: " + "N/A"
        lblEmail.text = "Email: " + "N/A"
        lblAppleID.text = "Apple ID: " + "N/A"
        
        if !Util.isStringNull(srcString: user.firstName) {
            lblFirstName.text = "First Name: " + user.firstName
        }
        if !Util.isStringNull(srcString: user.lastName) {
            lblLastName.text = "Last Name: " + user.lastName
        }
        if !Util.isStringNull(srcString: user.email) {
            lblEmail.text = "Email: " + user.email
        }
        if !Util.isStringNull(srcString: user.userID) {
            lblAppleID.text = "Apple ID: " + user.userID
        }
    }
}

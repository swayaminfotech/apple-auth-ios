//
//  User.swift
//  AppleAuth
//
//  Created by Swayam Infotech on 24/09/20.
//  Copyright © 2020 Swayam Infotech. All rights reserved.
//

import Foundation
import UIKit

struct User {

    var fullName: String = "N/A"
    var firstName: String = "N/A"
    var lastName: String = "N/A"
    var email: String = "N/A"
    var userID: String = "N/A"

    init(data: [String:Any]) {

        // to save fullname of user.
        if let fullNameValue = data["fullName"] as? String {
            self.fullName = fullNameValue
        }

        // to save firstname of user.
        if let firstNameValue = data["firstName"] as? String {
            self.firstName = firstNameValue
        }

        // to save lastname of user.
        if let lastNameValue = data["lastName"] as? String {
            self.lastName = lastNameValue
        }

        // to save email of user.
        if let emailValue = data["email"] as? String {
            self.email = emailValue
        }

        // to save user id.
        if let userIDValue = data["userId"] as? String {
            self.userID = userIDValue
        }
    }
}

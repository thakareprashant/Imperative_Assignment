//
//  Constants.swift
//  MyAssignment
//
//  Created by pthakare on 27/06/24.
//

import Foundation

struct Constants {
    static let webURL = "https://theimperative.in"
    static let professionArray = ["Business", "Profession", "Employee"]
}

struct Dialogs {
    static let acceptPolicyMessage = "Please accept our policy"
    static let thankMessagePolicy = "Thank you for accepting our policy"
    static let detailsSaveMessage = "Your Details Saved Successfully...."
    static let enterTitleMessage = "Please Enter tile"
    static let enterFirstNameMessage = "Please Enter First name"
    static let invalidMobile = "Invalid Mobile Number"
    static let emptyMail = "Please Enter Email address"
    static let invalidMail = "Invalid Email address"
    static let validAddress = "Please Enter your address"
    static let enterFatherName = "Please Enter father name"
    static let enterMotherName = "Please Enter mother name"
    static let locationPermission = "Please give location permission in setting"
    static let emptyUserName = "Please enter username "
    static let emptyPassword = "Please enter password"
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

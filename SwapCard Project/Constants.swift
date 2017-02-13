//
//  Constants.swift
//  SwapCard Project
//
//  Created by Aditya Vikram Godawat on 11/02/17.
//  Copyright © 2017 Aditya Vikram Godawat. All rights reserved.
//

import UIKit


// MARK: - Variables

var _BLACK_VIEW = UIView()
var _IP = "https://randomuser.me/api/?results=10"
var _USERS = [Users]()


// MARK: - Displaying Black Screen

func SHOW_BLACK_SCREEN() {
    
    _BLACK_VIEW = UIView(frame: UIScreen.main.bounds)
    _BLACK_VIEW.backgroundColor = UIColor.black
    _BLACK_VIEW.alpha = 0.75
    
    let aMainWindow = UIApplication.shared.delegate!.window
    aMainWindow!!.addSubview(_BLACK_VIEW)
    
    let aLoadingImage = UIActivityIndicatorView()
    aLoadingImage.color = .white
    aLoadingImage.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
    aLoadingImage.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
    
    _BLACK_VIEW.addSubview(aLoadingImage)
    aLoadingImage.startAnimating()
}


// MARK: - Removing Black Screen

func REMOVE_BLACK_SCREEN() {
    _BLACK_VIEW.removeFromSuperview()
}


// MARK: - Custom Class

class Users {
    var cell = String()
    var city = String()
    var dateOfBirth = String()
    var email = String()
    var firstName = String()
    var gender = String()
    var lastName = String()
    var nationality = String()
    var phone = String()
    var picture: UIImage!
    var postCode: Any!
    var registrationDate = String()
    var state = String()
    var street = String()
    var title = String()
    var username = String()
}

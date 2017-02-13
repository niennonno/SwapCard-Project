//
//  UserDetailsViewController.swift
//  SwapCard Project
//
//  Created by Aditya Vikram Godawat on 12/02/17.
//  Copyright © 2017 Aditya Vikram Godawat. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController {

    // MARK: - Variables
    
    var user = Users()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "User Details"
        
    }
    
    func setupView() {
        
        //Variables
        let aPadding = CGFloat(15)
        let aMaxWidth = self.view.bounds.width
        let aMaxHeight = self.view.frame.height
        
        //ScrollView
        
        let aFrame = CGRect(x: 0, y:  0, width: aMaxWidth, height: aMaxHeight)
        
        let aScrollView = UIScrollView(frame: aFrame)
        aScrollView.showsVerticalScrollIndicator = true
        view.addSubview(aScrollView)
        
        //ImageView
        let anImageView = UIImageView(image: user.picture)
        anImageView.contentMode = .scaleAspectFill
        anImageView.frame = CGRect(x: 0, y: 0, width: anImageView.frame.width, height: anImageView.frame.width)
        anImageView.layer.cornerRadius = anImageView.frame.width/2
        anImageView.layer.borderColor = UIColor.black.cgColor
        anImageView.layer.borderWidth = 1
        anImageView.layer.masksToBounds = true
        anImageView.center = CGPoint(x: view.center.x, y: 6*aPadding)
        aScrollView.addSubview(anImageView)
        
        //Name and Phone 
        
        let aNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: aMaxWidth-2*aPadding, height: 30))
        aNameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        aNameLabel.textAlignment = .center
        aNameLabel.text = user.title + " " + user.firstName + " " + user.lastName+"(\(user.gender))"
        aNameLabel.center = CGPoint(x: view.center.x, y: anImageView.frame.maxY+2*aPadding)
        aScrollView.addSubview(aNameLabel)
        
        let aPhoneLabel = UILabel(frame: CGRect(x: 0, y: 0, width: aMaxWidth-2*aPadding, height: 60))
        aPhoneLabel.font = UIFont.boldSystemFont(ofSize: 15)
        aPhoneLabel.textAlignment = .center
        aPhoneLabel.numberOfLines = 0
        aPhoneLabel.text = user.phone+"\n"+user.cell+"\n"+user.email
        aPhoneLabel.center = CGPoint(x: view.center.x, y: aNameLabel.frame.maxY+2*aPadding)
        aScrollView.addSubview(aPhoneLabel)

        //Address
        
        var address = NSMutableAttributedString()
        
        if let aNumber =  user.postCode as? Int {
            address = NSMutableAttributedString(string: "Address: \(user.street), \(user.city), \(user.state), \(aNumber)")

        } else if let aString = user.postCode as? String {
            address = NSMutableAttributedString(string: "Address: \(user.street), \(user.city), \(user.state), \(aString)")

        }
        
        var aRange = NSRange(location: 0, length: 8)
        address.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFont(ofSize: 18), range: aRange)
        
        let anAddressLabel = UILabel(frame: CGRect(x: 0, y: 0, width: aMaxWidth-2*aPadding, height: 50))
        anAddressLabel.numberOfLines = 0
        anAddressLabel.attributedText = address
        anAddressLabel.textAlignment = .center
        anAddressLabel.center = CGPoint(x: view.center.x, y: aPhoneLabel.frame.maxY+2*aPadding)
        aScrollView.addSubview(anAddressLabel)

        
        //Address
        let dob = NSMutableAttributedString(string: "Date of Birth: \(user.dateOfBirth)")
        
        aRange = NSRange(location: 0, length: 14)
        dob.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFont(ofSize: 18), range: aRange)
        
        let aDOBLabel = UILabel(frame: CGRect(x: 0, y: 0, width: aMaxWidth-2*aPadding, height: 50))
        aDOBLabel.numberOfLines = 0
        aDOBLabel.attributedText = dob
        aDOBLabel.textAlignment = .center
        aDOBLabel.center = CGPoint(x: view.center.x, y: anAddressLabel.frame.maxY+3*aPadding)
        aScrollView.addSubview(aDOBLabel)
        
        //Username
        let username = NSMutableAttributedString(string: "Username: \(user.username)\nNationality: \(IsoCountryCodes.find(key: user.nationality).name)")
        
        aRange = NSRange(location: 0, length: 9)
        username.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFont(ofSize: 18), range: aRange)
        aRange = NSRange(location: 11+user.username.characters.count, length: 11)
        username.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFont(ofSize: 18), range: aRange)

        let aUsernameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: aMaxWidth-2*aPadding, height: 50))
        aUsernameLabel.numberOfLines = 0
        aUsernameLabel.attributedText = username
        aUsernameLabel.textAlignment = .center
        aUsernameLabel.center = CGPoint(x: view.center.x, y: aDOBLabel.frame.maxY+aPadding)
        aScrollView.addSubview(aUsernameLabel)
        
        //Address
        let aRegistrationDate = NSMutableAttributedString(string: "Date of Registration: \(user.registrationDate)")
        
        aRange = NSRange(location: 0, length: 22)
        aRegistrationDate.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFont(ofSize: 18), range: aRange)
        
        let aDORLabel = UILabel(frame: CGRect(x: 0, y: 0, width: aMaxWidth-2*aPadding, height: 50))
        aDORLabel.numberOfLines = 0
        aDORLabel.attributedText = aRegistrationDate
        aDORLabel.textAlignment = .center
        aDORLabel.center = CGPoint(x: view.center.x, y: aUsernameLabel.frame.maxY+3*aPadding)
        aScrollView.addSubview(aDORLabel)
        
        aScrollView.contentSize = CGSize(width: aMaxWidth, height: aDORLabel.frame.maxY+4*aPadding)

    }
}

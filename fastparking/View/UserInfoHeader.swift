//
//  UserInfoHeader.swift
//  SettingsTemplate
//
//  Created by Stephen Dowless on 2/10/19.
//  Copyright © 2019 Stephan Dowless. All rights reserved.
//

import UIKit

class UserInfoHeader: UIView {
    var user:Users?
    // MARK: - Properties
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "avatar48")
        return iv
    }()
    
    let usernameLabel: UILabel = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // create context
        let context = appDelegate.persistentContainer.viewContext
        // create an entity and records
        var name = ""
        var user:Users
        if let users = try! context.fetch(Users.fetchRequest()) as? [Users] {
            user = users.last!
            if let firstname = user.firstName {
                name = firstname
            }
        }
        
        let label = UILabel()
        label.text = name
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailLabel: UILabel = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // create context
        let context = appDelegate.persistentContainer.viewContext
        // create an entity and records
        var email = ""
        var user:Users
        if let users = try! context.fetch(Users.fetchRequest()) as? [Users] {
            user = users.last!
            if let emailUser = user.email {
                email = emailUser
            }
        }
        
        let label = UILabel()
        label.text = email
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let profileImageDimension: CGFloat = 60
        
        addSubview(profileImageView)
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: profileImageDimension).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: profileImageDimension).isActive = true
        profileImageView.layer.cornerRadius = profileImageDimension / 2
        
        addSubview(usernameLabel)
        usernameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: -10).isActive = true
        usernameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12).isActive = true
        
        addSubview(emailLabel)
        emailLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: 10).isActive = true
        emailLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

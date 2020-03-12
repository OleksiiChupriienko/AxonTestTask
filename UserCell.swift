//
//  UserCell.swift
//  AxonTestTask
//
//  Created by Aleksei Chupriienko on 12.03.2020.
//  Copyright © 2020 Aleksei Chupriienko. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userCounryLabel: UILabel!
    @IBOutlet weak var userCityLabel: UILabel!
    
    
    override func prepareForReuse() {
        userImageView.image = nil
    }
    
    func setup(with user: User) {
        userImageView.downloaded(from: user.picture.large, contentMode: .scaleToFill)
        userImageView.layer.cornerRadius = userImageView.frame.height / 2
        userNameLabel.text = "\(user.name.first) \(user.name.last)"
        userCounryLabel.text = user.location.country
        userCityLabel.text = user.location.city
    }
}

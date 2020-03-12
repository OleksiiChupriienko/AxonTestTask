//
//  DetailViewController.swift
//  AxonTestTask
//
//  Created by Aleksei Chupriienko on 12.03.2020.
//  Copyright © 2020 Aleksei Chupriienko. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var user: User?
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userGenderLabel: UILabel!
    @IBOutlet weak var userDateOfBirth: UILabel!
    @IBOutlet weak var userPhoneLabel: UILabel!
    @IBOutlet weak var userCellLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    private func setUpView() {
        guard let user = user else {
            return
        }
        userImageView.downloaded(from: user.picture.large, contentMode: .scaleAspectFill)
        userImageView.layer.cornerRadius = userImageView.frame.height / 2
        userNameLabel.text = "\(user.name.first) \(user.name.last)"
        userGenderLabel.text = user.gender.rawValue
//      Date of birth in “YYYY-mm-dd” format
        userDateOfBirth.text = String(user.dob.date.prefix(10))
        userPhoneLabel.text = user.phone
        userCellLabel.text = user.cell
    }
    
    private func showAlert(number numberString: String) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let callAction = UIAlertAction(title: "Call \(user?.name.first ?? "this number")", style: .default) { (action) in
//          To make valid phone number, cut off non-digits
            let number = numberString.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            let app = UIApplication.shared
            if let url = URL(string: "tel://\(number)"),  app.canOpenURL(url) {
                app.open(url)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(callAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    @IBAction func tapPhoneLabel(_ sender: UITapGestureRecognizer) {
        if let number = userPhoneLabel.text {
            showAlert(number: number)
        }
    }
   
    @IBAction func tapCellLabel(_ sender: UITapGestureRecognizer) {
        if let number = userCellLabel.text {
            showAlert(number: number)
        }
    }
}

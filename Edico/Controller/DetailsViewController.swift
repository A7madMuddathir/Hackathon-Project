//
//  DetailsViewController.swift
//  Edico
//
//  Created by MacBook Pro on 15/10/2022.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var genderLabel: UILabel!
    
    @IBOutlet weak var ageLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameLabel.text = chosenPatient.name
        if chosenPatient.gender == true {
            genderLabel.text = "Male"
        }
        else {
            genderLabel.text = "Female"
        }
        ageLabel.text = "\(chosenPatient.age)"
        
        if chosenPatient.status == 0 {
            statusLabel.text = "Stable"
            statusLabel.textColor = green
        }
        else if chosenPatient.status == 1 {
            statusLabel.text = "Mild"
            statusLabel.textColor = yellow
        }
        else {
            statusLabel.text = "Critical"
            statusLabel.textColor =
            red
        }
        
    }
    


}

//
//  PatientsListViewController.swift
//  Edico
//
//  Created by MacBook Pro on 14/10/2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage


var chosenPatient = Patient()

var Patients = [Patient]()

let customFont = UIFont(name: "Poppins-Regular", size: UIFont.labelFontSize)

class PatientsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var patientsTableView: UITableView!
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return Patients.count
//    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//          return 99
//   }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//           let headerView = UIView()
//           headerView.backgroundColor = view.backgroundColor
//           return headerView
//       }
//
//       func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//           return 4
//       }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Patients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let red = UIColor(hexString: "#E24700")
        let yellow = UIColor(hexString: "#E9C201")
        let green = UIColor(hexString: "#34BE82")
        
        let cell = patientsTableView.dequeueReusableCell(withIdentifier: "cell") as! PatientsListTableViewCell
        cell.nameLabel.text = Patients[indexPath.row].name
        cell.conditionLabel.text = Patients[indexPath.row].condition
        cell.dateLabel.text = Patients[indexPath.row].date
        if Patients[indexPath.row].gender == true {
            cell.genderImageView.image = UIImage(named: "male.png")
        }
        else {
            cell.genderImageView.image = UIImage(named: "female.png")
        }
        if Patients[indexPath.row].status == 0 {
            cell.statusLabel.text = "Stable"
        }
        else if Patients[indexPath.row].status == 1 {
            cell.statusLabel.text = "Mild"
        }
        else if Patients[indexPath.row].status == 2 {
            cell.statusLabel.text = "Critical"
        }
        
        cell.statusView.alpha = 0.6
        
        if Patients[indexPath.row].status == 0 {
            cell.statusView.backgroundColor = green
        }
        else if Patients[indexPath.row].status == 1 {
            cell.statusView.backgroundColor = yellow
        }
        
         else {
            cell.statusView.backgroundColor = red
        }
//        cell.nameLabel.font = UIFontMetrics.default.scaledFont(for: customFont!)
//        cell.statusLabel.font = UIFontMetrics.default.scaledFont(for: customFont!)
//        cell.conditionLabel.font = UIFontMetrics.default.scaledFont(for: customFont!)
//        cell.dateLabel.font = UIFontMetrics.default.scaledFont(for: customFont!)
        
        
        
        cell.ageLabel.text = "\(Patients[indexPath.row].age)"
        
        cell.statusLabel.transform = CGAffineTransform(rotationAngle: -(.pi / 2))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenPatient = Patients[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "DetailsViewController")
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//
//        for family in UIFont.familyNames.sorted() {
//            let names = UIFont.fontNames(forFamilyName: family)
//            print("Family: \(family) Font names: \(names)")
//        }
//
        let patient = Patient()
        patient.name = "Sami"
        patient.age = 20
        patient.gender = true
        patient.status = 1
        patient.condition = "Cardiac Arrest"
        patient.date = "13/10/2022"
        Patients.append(patient)
        
        
        let patient2 = Patient()
        patient2.name = "Sara"
        patient2.age = 20
        patient2.gender = false
        patient2.status = 2
        patient2.condition = "Cardiac Arrest"
        patient2.date = "15/10/2022"
        Patients.append(patient2)

        print(Patients)
        
        patientsTableView.delegate = self
        patientsTableView.dataSource = self
        
        
        
        
        // Do any additional setup after loading the view.
        let db = Firestore.firestore()
    }
    override func viewDidAppear(_ animated: Bool) {
//        titleLabel.font = UIFontMetrics.default.scaledFont(for: customFont!)
//
//        let patient = Patient()
//        patient.name = "Sami"
//        patient.age = 20
//        patient.gender = true
//        patient.status = 0
//        patient.condition = "Cardiac Arrest"
//        patient.date = "13/10/2022"
//        Patients.append(patient)
//
//
//        let patient2 = Patient()
//        patient2.name = "Sara"
//        patient2.age = 20
//        patient2.gender = false
//        patient2.status = 2
//        patient2.condition = "Cardiac Arrest"
//        patient2.date = "15/10/2022"
//        Patients.append(patient2)
        
    }
    
    
    


}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

//
//  LoginViewController.swift
//  Edico
//
//  Created by MacBook Pro on 14/10/2022.
//

import UIKit
import FirebaseAuth
import FirebaseStorage

class LoginViewController: UIViewController {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        func login(withEmail email: String, password: String, _ callback: ((Error?) -> ())? = nil){
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if let e = error{
                    callback?(e)
                    return
                }
                callback?(nil)
            }
        }
        
       
        // Do any additional setup after loading the view.
    }
    

    @IBAction func login(_ sender: UIButton) {
        let email = idTextField.text
        let password = passwordTextField.text
        
        Auth.auth().signIn(withEmail: email!, password: password!) { (user, error) in
            
            
            
            if let e = error{
                let alert = UIAlertController(title: "عذراً", message: ".لقد حدث خطأ أثناء محاولة تسجيل دخولك", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "حسناً", style: UIAlertAction.Style.default, handler: { _ in
                   
               }
               ))
               self.present(alert, animated: true, completion: nil)
                return
            }
            
            else {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc  = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    

}

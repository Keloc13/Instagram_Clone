//
//  SignUpViewController.swift
//  instagram
//
//  Created by Kevin Nguyen on 2/27/18.
//  Copyright © 2018 KevinVuNguyen. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var username: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signUp(_ sender: Any) {
        let user = PFUser()
        user.username = username.text
        user.password = passwordField.text
        user.signUpInBackground { (success: Bool,error: Error? ) in
            if success {
                print("Yay, created a user")
            } else {
                print("[Error]")
            }
        }
        
        let password = passwordField.text
        let name = username.text
        
        PFUser.logInWithUsername(inBackground: name!, password: password!){ (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
            } else {
                print("User logged in successfully")
                self.performSegue(withIdentifier: "registerLogin", sender: nil)
                // display view controller that needs to shown after successful login
            }
        }
    }
   
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "backToLogin", sender: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

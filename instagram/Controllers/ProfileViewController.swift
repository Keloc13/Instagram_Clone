//
//  ProfileViewController.swift
//  instagram
//
//  Created by Kevin Nguyen on 2/25/18.
//  Copyright © 2018 KevinVuNguyen. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    @IBAction func logout(_ sender: Any) {
        print("Button pressed to log out")
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
        self.logOut()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func logOut() {
        // Logout the current user
        
        PFUser.logOutInBackground(block: { (error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Successful loggout")
                // Load and show the login view controller
                self.performSegue(withIdentifier: "main", sender: nil)
            }
        })
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

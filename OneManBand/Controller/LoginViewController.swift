//
//  ViewController.swift
//  OneManBand
//
//  Created by Alexandra King on 22/06/2020.
//  Copyright © 2020 Alex's Amazing Apps. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    
    //TEST
    let testEmail = "simon@traxsound.co.uk"
    let testPassword = "abcd"
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.isHidden = true
        //activityIndicator.hidesWhenStopped = true
        
        
    }

    @IBAction func loginPressed(_ sender: Any) {
        /*
             
            //TODO: If textfields are empty, it isn't actually nil?? It's just ""?
             
            guard let email = emailTextField.text else {
                print("please enter email")
                return
            }
            
            guard let password = passwordTextField.text else {
                print("please enter password")
                return
            }
        */
        
        let loadingOverlay = LoadingOverlay(frame: view.bounds)
        view.addSubview(loadingOverlay)
        
            Networking.shared.login(email: testEmail, password: testPassword) { (ApiResponse) in

                switch ApiResponse.success {
                case true: self.performSegue(withIdentifier: K.loginSegue, sender: self)
                default: print("Failed to log in"); loadingOverlay.removeFromSuperview() //TOAST?
                }
                loadingOverlay.removeFromSuperview() //TODO: this might not be necessary.

            }
    
    }
    
    
    
}


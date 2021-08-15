//
//  SMSVerificationViewController.swift
//  NavigationApp
//
//  Created by Maksim Semeniuk on 15.08.2021.
//

import UIKit
import FirebaseAuth

class SMSVerificationViewController: UIViewController {
    
    var verificationCode: String = ""
    
    @IBOutlet weak var codeTextField: UITextField!
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        guard let code = codeTextField.text else { return }
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationCode,
            verificationCode: code
        )
        Auth.auth().signIn(with: credential) { [weak self] authResult, error in
            if let error = error {
                print("sign in error: \(error.localizedDescription)")
                return
            }
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MapViewController")
            
            self?.navigationController?.pushViewController(vc, animated: true)

        }
    }
}

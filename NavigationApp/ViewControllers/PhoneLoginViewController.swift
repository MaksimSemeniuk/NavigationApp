//
//  PhoneLoginViewController.swift
//  NavigationApp
//
//  Created by Maksim Semeniuk on 15.08.2021.
//

import UIKit
import FirebaseAuth

class PhoneLoginViewController: UIViewController {
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    override func viewDidLoad() {
        print("User is auth: \(Auth.auth().currentUser != nil)")
    }
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        guard let phone = phoneTextField.text else { return }
        PhoneAuthProvider.provider().verifyPhoneNumber(phone, uiDelegate: nil) { [weak self] verificationID, error in
            if let error = error {
                print("verify error: \(error.localizedDescription)")
                return
            }
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "SMSVerificationViewController") as? SMSVerificationViewController
            vc?.verificationCode = verificationID ?? ""
            
            self?.navigationController?.pushViewController(vc!, animated: true)
        }
        /*

         */
    }
}

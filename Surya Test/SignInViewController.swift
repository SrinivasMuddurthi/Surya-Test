//
//  SignInViewController.swift
//  Surya Test
//
//  Created by Srinu AMBATI on 18/02/24.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet weak var mobileNumber: UITextField!
    @IBOutlet weak var otpNumber: UITextField!
    
    var userNameFromPreviousView: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userNameLabel.text = "Welcome \(userNameFromPreviousView ?? "")"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInButtonClicked() {
        
        let mobile = mobileNumber.text
        let otp = otpNumber.text
    
        if mobile?.count != 10 {
            mobileNumber.becomeFirstResponder()
            
            var mobileNumberAlert = UIAlertController(title: "Invalid", message: "Please enter Mobile Number", preferredStyle: .alert)
            var cancelAction = UIAlertAction(title: "Ok", style: .cancel)
            
            mobileNumberAlert.addAction(cancelAction)
            self.present(mobileNumberAlert, animated: true)
            
        } else if otp?.count != 6 {
            otpNumber.becomeFirstResponder()
            
            var otpNumberAlert = UIAlertController(title: "Invalid", message: "Please enter otp", preferredStyle: .alert)
            var cancelAction = UIAlertAction(title: "Ok", style: .cancel)
            
            otpNumberAlert.addAction(cancelAction)
            self.present(otpNumberAlert, animated: true, completion: nil)
        } else {
            /*let signInVC = (storyboard?.instantiateViewController(withIdentifier: "SampleAPIController"))! as! SampleAPIController // type casting
            self.present(signInVC, animated: true)*/
            
            let signInVC = (storyboard?.instantiateViewController(withIdentifier: "CollectionViewControllerExample"))! as! CollectionViewControllerExample // type casting
            self.present(signInVC, animated: true)
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

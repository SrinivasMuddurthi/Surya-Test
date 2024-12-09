//
//  ViewController.swift
//  Surya Test
//
//  Created by Srinu AMBATI on 04/02/24.
//

import ARKit
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    
    var ischecked: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       /* let a = 10
        var b = 20
        var c = "Hello"
        print("The Value of a is \(c)")
        
        var userName: String?
        
        // Optional ? nil value
        var d: Int?
        d = 100
        
        var e: Int = 10
        e = 20
        
        var str1 = "M S S"
        var str2 = "Srinivas"
        
        var str3 = str1 + " " + str2
        print(str3)
        
        if isARSupported() {
            // ARKit is supported. Do what you need.
            print("AR is Supporting in this device")
        } else {
            // ARKit is not supported.
            print("AR is Not Supporting in this device")
        }*/
        
        if ischecked {
            checkBoxButton.setImage(UIImage(named: "checkbox.png"), for: .normal)
            signInButton.setTitleColor(.yellow, for: .normal)
            signInButton.isUserInteractionEnabled = true
        } else {
            checkBoxButton.setImage(UIImage(named: "uncheck.png"), for: .normal)
            signInButton.setTitleColor(.black, for: .normal)
            signInButton.isUserInteractionEnabled = false
        }
        
        testAPICall(searchTerm: "Hello")
    }
    
    /*func isARSupported() -> Bool {
        guard #available(iOS 11.0, *) else {
            return false
        }
        return ARConfiguration.isSupported
    }*/

    @IBAction func btnLogin(_ sender: Any) { // function name is btnLogin, parameters sender
        print("Login Button Clicked")
        
        let user = userName.text
        _ = password.text
        
        print("User Name: \(userName.text)")
        print("Password: \(password.text)")
        
        if user == "Surya" {
            print("Please enter User Name")
        } else {
            print("Invalid User")
        }
    }

    @IBAction func checkboxaction(_ sender: Any) {
      ischecked = !ischecked
        
        if ischecked {
            checkBoxButton.setImage(UIImage(named: "checkbox.png"), for: .normal)
            signInButton.setTitleColor(.yellow, for: .normal)
            signInButton.isUserInteractionEnabled = true
        } else {
            checkBoxButton.setImage(UIImage(named: "uncheck.png"), for: .normal)
            signInButton.setTitleColor(.gray, for: .normal)
            signInButton.isUserInteractionEnabled = false
        }
    }
    
    // MARK: - signIn Button Action
    @IBAction func gotoSignIn(_ sender: Any) {
        
        let user = userName.text
        let pwd = password.text
        
        if user?.count == 0 {
            userName.becomeFirstResponder()

            let userNameAlert = UIAlertController(title: "Error", message: "Please enter User Name", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Done", style: .cancel)
            
            userNameAlert.addAction(cancelAction)
            self.present(userNameAlert, animated: true)
            
        } else if pwd?.count == 0 {
            password.becomeFirstResponder()
            
            let pwdAlert = UIAlertController(title: "Error", message: "Please enter passowrd", preferredStyle: . alert)
            let cancelAction = UIAlertAction(title: "Done", style: .cancel)
            
            pwdAlert.addAction(cancelAction)
            self.present(pwdAlert, animated: true, completion: nil)
        } else {
            let signInVC = (storyboard?.instantiateViewController(withIdentifier: "SignInViewController"))! as! SignInViewController // type casting
            signInVC.userNameFromPreviousView = userName.text
            self.present(signInVC, animated: true)
        }
    }

    func checkEmailID(emailStr: String) {
        print("Email ID: \(emailStr)")
    }
    
    // MARK: - API Call
   /* func sampleForAPICalls() {
        let defaultSession = URLSession(configuration: .default)
        var dataTask: URLSessionDataTask?
        // 1
        dataTask?.cancel()
            
        // 2
        if var urlComponents = URLComponents(string: "https://itunes.apple.com/search") {
          urlComponents.query = "media=music&entity=song&term=happy"
          // 3
          guard let url = urlComponents.url else {
            return
          }
          // 4
          dataTask =
            defaultSession.dataTask(with: url) { [weak self] data, response, error in
            // 5
            if let error = error {
              print("DataTask error: " +
                                      error.localizedDescription + "\n")
            } else if
              let data = data,
              let response = response as? HTTPURLResponse,
              response.statusCode == 200 {
              print("response data is \(data)")
            }
          }
          // 7
          dataTask?.resume()
        }
    }*/
    
    func testAPICall(searchTerm: String) {
        let url = URL(string: "https://itunes.apple.com/search?media=music&entity=song&term=\(searchTerm)")!
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data else {
                    let userNameAlert = UIAlertController(title: "Error", message: "Invalid Data", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "Ok", style: .cancel)
                    
                    userNameAlert.addAction(cancelAction)
                    self.present(userNameAlert, animated: true)

                    print("invalid Data")
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    print("invalid Response")
                    return
                }
                
                // JSONDecoder() converts data to model of type Array
                do {
                    // let products = try JSONDecoder().decode([Products].self, from: data)
                    // print("products are \(data)")
                    let stringData = String(data: data, encoding: .utf8)
                    print("string is \(stringData ?? "")")
                } /*catch {
                    print("error message \(error)")
                }*/
            }.resume()
    }
}


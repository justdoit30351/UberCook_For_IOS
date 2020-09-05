//
//  Login.swift
//  UberCook
//
//  Created by 超 on 2020/8/29.
//

import UIKit
import Foundation

class Login: UIViewController {
    
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    let url_server = URL(string: common_url + "Login_Servlet")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didEndOnExit(_ sender: Any) {}
    @IBAction func didEndOnExit2(_ sender: Any) {}
    
    @IBAction func textFieldresignFirstRespondertouchDown(_ sender: Any) {
        accountTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    
    @IBAction func clickLogin(_ sender: Any) {
        let account = accountTextField.text == nil ? "" : accountTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text == nil ? "" : passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        var requestParam = [String: String]()
        requestParam["action"] = "getone"
        requestParam["acc"] = account
        requestParam["psw"] = password
        executeTask(url_server!, requestParam) { (data, response, error) in
//            let decoder = JSONDecoder()
            if error == nil {
                if data != nil {
                    if let result = try? JSONDecoder().decode([String: String].self, from: data!){
                        if result["Result"]! == "successful"{
                            DispatchQueue.main.sync {
                                self.performSegue(withIdentifier: "Home", sender: self)
                            }
                        }else{
                            print("Error")
                        }
                    }
                }
            }
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

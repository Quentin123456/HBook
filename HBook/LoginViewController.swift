//
//  LoginViewController.swift
//  HBook
//
//  Created by 臧乾坤 on 2017/4/24.
//  Copyright © 2017年 臧乾坤. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var Username: UITextField!
    
    @IBOutlet weak var Password: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(_ sender: Any) {
        
        AVUser.logInWithUsername(inBackground: self.Username.text!, password: self.Password.text!) { (user, error) in
            
            if error == nil {
            
                self.dismiss(animated: true, completion: {
                    
                })
                
            } else {
            
                 ProgressHUD.showError("用户名或密码有误")
                
            }
            
        }
    }


}

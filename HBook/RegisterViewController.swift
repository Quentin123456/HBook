//
//  RegisterViewController.swift
//  HBook
//
//  Created by 臧乾坤 on 2017/4/24.
//  Copyright © 2017年 臧乾坤. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var Username: UITextField!
    
    @IBOutlet weak var Password: UITextField!

    @IBOutlet weak var Email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func register(_ sender: Any) {
        
        let user = AVUser()
        user.username = self.Username.text
        user.password = self.Password.text
        user.email = self.Email.text
        user.signUpInBackground { (success, error) -> Void in
            if success {
                ProgressHUD.showSuccess("注册成功，请验证邮箱")
                self.dismiss(animated: true, completion: {
                    
                })
            } else {
            
                ProgressHUD.showError("注册失败")
                
            }
            
        }
    }
    @IBAction func close(_ sender: Any) {
        
        self.dismiss(animated: true, completion: {
            
        })
        
    }
   
}

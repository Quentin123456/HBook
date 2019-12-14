//
//  rankViewController.swift
//  HBook
//
//  Created by 臧乾坤 on 2017/4/23.
//  Copyright © 2017年 臧乾坤. All rights reserved.
//

import UIKit

class rankViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        //AVUser.logOut()
        
        if AVUser.current() == nil {
        
            let story = UIStoryboard(name: "Login", bundle: nil)
            let loginVc = story.instantiateViewController(withIdentifier: "Login")
            self.present(loginVc, animated: true, completion: {
                
            })
            
        }

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

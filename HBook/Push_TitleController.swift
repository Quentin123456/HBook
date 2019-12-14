//
//  Push_TitleController.swift
//  HBook
//
//  Created by 臧乾坤 on 2017/4/23.
//  Copyright © 2017年 臧乾坤. All rights reserved.
//

import UIKit

// 我们曾经用到的一个闭包
typealias Push_TitleCallBack = (_ Title:String) -> Void

class Push_TitleController: UIViewController {
    
    var textField:UITextField?
    
    var callBack:Push_TitleCallBack?
    /**
     实现回调
     1、block
     2、delegate
     3、通知NSNotification
     **/

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        self.textField = UITextField(frame: CGRect(x:15,y:60,width:SCREEN_WIDTH - 30,height:30))
        self.textField?.borderStyle = .roundedRect
        self.textField?.placeholder = "书评标题"
        self.textField?.font = UIFont(name: MY_FONT, size: 15)
        self.view.addSubview(self.textField!)
        
        self.textField?.becomeFirstResponder()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func close() {
        
        self.dismiss(animated: true) { 
          
        }
        
    }
    
    func sure() {
        
        /**
         *  调用闭包
         */
        self.callBack!((self.textField?.text)!)
        
        self.dismiss(animated: true) {
            
        }
        
    }


}

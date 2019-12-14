//
//  Push_DescriptionController.swift
//  HBook
//
//  Created by 臧乾坤 on 2017/4/23.
//  Copyright © 2017年 臧乾坤. All rights reserved.
//

import UIKit

typealias Push_DescriptionControllerBlock = (_ description:String) -> Void

class Push_DescriptionController: UIViewController {
    
    var textView:JVFloatLabeledTextView?
    
    var callBack:Push_DescriptionControllerBlock?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        self.textView = JVFloatLabeledTextView(frame:CGRect(x:8,y:58,width:SCREEN_WIDTH - 16,height:SCREEN_HEIGHT - 58 - 8))
        self.view.addSubview(self.textView!)
        self.textView?.placeholder = "    你可以在这里撰写详细的评价、吐槽、介绍～～～"
        self.textView?.font = UIFont(name: MY_FONT, size: 17)
        self.textView?.becomeFirstResponder()
        
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
        
        self.callBack!((self.textView?.text)!)
        self.dismiss(animated: true) {
            
        }
        
    }
    
}

//
//  pushBook.swift
//  HBook
//
//  Created by 臧乾坤 on 2017/4/27.
//  Copyright © 2017年 臧乾坤. All rights reserved.
//

import UIKit

class pushBook: NSObject {

    static func pushBookInBack(dict:NSDictionary,object:AVObject){
        
        object.setObject(dict["BookName"], forKey: "BookName")
        object.setObject(dict["BookEditor"], forKey: "BookEditor")
        object.setObject(dict["title"], forKey: "title")
        object.setObject(dict["score"], forKey: "score")
        object.setObject(dict["type"], forKey: "type")
        object.setObject(dict["detailType"], forKey: "detailType")
        object.setObject(dict["description"], forKey: "description")
        object.setObject(AVUser.current(), forKey: "user")
        let cover = dict["BookCover"] as? UIImage
        
        let coverFile = AVFile(data: UIImagePNGRepresentation(cover!)!)
      
        coverFile.saveInBackground { (true, error) in
        
            if true {
            
                object.setObject(coverFile, forKey: "cover")
                object.saveInBackground({ (success, error) in
                    
                     if success {
                    /**
                     *  调用通知
                     */
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: String(describing: #selector(pushNewBookController.pushCallBack(notification:)))), object: nil, userInfo: ["success":"true"])
                    ProgressHUD.showSuccess("上传成功")
                        
                     } else  {
                        
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: String(describing: #selector(pushNewBookController.pushCallBack(notification:)))), object: nil, userInfo: ["success":"false"])
                        ProgressHUD.showError("上传失败")
                        
                    } 

                    
                })
            
            } else {
                
            } 
        
        }

  }

}

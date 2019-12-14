//
//  BookDetailView.swift
//  HBook
//
//  Created by 臧乾坤 on 2017/4/28.
//  Copyright © 2017年 臧乾坤. All rights reserved.
//

import UIKit

class BookDetailView: UIView {
    
    var VIEW_WIDTH:CGFloat!
    var VIEW_HEIGHT:CGFloat!
    
    var BookName:UILabel?
    var Editor:UILabel?
    var userName:UILabel?
    var date:UILabel?
    var more:UILabel?
    var Score:LDXScore?
    
    var cover:UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.VIEW_WIDTH = frame.size.width
        self.VIEW_HEIGHT = frame.size.height
        self.backgroundColor = UIColor.white
        
        self.cover = UIImageView(frame: CGRect(x:8,y:8,width:(VIEW_HEIGHT - 16) / 1.273,height:VIEW_HEIGHT - 16))
        self.addSubview(self.cover!)

        self.BookName = UILabel(frame: CGRect(x:(VIEW_HEIGHT - 16) / 1.273 + 16,y:8,width:VIEW_WIDTH - (VIEW_HEIGHT - 16) / 1.273 - 16,height:VIEW_HEIGHT / 4))
        self.BookName?.font = UIFont(name: MY_FONT, size: 18)
        self.addSubview(self.BookName!)
        
        self.Editor = UILabel(frame: CGRect(x:(VIEW_HEIGHT - 16) / 1.273 + 16,y:8 + VIEW_HEIGHT / 4,width:VIEW_WIDTH - (VIEW_HEIGHT - 16) / 1.273 - 16,height:VIEW_HEIGHT / 4))
        self.Editor?.font = UIFont(name: MY_FONT, size: 18)
        self.addSubview(self.Editor!)
        
        
        self.userName = UILabel(frame: CGRect(x:(VIEW_HEIGHT - 16) / 1.273 + 16,y:24 + VIEW_HEIGHT / 4 + VIEW_HEIGHT / 6,width:VIEW_WIDTH - (VIEW_HEIGHT - 16) / 1.273 - 16,height:VIEW_HEIGHT / 6))
        self.userName?.font = UIFont(name: MY_FONT, size: 13)
        self.userName?.textColor = RGB(r: 35, g: 87, b: 139)
        self.addSubview(self.userName!)
        
        self.date = UILabel(frame: CGRect(x:(VIEW_HEIGHT - 16) / 1.273 + 16,y:16 + VIEW_HEIGHT / 4 + VIEW_HEIGHT / 6 * 2,width:80,height:VIEW_HEIGHT / 6))
        self.date?.font = UIFont(name: MY_FONT, size: 13)
        self.date?.textColor = UIColor.gray
        self.addSubview(self.date!)
        
        self.Score = LDXScore(frame: CGRect(x:(VIEW_HEIGHT - 16)/1.273+16+80,y:16+VIEW_HEIGHT/4+VIEW_HEIGHT/6*2,width:80,height:VIEW_HEIGHT/6))
        self.Score?.isSelect = false
        self.Score?.normalImg = UIImage(named: "btn_star_evaluation_normal")
        self.Score?.highlightImg = UIImage(named: "btn_star_evaluation_press")
        self.Score?.max_star = 5
        self.Score?.show_star = 5
        self.addSubview(self.Score!)
        
        self.more = UILabel(frame: CGRect(x:(VIEW_HEIGHT - 16) / 1.273 + 16,y:8 + VIEW_HEIGHT / 4 + VIEW_HEIGHT / 6 * 3,width:VIEW_WIDTH - (VIEW_HEIGHT - 16) / 1.273 - 16,height:VIEW_HEIGHT / 6))
        self.more?.textColor = UIColor.gray
        self.more?.font = UIFont(name: MY_FONT, size: 13)
        self.addSubview(self.more!)

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        
        context?.setLineWidth(0.5)
        context?.setStrokeColor(red: 231/255, green: 231/255, blue: 231/255, alpha: 1)
        context?.move(to: CGPoint(x:8,y:VIEW_HEIGHT - 2))
        context?.addLine(to: CGPoint(x:VIEW_WIDTH - 8, y:VIEW_HEIGHT - 2))
        
        context?.strokePath()
        
    }
 
    

}

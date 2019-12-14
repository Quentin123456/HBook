//
//  BookTabBar.swift
//  HBook
//
//  Created by 臧乾坤 on 2017/4/28.
//  Copyright © 2017年 臧乾坤. All rights reserved.
//

import UIKit

protocol BookTabBarDelegate {
    
    func comment()
    func commentController()
    func likeBook(btn:UIButton)
    func shareAction()

}

class BookTabBar: UIView {
    
    var delegate:BookTabBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        let imageName = ["Pen 4","chat 3","heart","box outgoing"]
        for i in 0  ..< 4 {
            let btn = UIButton(frame:CGRect(x:CGFloat(i) * frame.size.width / 4,y:0,width:frame.size.width / 4,height:frame.size.height))
            btn.setImage(UIImage(named: imageName[i]), for: .normal)
            self.addSubview(btn)
            btn.tag = i
            btn.addTarget(self, action: #selector(BookTabBar.BookTabbarAction(btn:)), for: .touchUpInside)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(0.5)
        context?.setStrokeColor(red: 231/255, green: 231/255, blue: 231/255, alpha: 1)
        
        for i in 1 ..< 4 {
            
            context?.move(to: CGPoint(x:CGFloat(i)*rect.size.width / 4, y:rect.size.height * 0.1))
            context?.addLine(to: CGPoint(x:CGFloat(i)*rect.size.width / 4, y:rect.size.height * 0.9))

        }
        
        context?.move(to: CGPoint(x: 8,y: 0))
        context?.addLine(to: CGPoint(x:rect.size.width - 8, y:0))
        context?.strokePath()

        
    }
    
    /**
     *  BookTabBarDelegate
     */
    func BookTabbarAction(btn:UIButton){
        switch(btn.tag){
        case 0:
            delegate?.comment()
            break
        case 1:
            delegate?.commentController()
            break
        case 2:
            delegate?.likeBook(btn: btn)
            break
        case 3:
            delegate?.shareAction()
            break
        default:
            break
        }
        
    }

}

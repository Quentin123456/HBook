//
//  BookTitleView.swift
//  HBook
//
//  Created by 臧乾坤 on 2017/4/23.
//  Copyright © 2017年 臧乾坤. All rights reserved.
//

import UIKit

@objc protocol BookTitleDelegate {
    
    @objc optional func choiceCover()
    
}

class BookTitleView: UIView {
    
    var BookCover:UIButton?

    var BookName:JVFloatLabeledTextField?
    var BookEditor:JVFloatLabeledTextField?
    
    weak var delegate:BookTitleDelegate?
    
    override init(frame:CGRect) {
        
        super.init(frame: frame)
        
        self.BookCover = UIButton(frame:CGRect(x:10,y:8,width:110,height:141))
        self.BookCover?.setImage(UIImage(named:"Cover"), for: .normal)
        self.addSubview(self.BookCover!)
        
        self.BookCover?.addTarget(self, action: #selector(BookTitleDelegate.choiceCover), for: .touchUpInside)
        
        self.BookName = JVFloatLabeledTextField(frame:CGRect(x:128,y:8 + 40,width:SCREEN_WIDTH - 128 - 15,height:30))
        self.BookEditor = JVFloatLabeledTextField(frame:CGRect(x:128,y:8 + 70 + 40,width:SCREEN_WIDTH - 128 - 15,height:30))
        
        self.BookName?.placeholder = "书名"
        self.BookEditor?.placeholder = "作者"
        
        self.BookName?.floatingLabelFont = UIFont(name:MY_FONT,size:14)
        self.BookEditor?.floatingLabelFont = UIFont(name:MY_FONT,size:14)
        
        self.BookName?.font = UIFont(name:MY_FONT,size:14)
        self.BookEditor?.font = UIFont(name:MY_FONT,size:14)
        
        self.addSubview(self.BookName!)
        self.addSubview(self.BookEditor!)
        
        
        
    }
    
    required init?(coder aDecoder:NSCoder) {
        
        fatalError("init(coder:) has not implemeted")
        
    }
    
    func choiceCover() {
        
        self.delegate?.choiceCover!()
        
    }

}

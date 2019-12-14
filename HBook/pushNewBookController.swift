//
//  pushNewBookController.swift
//  HBook
//
//  Created by 臧乾坤 on 2017/4/23.
//  Copyright © 2017年 臧乾坤. All rights reserved.
//

import UIKit

class pushNewBookController: UIViewController,BookTitleDelegate,PhotoPickerDelegate,UITableViewDelegate,UITableViewDataSource {
    
    var BookTitle:BookTitleView?
    
    var tableView:UITableView?
    
    var titleArray:Array<String> = []
    
    var Book_Title = ""
    
    var Book_Description = ""
    
    var Score:LDXScore?
    
    /**
     表示是否显示星星
     **/
    var showScore = false
    
    var type = "文学"
    var detailType = "文学"
    
    // 编辑
    var BookObject:AVObject?
    var fixType:String?


    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        self.BookTitle = BookTitleView(frame:CGRect(x:0,y:40,width:SCREEN_WIDTH,height:160))
        self.BookTitle?.delegate = self
        self.view.addSubview(self.BookTitle!)
        
        self.tableView = UITableView(frame: CGRect(x:0,y:200,width:SCREEN_WIDTH,height:SCREEN_HEIGHT - 200), style: .grouped)
        
        /**
         使用没有内容的线条消失
         **/
        self.tableView?.tableFooterView = UIView()
        
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        
        self.tableView?.register( UITableViewCell.classForCoder(),forCellReuseIdentifier:"cell")
        self.tableView?.backgroundColor = UIColor(colorLiteralRed:250/255,green:250/255,blue:250/255,alpha:1)
        self.view.addSubview(self.tableView!)
        
        self.titleArray = ["标题","评分","分类","书评"]
        
        self.Score = LDXScore(frame:CGRect(x:100,y:10,width:100,height:22))
        self.Score?.isSelect = true
        self.Score?.normalImg = UIImage(named:"btn_star_evaluation_normal")
        self.Score?.highlightImg = UIImage(named:"btn_star_evaluation_press")
        self.Score?.max_star = 5
        self.Score?.show_star = 5
        
//        /**
//         注册通知
//         */
//        NotificationCenter.default.addObserver(self, selector: Selector(("pushBookNotification:")), name: NSNotification.Name(rawValue: "pushBookNotification"), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(pushNewBookController.pushCallBack(notification:)), name: Notification.Name(rawValue: "pushCallBack"), object: nil)
        
    }

    /**
     编辑
     */
    func fixBook() {
        
        if self.fixType == "fix" {
            
            self.BookTitle?.BookName?.text = self.BookObject!["BookName"] as? String
            self.BookTitle?.BookEditor?.text = self.BookObject!["BookEditor"] as? String
            let coverFile = self.BookObject!["cover"] as? AVFile
          
            coverFile?.getDataInBackground({ (data, error) in
           
                self.BookTitle?.BookCover?.setImage(UIImage(data: data!), for: .normal)
                
            })
            
            self.Book_Title = (self.BookObject!["title"] as? String)!
            self.type = (self.BookObject!["type"] as? String)!
            self.detailType = (self.BookObject!["detailType"] as? String)!
            self.Book_Description = (self.BookObject!["description"] as? String)!
            self.Score?.show_star = (Int)((self.BookObject!["score"] as? String)!)!
            
            if self.Book_Description != "" {
                
            self.titleArray.append("")
                
            }
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        
        print("pushNewBookController released")
       // NotificationCenter.default.removeObserver(self)
        /**
         移除通知
         */
        NotificationCenter.default.removeObserver(self)
        
    }

//    func pushBookNotification(notification:Notification) {
//    
//        let dict = notification.userInfo
//        
//        if String(describing: dict!["success"]!) == "true" {
//            
//            ProgressHUD.showSuccess("上传成功")
//            self.dismiss(animated: true, completion: {
//                
//            })
//        } else {
//        
//            ProgressHUD.showSuccess("上传失败")
//
//            
//        }
//        
//    }
    
    /**
     pushCallBack
     */
    func pushCallBack(notification:Notification) {
  
        let dict = notification.userInfo
        if (String(describing: dict!["success"]!)) == "true" {
            
            if self.fixType == "fix" {
                
                ProgressHUD.showSuccess("修改成功")
                
            } else {
                
                ProgressHUD.showSuccess("上传成功")
                
            }
            
            self.dismiss(animated: true, completion: {
                
            })
            
        } else {
            
            ProgressHUD.showError("上传失败")
            
        }
        
    }

    
    /**
     BookTitleDelegate
     **/
    func choiceCover() {
        
        let vc = PhotoPickerViewController()
        vc.delegate = self
        
        self.present(vc, animated: true) {
            
        }
        
    }
    
    /**
     *PhotoPickerDelegate
     **/
    
    func getImageFromPicker(image: UIImage) {
        
        self.BookTitle?.BookCover?.setImage(image, for: .normal)
//        let CroVC = VPImageCropperViewController(image: image, cropFrame: CGRect(x:0,y:100,width:SCREEN_WIDTH,height:SCREEN_WIDTH*1.273), limitScaleRatio: 3)
//        CroVC?.delegate = self
//        self.present(CroVC!, animated: true) { () -> Void in
//        
//        
//    }
  
}
    
//        /**
//         *  VPImageDelegate
//         */
//        func imageCropperDidCancel(_ cropperViewController: VPImageCropperViewController!) {
//            cropperViewController.dismiss(animated: true) { () -> Void in
//                
//            }
//        }
//        func imageCropper(_ cropperViewController: VPImageCropperViewController!, didFinished editedImage: UIImage!) {
//            self.BookTitle?.BookCover?.setImage(editedImage, for: .normal)
//            cropperViewController.dismiss(animated: true) { () -> Void in
//                
//            }
//        }

    
    func close() {
        
        self.dismiss(animated: true) { 
            
        }
        
    }
    
    func sure() {
        
        let dict = [
            "BookName":(self.BookTitle?.BookName?.text)!,
            "BookEditor":(self.BookTitle?.BookEditor?.text)!,
            "BookCover":(self.BookTitle?.BookCover?.currentImage)!,
            "title":self.Book_Title,
            "score":String((self.Score?.show_star)!),
            "type":self.type,
            "detailType":self.detailType,
            "description":self.Book_Description,
            ] as [String : Any]
        
        ProgressHUD.show("")

        if self.fixType == "fix" {
            
            pushBook.pushBookInBack(dict: dict as NSDictionary, object: self.BookObject!)
        
        } else {
            
            let object = AVObject(className: "Book")
            pushBook.pushBookInBack(dict: dict as NSDictionary, object: object)
            
        }

        
    }
    
    /**
     UITableViewDelegate&UITableViewDataSource
     **/
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.titleArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        
        for view in cell.contentView.subviews {
            
            view.removeFromSuperview()
            
        }
        
        if indexPath.row != 1 {
            
            cell.accessoryType = .disclosureIndicator
            
        }

        cell.textLabel?.text = self.titleArray[indexPath.row]
        
        cell.textLabel?.font = UIFont(name: MY_FONT, size: 15)
        cell.detailTextLabel?.font = UIFont(name: MY_FONT, size: 13)
        
         var row = indexPath.row
        
        if self.showScore && row > 1 {
            row -= 1
        }
        
        switch row {
        case 0:
            cell.detailTextLabel?.text = self.Book_Title
        case 1:
            break
        case 2:
            cell.detailTextLabel?.text = self.type + "->" + self.detailType
        case 3:
            break
        case 4:
            cell.accessoryType = .none
            
            let commentView = UITextView(frame:CGRect(x:4,y:4,width:SCREEN_WIDTH - 8,height:80))
            commentView.text = self.Book_Description
            commentView.font = UIFont(name: MY_FONT, size: 14)
            
            cell.contentView.addSubview(commentView)
        default:
            break
        }

        /**
         判断是否需要在第二行添加小星星
         **/
        if self.showScore && indexPath.row == 2 {
            
            cell.contentView.addSubview(self.Score!)
            
        }

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if showScore && indexPath.row >= 5 {
            
            return 88
            
        } else if !self.showScore && indexPath.row >= 4 {
            
            return 88
            
        } else {
            
            return 44
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tableView?.deselectRow(at: indexPath, animated: true)
        
        var row  = indexPath.row
        
        if self.showScore && row >= 1 {
            
            row -= 1
            
        }
        
        switch row {
        case 0:
            self.tableViewSelectTitle()
        case 1:
            self.tableViewSelectScore()
        case 2:
            self.tableViewSelectType()
        case 3:
            self.tableViewSelectDescription()
        default:
            break
            
        }
        
    }
    
    /**
     选择标题
     **/
    func tableViewSelectTitle() {
        
        let vc = Push_TitleController()
        GeneralFactory.addTitleWithTitle(target: vc)
        
        vc.callBack = ({(Title:String) -> Void in
            
            self.Book_Title = Title
            self.tableView?.reloadData()
            
        })
        
        self.present(vc, animated: true) {
            
        }
        
    }
    
    /**
     选择评分
     **/
    func tableViewSelectScore() {
        
        self.tableView?.beginUpdates()
        
        let tempIndexPath = [IndexPath(row: 2, section: 0)]
        
        if self.showScore {
            
            self.titleArray.remove(at: 2)
            self.tableView?.deleteRows(at: tempIndexPath, with: .right)
            self.showScore = false
            
        } else {
            
            self.titleArray.insert("", at: 2)
            
            self.tableView?.insertRows(at: tempIndexPath, with:.left)
            
            self.showScore = true
            
        }
        
        self.tableView?.endUpdates()
        
        
    }
    
    /**
     选择分类
     **/
    func tableViewSelectType() {
        
        let vc = Push_TypeController()
        GeneralFactory.addTitleWithTitle(target: vc)
        let btn1 = vc.view.viewWithTag(1234) as? UIButton
        let btn2 = vc.view.viewWithTag(1235) as? UIButton
        
        btn1?.setTitleColor(RGB(r: 38, g: 82, b: 67), for: .normal)
        btn2?.setTitleColor(RGB(r: 38, g: 82, b: 67), for: .normal)
        
        vc.type = self.type
        vc.detailType = self.detailType
        vc.callBack = ({(type:String,detailType:String) -> Void in
            
            self.type = type
            self.detailType = detailType
            self.tableView?.reloadData()
            
        })
        
        self.present(vc, animated: true) {
            
        }
    
    }
    
    /**
     选择书评
     **/
    func tableViewSelectDescription() {
        
        let vc = Push_DescriptionController()
        GeneralFactory.addTitleWithTitle(target: vc)
        
        vc.textView?.text = self.Book_Description
        
        vc.callBack = ({(description:String) -> Void in
            
            self.Book_Description = description
            
            if self.titleArray.last == "" {
                
                self.titleArray.removeLast()
                
            }
            
            if  description != "" {
                
                self.titleArray.append("")
                
            }
            
            self.tableView?.reloadData()
            
        })
        
        self.present(vc, animated: true) {
            
        }
        
    }
    



}

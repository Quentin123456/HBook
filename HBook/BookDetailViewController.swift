//
//  BookDetailViewController.swift
//  HBook
//
//  Created by 臧乾坤 on 2017/4/28.
//  Copyright © 2017年 臧乾坤. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController,BookTabBarDelegate,InputViewDelegate,HZPhotoBrowserDelegate {
    
    var BookObject:AVObject?
    
    var BookTitleView:BookDetailView?
    
    var BookViewTabbar:BookTabBar?
    
    var BookTextView:UITextView?
    
    var input:InputView?
    
    var layView:UIView?
    
    var keyBoardHeight:CGFloat = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.gray
        
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -60), for: .default)
        
        self.initBookDetailView()
        
        self.BookViewTabbar = BookTabBar(frame: CGRect(x:0,y:SCREEN_HEIGHT - 40,width:SCREEN_WIDTH,height:40))
        self.view.addSubview(self.BookViewTabbar!)
        self.BookViewTabbar?.delegate = self
        
        self.BookTextView = UITextView(frame: CGRect(x:0,y:64 + SCREEN_HEIGHT / 4,width:SCREEN_WIDTH,height:SCREEN_HEIGHT - 64 - SCREEN_HEIGHT / 4 - 40))
        self.BookTextView?.isEditable = false
        self.BookTextView?.text = self.BookObject!["description"] as? String
        self.view.addSubview(self.BookTextView!)
        
        
        self.isLove()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     是否点赞初始化
     
     */
    func isLove(){
        let query = AVQuery(className: "Love")
        query.whereKey("user", equalTo: AVUser.current() as Any)
        query.whereKey("BookObject", equalTo: self.BookObject as Any)
        
        query.findObjectsInBackground { (results, error)  in
            
            if results != nil && results?.count != 0 {
                
                let btn = self.BookViewTabbar?.viewWithTag(2) as? UIButton
                btn?.setImage(UIImage(named: "solidheart"), for: .normal)
                
            }
            
        }
        
    }


    /**
     *  初始化BookDetailView
     */
    func initBookDetailView(){
    
        self.BookTitleView = BookDetailView(frame: CGRect(x:0,y:64,width:SCREEN_WIDTH ,height:SCREEN_HEIGHT / 4))
        self.view.addSubview(self.BookTitleView!)
        
        let coverFile = self.BookObject!["cover"] as? AVFile
        self.BookTitleView?.cover?.sd_setImage(with: URL(string: (coverFile?.url)!), placeholderImage: UIImage(named: "Cover"))
        self.BookTitleView?.BookName?.text = "《"+(self.BookObject!["BookName"] as! String) + "》"
        self.BookTitleView?.Editor?.text = "作者："+(self.BookObject!["BookEditor"] as! String)
        
        let user = self.BookObject!["user"] as? AVUser
        user?.fetchInBackground({ (returnUser, error) in
            self.BookTitleView?.userName?.text = "编者："+(returnUser as! AVUser).username!
        })
        
        let date = self.BookObject!["createdAt"] as? NSDate
        let format = DateFormatter()
        format.dateFormat = "yy-MM-dd"
        self.BookTitleView?.date?.text = format.string(from: date! as Date)
        
        let scoreString = self.BookObject!["score"] as? String
        self.BookTitleView?.Score?.show_star = Int(scoreString!)!
        
        let scanNumber = self.BookObject!["scanNumber"] as? NSNumber
        let loveNumber = self.BookObject!["loveNumber"] as? NSNumber
        let discussNumber = self.BookObject!["discussNumber"] as? NSNumber
        
        self.BookTitleView?.more?.text = (loveNumber?.stringValue)!+"个喜欢."+(discussNumber?.stringValue)!+"次评论."+(scanNumber?.stringValue)!+"次浏览"
        
        let tap = UITapGestureRecognizer(target: self, action:#selector(BookDetailViewController.photoBrowser as (BookDetailViewController) -> () -> ()))
        self.BookTitleView?.cover?.addGestureRecognizer(tap)
        self.BookTitleView?.cover?.isUserInteractionEnabled = true
        
        self.BookObject?.incrementKey("scanNumber")
        self.BookObject?.saveInBackground()

    }
    
    /**
     InputViewDelegate
     */
    func publishButtonDidClick(_ button: UIButton!) {
        
        ProgressHUD.show("")
        
        let object = AVObject(className: "discuss")
        object.setObject(self.input?.inputTextView?.text, forKey: "text")
        object.setObject(AVUser.current(), forKey: "user")
        object.setObject(self.BookObject, forKey: "BookObject")
        
        object.saveInBackground { (true, error) in
            
            if true {
                
                self.input?.inputTextView.resignFirstResponder()
                ProgressHUD.showSuccess("评论成功")
                
                self.BookObject?.incrementKey("discussNumber")
                self.BookObject?.saveInBackground()
                
            } else {
                
            }
        }
    }

    
    func textViewHeightDidChange(height: CGFloat) {
        
        self.input?.height = height + 10
        self.input?.bottom = SCREEN_HEIGHT - self.keyBoardHeight
        
    }
    
    func keyboardWillHide(_ inputView: InputView!, keyboardHeight: CGFloat, animationDuration duration: TimeInterval, animationCurve: UIViewAnimationCurve) {
        
        UIView.animate(withDuration: duration, delay: 0, options: .beginFromCurrentState, animations: {
            
            self.input?.bottom = SCREEN_HEIGHT + (self.input?.height)!
            self.layView?.alpha = 0
            
        }) { (true)  in
            
            self.layView?.isHidden = true
            
        }

        
    }
    
    func keyboardWillShow(_ inputView: InputView!, keyboardHeight: CGFloat, animationDuration duration: TimeInterval, animationCurve: UIViewAnimationCurve) {
        
        UIView.animate(withDuration: duration, delay: 0, options: .beginFromCurrentState, animations: {
            
            self.input?.bottom = SCREEN_HEIGHT + (self.input?.height)!
            self.layView?.alpha = 0
            
        }) { (true) in
            
            self.layView?.isHidden = true
            
        }

        
    }
    
    /**
     *  BookViewDelegate
     */
    func comment() {
        
        if self.input == nil {
            self.input = Bundle.main.loadNibNamed("InputView", owner: self, options: nil)?.last as? InputView
            self.input?.frame = CGRect(x:0,y:SCREEN_HEIGHT - 44,width:SCREEN_WIDTH,height:44)
            self.input?.delegate = self
            self.view.addSubview(self.input!)
            
        }
        if self.layView == nil {
            
            self.layView = UIView(frame: self.view.frame)
            self.layView?.backgroundColor = UIColor.gray
            self.layView?.alpha = 0
            let tap = UITapGestureRecognizer(target: self, action: #selector(BookDetailViewController.tapInputView))
            self.layView?.addGestureRecognizer(tap)
            
        }
        
        self.view.insertSubview(self.layView!, belowSubview: self.input!)
        self.layView?.isHidden = false
        self.input?.inputTextView?.becomeFirstResponder()
        
    }

    func tapInputView() {
        
        self.input?.inputTextView?.resignFirstResponder()
        
    }

    func commentController(){
        
        let vc = commentViewController()
        GeneralFactory.addTitleWithTitle(target: vc, title1: "", title2: "关闭")
        vc.BookObject = self.BookObject
        vc.tableView?.mj_header.beginRefreshing()
        self.present(vc, animated: true) { 
         
        }
       
        
    }
    func likeBook(btn:UIButton){
        btn.isEnabled = false
        btn.setImage(UIImage(named: "redheart"), for: .normal)
        
        let query = AVQuery(className: "Love")
        query.whereKey("user", equalTo: AVUser.current() as Any)
        query.whereKey("BookObject", equalTo: self.BookObject as Any)
        query.findObjectsInBackground { (results, error)  in
            
            if results != nil && results?.count != 0 {///取消点赞
                
                for var object in results! {
                    object = (object as? AVObject)!
                    (object as AnyObject).deleteEventually()
                }
                
                btn.setImage(UIImage(named: "heart"), for: .normal)
               
                self.BookObject?.incrementKey("loveNumber", byAmount: NSNumber(value: -1))
                self.BookObject?.saveInBackground()
                
            } else {///点赞
                
                let object = AVObject(className: "Love")
                object.setObject(AVUser.current(), forKey: "user")
                object.setObject(self.BookObject, forKey: "BookObject")
                object.saveInBackground({ (success, error)  in
                    
                    if success {
                        
                        btn.setImage(UIImage(named: "solidheart"), for: .normal)
                        
                        self.BookObject?.incrementKey("loveNumber", byAmount: NSNumber(value: 1))
                        self.BookObject?.saveInBackground()
                        
                    } else {
                        ProgressHUD.showError("操作失败")
                    }
                })
            }
            
            btn.isEnabled = true
            
        }
        
        
        
    }
    
    func shareAction() {
        // 1.创建分享参数
        let shareParames = NSMutableDictionary()
        shareParames.ssdkSetupShareParams(byText: "分享内容",
                                          images : UIImage(named: "shareImg.png"),
                                          url : NSURL(string:"http://mob.com") as URL!,
                                          title : "分享标题",
                                          type : SSDKContentType.image)
        
        //2.进行分享
        ShareSDK.share(SSDKPlatformType.typeSinaWeibo, parameters: shareParames) { (state : SSDKResponseState, nil, entity : SSDKContentEntity?, error :Error?) in
            
            switch state{
                
            case SSDKResponseState.success: print("分享成功")
            case SSDKResponseState.fail:    print("授权失败,错误描述:\(error)")
            case SSDKResponseState.cancel:  print("操作取消")
                
            default:
                break
            }
            
        }
    
        
    }

    /**
     *  PhotoBrowser
     */
    func photoBrowser(){
        let photoBrowser = HZPhotoBrowser()
        photoBrowser.imageCount = 1
        photoBrowser.currentImageIndex = 0
        photoBrowser.delegate = self
        photoBrowser.show()
    }
    
    func photoBrowser(_ browser: HZPhotoBrowser!, placeholderImageFor index: Int) -> UIImage! {
        return self.BookTitleView?.cover?.image
    }
    func photoBrowser(_ browser: HZPhotoBrowser!, highQualityImageURLFor index: Int) -> URL! {
        
        let coverFile = self.BookObject!["cover"] as? AVFile
        return URL(string: coverFile!.url!)
        
    }


}

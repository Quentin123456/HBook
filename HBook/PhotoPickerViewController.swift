//
//  PhotoPickerViewController.swift
//  HBook
//
//  Created by 臧乾坤 on 2017/4/23.
//  Copyright © 2017年 臧乾坤. All rights reserved.
//

import UIKit

protocol PhotoPickerDelegate {
    
    func getImageFromPicker(image:UIImage)
    
    
}

class PhotoPickerViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var alert:UIAlertController?
    
    var picker: UIImagePickerController!
    
    var delegate:PhotoPickerDelegate!
    
    init() {
        
        super.init(nibName:nil,bundle:nil)
        
        self.modalPresentationStyle = .overFullScreen
        
        self.view.backgroundColor = UIColor.clear
        //
        self.picker = UIImagePickerController()
        self.picker.allowsEditing = false
        self.picker.delegate = self
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()

       
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewDidAppear(_ animated: Bool) {
        
        if self.alert == nil {
            
            self.alert = UIAlertController(title:nil,message:nil,preferredStyle:.actionSheet)
            
            self.alert?.addAction(UIAlertAction(title: "从相册选择", style: .default, handler: { (action) in
                
                 self.localPhoto()
                
            }))
            
           
            
            self.alert?.addAction(UIAlertAction(title:"打开相机",style:.default,handler:{ (action) in
                
                self.takePhoto()
                
            }))
            
            self.alert?.addAction(UIAlertAction(title:"取消",style:.cancel,handler:{ (action) in
                
                
            }))
            
            self.present(self.alert!, animated: true, completion: {
                
            })
            
        }
        
    }
    
    /**
     *打开相机
     **/
    func takePhoto() {
        
        if  UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            self.picker.sourceType = .camera
            self.present(self.picker, animated: true, completion: {
                
            })
            
            
        } else {
            
            let alertView = UIAlertController(title:"此机型无相机",message:nil,preferredStyle:.alert)
            alertView.addAction(UIAlertAction(title: "关闭", style: .cancel, handler: { (action) in
                
                self.dismiss(animated: true, completion: {
                
                })
                
            }))
            
            self.present(alertView, animated: true, completion: {
                
            })
            
        }
        
    }
    
    /**
     *打开相册
     **/
    func localPhoto() {
        
        self.picker.sourceType = .photoLibrary
        self.picker.allowsEditing = true
        self.picker.mediaTypes = ["public.image"]
        
        self.present(self.picker, animated: true,completion: {
            
        })
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.picker.dismiss(animated: true) { 
        
            self.dismiss(animated: true, completion: {
                
            })
            
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.picker.dismiss(animated: true, completion: { 
            
            self.delegate.getImageFromPicker(image: image)
            
        })
        
    }

}

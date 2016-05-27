//
//  ViewController+Extension.swift
//  PDD
//
//  Created by 周磊 on 16/3/16.
//  Copyright © 2016年 ZL. All rights reserved.
//

import Foundation

extension UIViewController {
    
     func showHUD() {
              
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.Native)
        SVProgressHUD.show()
        
        
        
    }
    
    
    func hideHUD(){
        SVProgressHUD.dismiss()
    }
    
    /**
     显示错误提示框并在1秒后自动隐藏提示
     
     - parameter title: 提示信息
     */
    func showErrorAllTextDialog(title:String) {
        
        SVProgressHUD.showErrorWithStatus(title)

    }
    
    func showStatusHub(title:String) {
        SVProgressHUD.showImage(nil, status: title)
    }
    
    
}
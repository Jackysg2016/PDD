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
    
}
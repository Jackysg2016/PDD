//
//  BaseViewController.swift
//  PDD
//
//  Created by 周磊 on 16/3/14.
//  Copyright © 2016年 ZL. All rights reserved.
//  基类控制器

import UIKit
import SnapKit

class BaseViewController: UIViewController,UIGestureRecognizerDelegate {
    
    var titleLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        /**允许右滑返回*/
        self.navigationController!.interactivePopGestureRecognizer!.enabled = true;
        self.navigationController!.interactivePopGestureRecognizer!.delegate = self;
        configureInterface()
    }
    /**右侧分享按钮*/
    private func configureInterface() {
        let rightBtn = UIBarButtonItem(title: "", style: .Plain, target: self, action: #selector(BaseViewController.share))
        rightBtn.image = UIImage(named: "share")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        navigationItem.rightBarButtonItem = rightBtn
    }
    
    func share(){
        print("分享")
    }
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if self.navigationController?.viewControllers.count == 1 {
            return false
        }else{
            return true
        }
    }
    
}

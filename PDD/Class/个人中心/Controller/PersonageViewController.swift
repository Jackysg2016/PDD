//
//  PersonageViewController.swift
//  PDD
//
//  Created by 周磊 on 16/3/15.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class PersonageViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.yellowColor()
        
        let  button = UIButton(type: UIButtonType.Custom)

        button.frame = CGRectMake(50, 50, 50, 50)
        
        button.setTitle("跳转", forState: UIControlState.Normal)
        button.addTarget(self, action: "tiao", forControlEvents: UIControlEvents.TouchUpInside)
        
        view.addSubview(button)
        
        
    }
    
    func tiao(){
        let mmm = FDDSYViewController()
        
        self.navigationController?.pushViewController(mmm, animated: true)
        
    }
    
    
}

//
//  PersonTypeCellFour.swift
//  PDD
//
//  Created by 周磊 on 16/3/24.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class PersonTypeCellFour: UICollectionViewCell {
    
    var loginLabel:UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loginLabel  = UILabel()
        loginLabel?.textColor = UIColor.blackColor()
        loginLabel?.text = "点击登录"
        loginLabel?.font = UIFont.systemFontOfSize(15)
        self.addSubview(loginLabel!)
        loginLabel?.snp_makeConstraints(closure: { (make) in
            make.centerY.equalTo(self.snp_centerY).offset(0)
            make.centerX.equalTo(self.snp_centerX).offset(0)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

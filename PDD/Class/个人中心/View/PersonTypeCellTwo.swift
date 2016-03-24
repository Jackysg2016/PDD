//
//  PersonTypeCellTwo.swift
//  PDD
//
//  Created by 周磊 on 16/3/24.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class PersonTypeCellTwo: UICollectionViewCell {
    
    var arrowImageView:UIImageView?
    var title:UILabel?
    var allTitle:UILabel?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        arrowImageView = UIImageView()
        arrowImageView?.image = UIImage(named: "forwardWeixinAddress-11b7e073ce")
        self.addSubview(arrowImageView!)
        arrowImageView?.snp_makeConstraints(closure: { (make) in
            make.centerY.equalTo(self.snp_centerY).offset(0)
            make.right.equalTo(self).offset(-20)
            make.width.height.equalTo(20)
        })
        
        allTitle = UILabel()
        allTitle?.textColor = UIColor.grayColor()
        allTitle?.font = UIFont.systemFontOfSize(13)
        allTitle?.text = "查看全部订单"
        self.addSubview(allTitle!)
        allTitle?.snp_makeConstraints(closure: { (make) in
            make.centerY.equalTo(self.snp_centerY).offset(0)
            make.right.equalTo(arrowImageView!.snp_left).offset(-5)

        })
        
        title = UILabel()
        title?.textColor = UIColor.blackColor()
        title?.font = UIFont.systemFontOfSize(15)
        title?.text = "我的订单"
        self.addSubview(title!)
        title?.snp_makeConstraints(closure: { (make) in
            make.centerY.equalTo(self.snp_centerY).offset(0)
            make.left.equalTo(self).offset(10)
        })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

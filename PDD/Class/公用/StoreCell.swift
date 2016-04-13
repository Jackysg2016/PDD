//
//  StoreCell.swift
//  PDD
//
//  Created by 周磊 on 16/4/13.
//  Copyright © 2016年 ZL. All rights reserved.
//  店铺信息

import UIKit
import SwiftyJSON

class StoreCell: UICollectionViewCell {
    
    /// 头像
    var headImageView:UIImageView!
    /// 店铺名称
    var storeName:UILabel!
        /// 销量
    var salesLabel:UILabel!
    
    var storeDataSouce = shopInformation() {
        
        didSet {
            
            storeName.text = storeDataSouce.mall_name
            salesLabel.text = "销量: \(storeDataSouce.mall_sales!)"
            
            let url = NSURL.init(string: storeDataSouce.logo!)
            headImageView.pdd_setImageWithURL(url!, placeholderImage: UIImage(named: "wu.jpg")!)
        }
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let topView = UIView()
        topView.backgroundColor = BgColor
        self.contentView.addSubview(topView)
        topView.snp_makeConstraints { (make) in
            make.right.left.equalTo(self).offset(0)
            make.top.equalTo(self).offset(0)
            make.height.equalTo(10)
        }
        
        let centerView = UIImageView()
        centerView.image = UIImage(named: "jindian")
        self.contentView.addSubview(centerView)
        centerView.snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.bottom.equalTo(self).offset(-10)
            make.left.right.equalTo(self).offset(0)
        }
        
        headImageView = UIImageView()
        headImageView.layer.borderWidth = 1
        headImageView.layer.borderColor = UIColor.grayColor().CGColor
        headImageView.image = UIImage(named: "share_logo-f82dde64bd")
        self.contentView.addSubview(headImageView)
        headImageView.snp_makeConstraints { (make) in
            make.centerY.equalTo(centerView.snp_centerY).offset(0)
            make.left.equalTo(self).offset(10)
            make.width.height.equalTo(50)
        }
        storeName = UILabel()
        storeName.font = UIFont.systemFontOfSize(15)
        storeName.textColor = UIColor.blackColor()
        storeName.text = "酣畅"
        self.contentView.addSubview(storeName)
        storeName.snp_makeConstraints { (make) in
            make.left.equalTo(headImageView.snp_right).offset(10)
            make.top.equalTo(centerView.snp_top).offset(7)
        }
        
        salesLabel = UILabel()
        salesLabel.font = UIFont.systemFontOfSize(13)
        salesLabel.textColor = UIColor.grayColor()
        salesLabel.text = "销量: 166160"
        self.contentView.addSubview(salesLabel)
        salesLabel.snp_makeConstraints { (make) in
            make.left.equalTo(headImageView.snp_right).offset(10)
            make.bottom.equalTo(centerView.snp_bottom).offset(-7)
        }
        
        
        let bottomView = UIView()
        bottomView.backgroundColor = BgColor
        self.contentView.addSubview(bottomView)
        bottomView.snp_makeConstraints { (make) in
            make.right.left.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(0)
            make.height.equalTo(10)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

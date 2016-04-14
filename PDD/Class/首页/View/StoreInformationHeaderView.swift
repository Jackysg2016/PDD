//
//  StoreInformationHeaderView.swift
//  PDD
//
//  Created by 周磊 on 16/4/14.
//  Copyright © 2016年 ZL. All rights reserved.
//  店铺信息

import UIKit
import SwiftyJSON
class StoreInformationHeaderView: UIView {
    
    /// 头像
    var headImageView:UIImageView!
    /// 店铺名称
    var storeName:UILabel!
    /// 销量
    var salesLabel:UILabel!
        /// 店铺说明
    var storeDesc:UILabel!
    
    var StoreInformation:JSON = [] {
        
        didSet {
            storeName.text = String(StoreInformation["mall_name"])

            salesLabel.text = "销量: \(String(StoreInformation["mall_sales"]))"

            storeDesc.text = String(StoreInformation["mall_desc"])

            let url = NSURL.init(string: String(StoreInformation["logo"]))
            headImageView.pdd_setImageWithURL(url!, placeholderImage: UIImage(named: "wu.jpg")!)
            
        }
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let bgView = UIView()
        bgView.backgroundColor = UIColor.whiteColor()
        self.addSubview(bgView)
        bgView.snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.left.right.bottom.equalTo(self).offset(0)
        }
        
        headImageView = UIImageView()
        headImageView.layer.borderWidth = 1
        headImageView.layer.borderColor = UIColor.grayColor().CGColor
        headImageView.image = UIImage(named: "share_logo-f82dde64bd")
        bgView.addSubview(headImageView)
        headImageView.snp_makeConstraints { (make) in
            make.left.top.equalTo(bgView).offset(10)
            make.width.height.equalTo(50)
        }
        
        storeName = UILabel()
        storeName.font = UIFont.systemFontOfSize(15)
        storeName.textColor = UIColor.blackColor()
        storeName.text = "酣畅"
        bgView.addSubview(storeName)
        storeName.snp_makeConstraints { (make) in
            make.left.equalTo(headImageView.snp_right).offset(10)
            make.top.equalTo(bgView).offset(7)
        }
        
        salesLabel = UILabel()
        salesLabel.font = UIFont.systemFontOfSize(13)
        salesLabel.textColor = UIColor.grayColor()
        salesLabel.text = "销量: 166160"
        bgView.addSubview(salesLabel)
        salesLabel.snp_makeConstraints { (make) in
            make.left.equalTo(headImageView.snp_right).offset(10)
            make.top.equalTo(storeName.snp_bottom).offset(10)
        }

        let lingView = UIView()
        lingView.backgroundColor = UIColor.grayColor()
        bgView.addSubview(lingView)
        lingView.snp_makeConstraints { (make) in
            make.left.right.equalTo(self).offset(0)
            make.top.equalTo(headImageView.snp_bottom).offset(10)
            make.height.equalTo(1)
        }
        
        storeDesc = UILabel()
        storeDesc.font = UIFont.systemFontOfSize(13)
        storeDesc.textColor = UIColor.grayColor()
        storeDesc.text = "韩束美妆"
        storeDesc.numberOfLines = 0
        bgView.addSubview(storeDesc)
        storeDesc.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.top.equalTo(lingView.snp_bottom).offset(5)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

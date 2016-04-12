//
//  GroupSpecificationCell.swift
//  PDD
//
//  Created by 周磊 on 16/4/12.
//  Copyright © 2016年 ZL. All rights reserved.
//  团购说明

import UIKit
import SwiftyJSON

class GroupSpecificationCell: UICollectionViewCell {
    
    var specificationLabel:UILabel?
    var basicDataSouce:JSON = [] {
        
        didSet {
            
            let attributeString = NSMutableAttributedString(string:"支付开团并邀请 \(basicDataSouce["group"][1]["customer_num"]) 人参团，人数不足自动退款")
            //从文本7开始3个字符字体16号
            attributeString.addAttribute(NSFontAttributeName,
                                         value: UIFont.systemFontOfSize(16),
                                         range: NSMakeRange(8,2))
//            //设置文字背景颜色
//            attributeString.addAttribute(NSBackgroundColorAttributeName,
//                                         value: UIColor.blackColor(),
//                                         range: NSMakeRange(8,2))
            specificationLabel!.attributedText = attributeString
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        specificationLabel = UILabel()
        specificationLabel?.font = UIFont.systemFontOfSize(13)
        specificationLabel?.textColor = UIColor.grayColor()
        self.contentView.addSubview(specificationLabel!)
        specificationLabel?.snp_makeConstraints(closure: { (make) in
            make.centerY.equalTo(self.snp_centerY).offset(0)
            make.left.equalTo(self).offset(10)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

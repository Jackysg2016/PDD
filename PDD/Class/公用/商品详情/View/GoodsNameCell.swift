//
//  GoodsNameCell.swift
//  PDD
//
//  Created by 周磊 on 16/4/11.
//  Copyright © 2016年 ZL. All rights reserved.
//  商品名称

import UIKit
import SwiftyJSON

class GoodsNameCell: UICollectionViewCell {
    
    var goodsName:UILabel!
    var basicDataSouce:JSON = [] {
        
        didSet {
            goodsName.text = String(basicDataSouce["goods_name"])
        }
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        goodsName = UILabel()
        goodsName.textColor = UIColor.blackColor()
        goodsName.font = UIFont.systemFontOfSize(15)
        goodsName.numberOfLines = 0
        self.contentView.addSubview(goodsName)
        goodsName.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(5)
            make.right.equalTo(self).offset(-5)
            make.top.bottom.equalTo(self).offset(0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

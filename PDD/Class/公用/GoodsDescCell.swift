//
//  GoodsDescCell.swift
//  PDD
//
//  Created by 周磊 on 16/4/11.
//  Copyright © 2016年 ZL. All rights reserved.
//  商品说明

import UIKit
import SwiftyJSON

class GoodsDescCell: UICollectionViewCell {
    
    var goodsDesc:UILabel!
    var basicDataSouce:JSON = [] {
        
        didSet {
            goodsDesc.text = String(basicDataSouce["goods_desc"])
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        goodsDesc = UILabel()
        goodsDesc.textColor = UIColor.grayColor()
        goodsDesc.font = UIFont.systemFontOfSize(15)
        goodsDesc.numberOfLines = 0
        self.contentView.addSubview(goodsDesc)
        goodsDesc.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(5)
            make.right.equalTo(self).offset(-5)
            make.top.bottom.equalTo(self).offset(0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

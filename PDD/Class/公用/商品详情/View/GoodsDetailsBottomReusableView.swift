//
//  GoodsDetailsBottomReusableView.swift
//  PDD
//
//  Created by 周磊 on 16/4/13.
//  Copyright © 2016年 ZL. All rights reserved.
//  已经到底部了

import UIKit
import SwiftyJSON

class GoodsDetailsBottomReusableView: UICollectionReusableView {
    
    var bottomLabel:UILabel!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        bottomLabel = UILabel()
        bottomLabel.font = UIFont.systemFontOfSize(13)
        bottomLabel.textColor = UIColor.grayColor()
        bottomLabel.textAlignment = NSTextAlignment.Center
        bottomLabel.text = "已经到底部了"
        self.addSubview(bottomLabel)
        bottomLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.snp_centerY).offset(0)
            make.centerX.equalTo(self.snp_centerX).offset(0)
        }
        
        let leftTransverseLineView = UIView()
        leftTransverseLineView.backgroundColor = UIColor.grayColor()
        self.addSubview(leftTransverseLineView)
        leftTransverseLineView.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.snp_centerY).offset(0)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(bottomLabel.snp_left).offset(-10)
            make.height.equalTo(0.5)
        }
        
        let rightTransverseLineView = UIView()
        rightTransverseLineView.backgroundColor = UIColor.grayColor()
        self.addSubview(rightTransverseLineView)
        rightTransverseLineView.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.snp_centerY).offset(0)
            make.right.equalTo(self).offset(-20)
            make.left.equalTo(bottomLabel.snp_right).offset(10)
            make.height.equalTo(0.5)

        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

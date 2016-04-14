
//
//  EvaluateCell.swift
//  PDD
//
//  Created by 周磊 on 16/4/13.
//  Copyright © 2016年 ZL. All rights reserved.
//  用户评价

import UIKit
import SwiftyJSON

class EvaluateCell: UICollectionViewCell {
    
        /// 分数
    var gradeLabel:UILabel!
        /// 评价数
    var commentLabel:UILabel!
        /// 箭头
    var arrowsImageView:UIImageView!
    
    var evaluateDataSouce:JSON = [] {
        
        didSet {
            
            commentLabel.text = "共\(String(evaluateDataSouce["number"]))条评论"
            
            let number = Float(String(evaluateDataSouce["average"]))
            let evaluateStr = round(number!*10)/10
            
            let AttributedStr = NSMutableAttributedString(string: "\(String(evaluateStr))分")
            AttributedStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSMakeRange(0, 3))
            gradeLabel.attributedText = AttributedStr;
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        let topView = UIView()
        topView.backgroundColor = BgColor
        self.contentView.addSubview(topView)
        topView.snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(0)
            make.left.right.equalTo(self).offset(0)
            make.height.equalTo(10)
        }

        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.whiteColor()
        self.contentView.addSubview(bottomView)
        bottomView.snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.left.right.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(0)
        }
        
        
        let userAppraisal = UILabel()
        userAppraisal.font = UIFont.systemFontOfSize(15)
        userAppraisal.textColor = UIColor.blackColor()
        userAppraisal.text = "用户评价"
        bottomView.addSubview(userAppraisal)
        userAppraisal.snp_makeConstraints { (make) in
            make.centerY.equalTo(bottomView.snp_centerY).offset(0)
            make.left.equalTo(self).offset(20)
        }
        
        arrowsImageView  = UIImageView()
        arrowsImageView.image = UIImage(named: "forwardWeixinAddress-11b7e073ce")
        bottomView.addSubview(arrowsImageView)
        arrowsImageView.snp_makeConstraints { (make) in
            make.centerY.equalTo(bottomView.snp_centerY).offset(0)
            make.width.height.equalTo(10)
            make.right.equalTo(self).offset(-10)
        }
        
        commentLabel = UILabel()
        commentLabel.font = UIFont.systemFontOfSize(13)
        commentLabel.textColor = UIColor.grayColor()
        commentLabel.text = "共23000条评论"
        bottomView.addSubview(commentLabel)
        commentLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(bottomView.snp_centerY).offset(0)
            make.right.equalTo(arrowsImageView.snp_left).offset(-5)
        }
        
        gradeLabel = UILabel()
        gradeLabel.font = UIFont.systemFontOfSize(15)
        gradeLabel.textColor = UIColor.grayColor()
        gradeLabel.text = "4.8分"
        bottomView.addSubview(gradeLabel)
        gradeLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(bottomView.snp_centerY).offset(0)
            make.right.equalTo(commentLabel.snp_left).offset(-5)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

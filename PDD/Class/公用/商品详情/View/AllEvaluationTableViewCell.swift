//
//  AllEvaluationTableViewCell.swift
//  PDD
//
//  Created by 周磊 on 16/4/14.
//  Copyright © 2016年 ZL. All rights reserved.
//  全部评价

import UIKit

class AllEvaluationTableViewCell: UIView {

    /// 分数
    var gradeLabel:UILabel!
    /// 评价数
    var commentLabel:UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let userAppraisal = UILabel()
        userAppraisal.font = UIFont.systemFontOfSize(15)
        userAppraisal.textColor = UIColor.blackColor()
        userAppraisal.text = "用户评价"
        self.addSubview(userAppraisal)
        userAppraisal.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.snp_centerY).offset(0)
            make.left.equalTo(self).offset(10)
        }
        
        commentLabel = UILabel()
        commentLabel.font = UIFont.systemFontOfSize(13)
        commentLabel.textColor = UIColor.grayColor()
        commentLabel.text = "共23000条评论"
        self.addSubview(commentLabel)
        commentLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.snp_centerY).offset(0)
            make.right.equalTo(self).offset(-10)
        }
        
        gradeLabel = UILabel()
        gradeLabel.font = UIFont.systemFontOfSize(15)
        gradeLabel.textColor = UIColor.grayColor()
        gradeLabel.text = "4.8分"
        self.addSubview(gradeLabel)
        gradeLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.snp_centerY).offset(0)
            make.right.equalTo(commentLabel.snp_left).offset(-5)
        }

    }
    
    func reloadDataSouce(number:String,average:String) {
        
        commentLabel.text = "共\(number)条评论"
        
        let number = Float(average)
        let evaluateStr = round(number!*10)/10
        
        let AttributedStr = NSMutableAttributedString(string: "\(String(evaluateStr))分")
        AttributedStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSMakeRange(0, 3))
        gradeLabel.attributedText = AttributedStr;
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

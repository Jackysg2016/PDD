//
//  EvaluateParticularsTableViewCell.swift
//  PDD
//
//  Created by 周磊 on 16/4/14.
//  Copyright © 2016年 ZL. All rights reserved.
//  评价详情---评价页

import UIKit

class EvaluateParticularsTableViewCell: UITableViewCell {

    /// 头像
    var headImageView:UIImageView!
    /// 人物名字
    var figureName:UILabel!
    /// 评价时间
    var evaluateTime:UILabel!
    /// 评价内容
    var evaluateContents:UILabel!
    /// xingxing
    var StarlaImageView:EvaluateImageView!
    
    var evaluation = productEvaluation() {
        
        didSet {
            
            figureName.text = evaluation.name!
            
            evaluateContents.text = evaluation.comment!
            
            let url = NSURL.init(string: evaluation.avatar!)
            headImageView.pdd_setImageWithURL(url!, placeholderImage: UIImage(named: "wu.jpg")!)
            
            let time = evaluation.time!
            let string = NSString(string: time)
            let timeSta:NSTimeInterval = string.doubleValue
            let dfmatter = NSDateFormatter()
            dfmatter.dateFormat="yyyy:MM:dd HH:mm:ss"
            let date = NSDate(timeIntervalSince1970: timeSta)
            evaluateTime.text = dfmatter.stringFromDate(date)
            
            let stars = Int(evaluation.stars!)
            for i in 0 ..< stars! {
                StarlaImageView = EvaluateImageView(frame:CGRectMake(0, 0, 10, 10))
                StarlaImageView.image = UIImage(named: "xingxing")
                self.contentView.addSubview(StarlaImageView)
                StarlaImageView.snp_makeConstraints(closure: { (make) in
                    make.top.equalTo(self).offset(10)
                    make.width.height.equalTo(10)
                    make.right.equalTo(self).offset(-(i*15)-10)
                })
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
                
        headImageView = UIImageView()
        headImageView.layer.masksToBounds = true
        headImageView.layer.cornerRadius = 15
        headImageView.image = UIImage(named: "youhuijuan")
        self.contentView.addSubview(headImageView)
        headImageView.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.top.equalTo(self).offset(10)
            make.width.height.equalTo(30)
        }
        
        
        figureName  = UILabel()
        figureName.font = UIFont.systemFontOfSize(13)
        figureName.textColor = UIColor.grayColor()
        figureName.text = "hahahahah"
        self.contentView.addSubview(figureName)
        figureName.snp_makeConstraints { (make) in
            make.left.equalTo(headImageView.snp_right).offset(10)
            make.top.equalTo(self).offset(5)
        }
        
        evaluateContents  = UILabel()
        evaluateContents.font = UIFont.systemFontOfSize(13)
        evaluateContents.textColor = UIColor.blackColor()
        evaluateContents.text = "就是里面加嫩肉粉了不好，嫩肉粉对身体有害"
        evaluateContents.numberOfLines = 0
        self.contentView.addSubview(evaluateContents)
        evaluateContents.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.top.equalTo(headImageView.snp_bottom).offset(10)
        }
        evaluateTime  = UILabel()
        evaluateTime.font = UIFont.systemFontOfSize(10)
        evaluateTime.textColor = UIColor.grayColor()
        evaluateTime.text = "2016.04.13 09:19:31"
        self.contentView.addSubview(evaluateTime)
        evaluateTime.snp_makeConstraints { (make) in
            make.left.equalTo(headImageView.snp_right).offset(10)
            make.top.equalTo(self).offset(25)
        }
    }

    // MARK: - 解决重用问题
    func removeObj() {
        
        for subView in (self.contentView.subviews) {
            if subView.isKindOfClass(EvaluateImageView) {
                subView.removeFromSuperview()
            }
        }
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

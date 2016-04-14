//
//  LotteryRulesCell.swift
//  PDD
//
//  Created by 周磊 on 16/4/11.
//  Copyright © 2016年 ZL. All rights reserved.
//  抽奖活动

import UIKit
import SwiftyJSON


class LotteryRulesCell: UICollectionViewCell {
    
    var lotteryRules:UILabel!
    var basicDataSouce:JSON = [] {
        
        didSet {
            let startTime = String(basicDataSouce["lucky_start_time"]).timeStampToString(String(basicDataSouce["lucky_start_time"]))
            let endTime = String(basicDataSouce["lucky_end_time"]).timeStampToString(String(basicDataSouce["lucky_end_time"]))
        
            let deseText = String(basicDataSouce["goods_name"])
            _ = deseText.rangeOfString("量")!
            _ = deseText.rangeOfString("份")!
            _ = deseText as NSString
            /// 不知道为嘛这个方法报错，oc就可以
//            var sub = deseString.substringWithRange(NSMakeRange(start.location, end.location))
            
            
            //一天的时间
            let oneDay:NSTimeInterval = 24*60*60
            let string = NSString(string: String(basicDataSouce["lucky_end_time"]))
            let timeSta:NSTimeInterval = string.doubleValue
            let dfmatter = NSDateFormatter()
            dfmatter.dateFormat="MM.dd"
            let date = NSDate(timeIntervalSince1970: timeSta)
             //三天后的时间
            let dateString =  dfmatter.stringFromDate(date.dateByAddingTimeInterval(oneDay*3))
            
            lotteryRules.text = "抽奖规则\n活动时间\(startTime)-\(endTime)\n1、活动结束后从组团成功的订单中随机抽取1000份。\n2、组团成功未抽中者退款+安慰代金券88元！\n3、中奖的商品预计\(dateString)号发放"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        lotteryRules = UILabel()
        lotteryRules.textColor = UIColor.grayColor()
        lotteryRules.font = UIFont.systemFontOfSize(15)
        lotteryRules.numberOfLines = 0
        self.contentView.addSubview(lotteryRules)
        lotteryRules.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(5)
            make.right.equalTo(self).offset(-5)
            make.top.bottom.equalTo(self).offset(0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

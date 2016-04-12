//
//  GroupPurchaseCell.swift
//  PDD
//
//  Created by 周磊 on 16/4/12.
//  Copyright © 2016年 ZL. All rights reserved.
//  团购详情

import UIKit
import SwiftyJSON

class GroupPurchaseCell: UICollectionViewCell {
        /// 头像
    var headImageView:UIImageView!
        /// 背景图片
    var bgImageView:UIImageView!
        /// 人物名字
    var figureName:UILabel!
         ///人物地址
    var figureAddress:UILabel!
        /// 成团人数
    var groupNumber:UILabel!
        /// 剩余时间
    var surplusTime:UILabel!
        /// 参团图片
    var groupImageView:UIImageView!
        /// 显示小时：
    var formatHourLabel:UILabel!
        /// 显示分钟：
    var formatMinuteLabel:UILabel!
        /// 结束
    var endTimeLabel:UILabel!
        /// 剩余
    var lastTimeLabel:UILabel!
        /// 时
    var lastHourLabel:UILabel!
        /// 分
    var lastMinuteLabel:UILabel!
         /// 秒
    var lastSecondeLabel:UILabel!

    var overdate:NSString!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        groupImageView = UIImageView()
        groupImageView.image = UIImage(named: "canjia1")
        self.contentView.addSubview(groupImageView)
        groupImageView.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.snp_centerY).offset(0)
            make.right.equalTo(self).offset(-25)
            make.height.equalTo(35)
            make.width.equalTo(70)
        }
        
        bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "hongkuang")
        self.contentView.addSubview(bgImageView)
        bgImageView.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.snp_centerY).offset(0)
            make.right.equalTo(groupImageView.snp_left).offset(0)
            make.height.equalTo(35)
            make.left.equalTo(self).offset(20)
        }
        
        headImageView = UIImageView()
        headImageView.layer.masksToBounds = true
        headImageView.layer.cornerRadius = 20
        headImageView.image = UIImage(named: "youhuijuan")
        self.contentView.addSubview(headImageView)
        headImageView.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.snp_centerY).offset(0)
            make.left.equalTo(self).offset(10)
            make.width.height.equalTo(40)
        }
        
        let garyView = UIView()
        garyView.backgroundColor = BgColor
        self.contentView.addSubview(garyView)
        garyView.snp_makeConstraints { (make) in
            make.left.right.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(-1)
            make.height.equalTo(1)
        }
        
        figureName  = UILabel()
        figureName.font = UIFont.systemFontOfSize(13)
        figureName.textColor = UIColor.blackColor()
        self.contentView.addSubview(figureName)
        figureName.snp_makeConstraints { (make) in
            make.top.equalTo(bgImageView.snp_top).offset(2)
            make.left.equalTo(headImageView.snp_right).offset(10)
//            make.width.equalTo(60)

        }
        
        figureAddress  = UILabel()
        figureAddress.font = UIFont.systemFontOfSize(11)
        figureAddress.textColor = UIColor.grayColor()
        self.contentView.addSubview(figureAddress)
        figureAddress.snp_makeConstraints { (make) in
            make.bottom.equalTo(bgImageView.snp_bottom).offset(-2)
            make.left.equalTo(headImageView.snp_right).offset(10)
        }
        
        
        groupNumber  = UILabel()
        groupNumber.font = UIFont.systemFontOfSize(10)
        groupNumber.textColor = UIColor.redColor()
        self.contentView.addSubview(groupNumber)
        groupNumber.snp_makeConstraints { (make) in
            make.top.equalTo(bgImageView.snp_top).offset(2)
            make.right.equalTo(groupImageView.snp_left).offset(-10)
        }
        
        endTimeLabel = UILabel()
        endTimeLabel.text = "结束"
        endTimeLabel.font = UIFont.systemFontOfSize(10)
        endTimeLabel.textColor = UIColor.grayColor()
        self.contentView.addSubview(endTimeLabel)
        endTimeLabel.snp_makeConstraints { (make) in
            make.bottom.equalTo(bgImageView.snp_bottom).offset(-2)
            make.right.equalTo(groupImageView.snp_left).offset(-10)
        }
        
        lastSecondeLabel = UILabel()
        lastSecondeLabel.text = "11"
        lastSecondeLabel.font = UIFont.systemFontOfSize(10)
        lastSecondeLabel.textColor = UIColor.grayColor()
        self.contentView.addSubview(lastSecondeLabel)
        lastSecondeLabel.snp_makeConstraints { (make) in
            make.bottom.equalTo(bgImageView.snp_bottom).offset(-2)
            make.right.equalTo(endTimeLabel.snp_left).offset(-1)
        }

        formatMinuteLabel = UILabel()
        formatMinuteLabel.text = ":"
        formatMinuteLabel.font = UIFont.systemFontOfSize(10)
        formatMinuteLabel.textColor = UIColor.grayColor()
        self.contentView.addSubview(formatMinuteLabel)
        formatMinuteLabel.snp_makeConstraints { (make) in
            make.bottom.equalTo(bgImageView.snp_bottom).offset(-2)
            make.right.equalTo(lastSecondeLabel.snp_left).offset(-1)
        }
        
        lastMinuteLabel = UILabel()
        lastMinuteLabel.text = "55"
        lastMinuteLabel.font = UIFont.systemFontOfSize(10)
        lastMinuteLabel.textColor = UIColor.grayColor()
        self.contentView.addSubview(lastMinuteLabel)
        lastMinuteLabel.snp_makeConstraints { (make) in
            make.bottom.equalTo(bgImageView.snp_bottom).offset(-2)
            make.right.equalTo(formatMinuteLabel.snp_left).offset(-1)
        }
        
        formatHourLabel = UILabel()
        formatHourLabel.text = ":"
        formatHourLabel.font = UIFont.systemFontOfSize(10)
        formatHourLabel.textColor = UIColor.grayColor()
        self.contentView.addSubview(formatHourLabel)
        formatHourLabel.snp_makeConstraints { (make) in
            make.bottom.equalTo(bgImageView.snp_bottom).offset(-2)
            make.right.equalTo(lastMinuteLabel.snp_left).offset(-1)
        }
        
        lastHourLabel = UILabel()
        lastHourLabel.text = "23"
        lastHourLabel.font = UIFont.systemFontOfSize(10)
        lastHourLabel.textColor = UIColor.grayColor()
        self.contentView.addSubview(lastHourLabel)
        lastHourLabel.snp_makeConstraints { (make) in
            make.bottom.equalTo(bgImageView.snp_bottom).offset(-2)
            make.right.equalTo(formatHourLabel.snp_left).offset(-1)
        }
        
        lastTimeLabel = UILabel()
        lastTimeLabel.text = "剩余"
        lastTimeLabel.font = UIFont.systemFontOfSize(10)
        lastTimeLabel.textColor = UIColor.grayColor()
        self.contentView.addSubview(lastTimeLabel)
        lastTimeLabel.snp_makeConstraints { (make) in
            make.bottom.equalTo(bgImageView.snp_bottom).offset(-2)
            make.right.equalTo(lastHourLabel.snp_left).offset(-1)
        }
        
        
    }
    
    func reloadDataSouce(basicDataSouce:String) {
        
        let  jsonData = basicDataSouce.dataUsingEncoding(NSUTF8StringEncoding)
        let jsonDict = try! NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
        
        let url = NSURL.init(string: jsonDict["avatar"]! as! String)
        headImageView.pdd_setImageWithURL(url!, placeholderImage: UIImage(named: "homeWu.png")!)
        
        figureName.text = jsonDict["nickname"]! as? String
        figureAddress.text = jsonDict["city_name"]! as? String
        
        groupNumber.text = "还差1人成团"
        
                /// 获取结束的时间，并转为NSString类型
        let time = jsonDict["expire_time"]! as! String
        let string = NSString(string: time)
        let timeSta:NSTimeInterval = string.doubleValue
        let dfmatter = NSDateFormatter()
        dfmatter.dateFormat="yyyy-MM-dd HH:mm:ss"
        let date = NSDate(timeIntervalSince1970: timeSta)
        overdate = dfmatter.stringFromDate(date)
        
        /**添加定时器*/
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(GroupPurchaseCell.timerFireMethod(_:)), userInfo: nil, repeats: true)
        
    }

    /**实现定时器方法，每隔一秒执行一次*/
    func timerFireMethod(theTimer:NSTimer) {
        //定义一个NSCalendar对象
        let cal = NSCalendar.currentCalendar()
         //初始化目标时间...
        let lastime = NSDateComponents()
        
        var year:Int!
        var month:Int!
        var day:Int!
        var hour:Int!
        var minute:Int!
        var second:Int!

        var timeStart = true
        if timeStart == true {//从NSDate中取出年月日，时分秒
            year = Int(overdate.substringWithRange(NSMakeRange(0, 4)))
            month = Int(overdate.substringWithRange(NSMakeRange(5, 2)))
            day = Int(overdate.substringWithRange(NSMakeRange(8, 2)))
            hour = Int(overdate.substringWithRange(NSMakeRange(11, 2)))
            minute = Int(overdate.substringWithRange(NSMakeRange(14, 2)))
            second = Int(overdate.substringWithRange(NSMakeRange(17, 2)))
            timeStart = false
        }

        lastime.year = year
        lastime.month = month
        lastime.day = day
        lastime.hour = hour
        lastime.minute = minute
        lastime.second = second

        //把目标时间装载入date
        let todate = cal.dateFromComponents(lastime)
        //获取当前时间
        let nowDate = NSDate()
    
        let d = cal.components([NSCalendarUnit.Year,.Month,.Day,.Hour,.Minute,.Second], fromDate: nowDate, toDate: todate!, options: [])
        
         lastHourLabel.text = String(format: "%02ld", d.hour)
         lastMinuteLabel.text = String(format: "%02ld", d.minute)
         lastSecondeLabel.text = String(format: "%02ld", d.second)
        
        
        if d.hour < 0 {//关闭定时器
            theTimer.invalidate()
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

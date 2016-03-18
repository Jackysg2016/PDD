//
//  HomeFirstTableViewCell.swift
//  PDD
//
//  Created by 周磊 on 16/3/16.
//  Copyright © 2016年 ZL. All rights reserved.
//  首页cell样式1

import UIKit

class HomeFirstTableViewCell: UITableViewCell,UITextFieldDelegate {

    var goodsImageView:UIImageView?
    var goodsName:UILabel?
    var determineButton:UIButton?
    var importField:UITextField?
    var smallIcon:UIImageView?

    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        goodsImageView = UIImageView()
        self.contentView.addSubview(goodsImageView!)
        goodsImageView?.snp_makeConstraints(closure: { (make) -> Void in
            make.left.equalTo(self).offset(10)
            make.top.equalTo(self).offset(20)
            make.bottom.equalTo(self).offset(0)
            make.width.equalTo(60)
        })
        smallIcon = UIImageView()
        smallIcon?.image = UIImage(named: "wen.jpg")
        self.contentView.addSubview(smallIcon!)
        smallIcon?.snp_makeConstraints(closure: { (make) -> Void in
            make.left.equalTo(goodsImageView!.snp_right).offset(10)
            make.top.equalTo(self).offset(20)
            make.width.height.equalTo(15)
        })
        
        goodsName = UILabel()
        goodsName?.textColor = UIColor.grayColor()
        goodsName?.font = UIFont.systemFontOfSize(12)
        goodsName?.numberOfLines = 0
        self.contentView.addSubview(goodsName!)
        goodsName?.snp_makeConstraints(closure: { (make) -> Void in
            make.top.equalTo(self).offset(20)
            make.left.equalTo(smallIcon!.snp_right).offset(5)
            make.right.equalTo(self).offset(-10)

        })
        
        determineButton = UIButton()
        determineButton?.setTitle("确认", forState: UIControlState.Normal)
        determineButton?.setBackgroundImage(UIImage(named: "redBtn"), forState: UIControlState.Normal)
        determineButton?.addTarget(self, action: "determine", forControlEvents: UIControlEvents.TouchUpInside)
        determineButton?.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.contentView.addSubview(determineButton!)
        
        determineButton?.snp_makeConstraints(closure: { (make) -> Void in
            make.right.equalTo(self).offset(-10)
            make.width.equalTo(60)
            make.height.equalTo(30)
            make.bottom.equalTo(self).offset(0)
        })
        
        importField = UITextField()
        importField?.placeholder = "请输入“参团专享码”"
        importField?.borderStyle = UITextBorderStyle.RoundedRect
        importField?.font = UIFont.systemFontOfSize(12)
        importField!.layer.borderColor = UIColor.redColor().CGColor
        importField?.layer.borderWidth = 1
        importField?.delegate = self
        self.contentView.addSubview(importField!)

        importField?.snp_makeConstraints(closure: { (make) -> Void in
            make.left.equalTo(goodsImageView!.snp_right).offset(10)
            make.right.equalTo(determineButton!.snp_left).offset(-10)
            make.bottom.equalTo(self).offset(0)

        })
    }

    func releaseData(homeData:HomeTotalData){
        
        goodsName?.text = homeData.mobile_app.desc
        let imageURL = NSURL(string:homeData.mobile_app.thumb_url!)
        goodsImageView?.wxn_setImageWithURL(imageURL!, placeholderImage: UIImage(named:"homeWu.png")!)
    }

    func determine(){
        print("确定")
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        importField?.resignFirstResponder()
        
        return true
    }
    
       
}

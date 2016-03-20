//
//  HomeMainTableViewCell.swift
//  PDD
//
//  Created by zhoulei on 16/3/15.
//  Copyright © 2016年 ZL. All rights reserved.
//  首页主要cell

import UIKit


class HomeMainTableViewCell: UITableViewCell {

    var bgView:UIView?
    var goodsImageView:UIImageView?
    var goodsName:UILabel?
    var collectButton:UIButton?
    var group:UILabel?
    
     override  init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        bgView = UIView()
        bgView?.backgroundColor = UIColor.whiteColor()
        bgView?.layer.borderWidth = 1
        bgView?.layer.borderColor = BorderColor.CGColor
        self.contentView.addSubview(bgView!)
        bgView?.snp_makeConstraints(closure: { (make) -> Void in
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.top.equalTo(20)
            make.bottom.equalTo(self).offset(0)
        })
        
        goodsImageView = UIImageView()
        bgView?.addSubview(goodsImageView!)
        
        goodsImageView?.snp_makeConstraints(closure: { (make) -> Void in
            make.top.left.right.equalTo(bgView!)
            make.height.equalTo(180)
        })
        
        goodsName = UILabel()
        goodsName?.numberOfLines = 0
        goodsName?.font = UIFont.systemFontOfSize(15)
        goodsName?.textColor = UIColor.blackColor()
        bgView?.addSubview(goodsName!)
        
        goodsName?.snp_makeConstraints(closure: { (make) -> Void in
            make.left.equalTo(bgView!).offset(10)
            make.top.equalTo(goodsImageView!.snp_bottom).offset(5)
            make.right.equalTo(bgView!).offset(-10)
        })
        
        collectButton = UIButton(type: UIButtonType.Custom)
        collectButton?.setImage(UIImage(named: "collection_1.jpg"), forState: UIControlState.Normal)
        collectButton?.addTarget(self, action: "collection", forControlEvents: UIControlEvents.TouchUpInside)
        bgView?.addSubview(collectButton!)
        
        collectButton?.snp_makeConstraints(closure: { (make) -> Void in
            make.right.equalTo(bgView!).offset(-15)
            make.width.equalTo(30)
            make.height.equalTo(28)
            make.top.equalTo(goodsName!.snp_bottom).offset(10)
        })
                
    }

    func collection(){
        
        collectButton?.setImage(UIImage(named: "collection.jpg"), forState: UIControlState.Normal)
        print("收藏")
        
    }
    
    func releaseData(homeData:HomeModel){
        
        goodsName?.text = homeData.goods_name
        
    let imageURL = NSURL(string:homeData.image_url!)
        
        goodsImageView?.pdd_setImageWithURL(imageURL!, placeholderImage: UIImage(named: "homeWu.png")!)
        
        let tempString = homeData.list_desc?.stringByReplacingOccurrencesOfString("[", withString: "")

        let temp = tempString!.stringByReplacingOccurrencesOfString("]", withString: "")
        
        let strArray = temp.componentsSeparatedByString(",")
        
        
     
        
        
        for ddd in strArray {
            

//            print(replaceUnicode(ddd))

        }
        /*Optional(0.0)
        "\u9632\u6c34"
        "\u643a\u5e26\u65b9\u4fbf"
        " \u65c5\u884c\u5c45\u5bb6\u5fc5\u5907"
        "\u6cf0\u56fd\u8fdb\u53e3\u69b4\u83b2"
        "\u65b0\u9c9c\u7a7a\u8fd0 \u8d28\u5730\u9971\u6ee1"
        "\u6d3b\u8840\u6563\u5bd2 \u5065\u813e\u8865\u6c14"
*/
        /*\u9632\u6c34
        \u643a\u5e26\u65b9\u4fbf
        \u65c5\u884c\u5c45\u5bb6\u5fc5\u5907
        \u6cf0\u56fd\u8fdb\u53e3\u69b4\u83b2
        \u65b0\u9c9c\u7a7a\u8fd0 \u8d28\u5730\u9971\u6ee1
        \u6d3b\u8840\u6563\u5bd2 \u5065\u813e\u8865\u6c14
*/
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    func replaceUnicode(unicodeStr:String) -> String{
//        
//        let tempStr1 = unicodeStr.stringByReplacingOccurrencesOfString("\\u", withString: "\\u")
//        let tempStr2 = tempStr1.stringByReplacingOccurrencesOfString("", withString: "\\")
//        let tempStr3 = "".stringByAppendingString(tempStr2).stringByAppendingString("")
//        let tempData = tempStr3.dataUsingEncoding(NSUTF8StringEncoding)
//        let returnStr = NSPropertyListSerialization.propertyListFromData(tempData!, mutabilityOption: NSPropertyListMutabilityOptions.Immutable, format: nil, errorDescription: nil)
//        
//        
//        return returnStr!.stringByReplacingOccurrencesOfString("\\r\\n",withString:"\n")
//
//    }
//    
    
    
}
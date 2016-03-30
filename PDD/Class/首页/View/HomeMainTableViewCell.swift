//
//  HomeMainTableViewCell.swift
//  PDD
//
//  Created by zhoulei on 16/3/15.
//  Copyright © 2016年 ZL. All rights reserved.
//  首页主要cell

import UIKit


class HomeMainTableViewCell: UITableViewCell {
///背景视图
    var bgView:UIView?
///商品图片
    var goodsImageView:UIImageView?
///商品名称
    var goodsName:UILabel?
///收藏按钮
    var collectButton:UIButton?
///圆点图片
    var dotImage:UIImageView?
///横线图片
    var stripingImageView:UIImageView?
///详细说明
    var stateLabel:IntroductionLabel?
///开团背景图片
    var regimentImageView:UIImageView?
///开团人数
    var regimentPersonLabel:UILabel?
///开团价
    var piceLabel:UILabel?
    
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
        collectButton?.addTarget(self, action: #selector(HomeMainTableViewCell.collection), forControlEvents: UIControlEvents.TouchUpInside)
        bgView?.addSubview(collectButton!)
        collectButton?.snp_makeConstraints(closure: { (make) -> Void in
            make.right.equalTo(bgView!).offset(-15)
            make.width.equalTo(30)
            make.height.equalTo(28)
            make.top.equalTo(goodsName!.snp_bottom).offset(10)
        })
        
        regimentImageView = UIImageView()
        regimentImageView?.image = UIImage(named: "kaituan")
        regimentImageView!.layer.masksToBounds = true
        regimentImageView!.layer.cornerRadius = 3
        bgView?.addSubview(regimentImageView!)
        regimentImageView?.snp_makeConstraints(closure: { (make) -> Void in
            make.centerY.equalTo(collectButton!.snp_centerY).offset(0)
            make.left.equalTo(bgView!).offset(10)
            make.height.equalTo(35)
            make.right.equalTo(collectButton!.snp_left).offset(-30)

        })
        
        regimentPersonLabel = UILabel()
        regimentPersonLabel?.font = UIFont.systemFontOfSize(10)
        regimentPersonLabel?.textColor = UIColor.whiteColor()
        bgView?.addSubview(regimentPersonLabel!)
        regimentPersonLabel?.snp_makeConstraints(closure: { (make) -> Void in
            make.centerY.equalTo(regimentImageView!.snp_centerY).offset(0)
            make.left.equalTo(regimentImageView!.snp_left).offset(30)
        })
        
        piceLabel = UILabel()
        piceLabel?.font = UIFont.systemFontOfSize(17)
        piceLabel?.textColor = UIColor.whiteColor()
        bgView?.addSubview(piceLabel!)
        piceLabel?.snp_makeConstraints(closure: { (make) -> Void in
            make.centerY.equalTo(regimentImageView!.snp_centerY).offset(0)
            make.left.equalTo(regimentPersonLabel!.snp_right).offset(10)
        })
        
    }

    func collection(){
        
//        collectButton?.setImage(UIImage(named: "collection.jpg"), forState: UIControlState.Normal)
        print("收藏")
        
    }
    
    
    
    func releaseData(homeData:HomeModel,secton:Int){
        
        if homeData.customer_num != nil {
            regimentPersonLabel?.text = homeData.customer_num! + "人团"
        }
        if homeData.price != nil {
            var pice :Float?
            pice = NSString(string: homeData.price!).floatValue / 100
            var price:String?
            price = String(format: "%.2f", pice!)
            piceLabel?.text = "¥ " +  price!
        }
        if homeData.goods_name != nil {
            goodsName?.text = homeData.goods_name
        }
        if homeData.image_url != nil {
            let imageURL = NSURL(string:homeData.image_url!)
            goodsImageView?.pdd_setImageWithURL(imageURL!, placeholderImage: UIImage(named: "homeWu.png")!)
        }
        if homeData.list_desc != nil {
            let  jsonData = homeData.list_desc?.dataUsingEncoding(NSUTF8StringEncoding)
            let jsonArray = try! NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
            
            for i in 0 ..< jsonArray.count {
                
                dotImage = UIImageView()
                dotImage?.image = UIImage(named: "dot.jpg")
                dotImage!.layer.masksToBounds = true
                dotImage!.layer.cornerRadius = 5
                bgView?.addSubview(dotImage!)
                dotImage?.snp_makeConstraints(closure: { (make) in
                    make.centerX.equalTo(bgView!.snp_centerX).offset(ScreenWidth/4/2)
                    make.top.equalTo(self).offset((i*30)+70)
                    make.width.height.equalTo(10)
                })
                stripingImageView = UIImageView()
                stripingImageView?.image = UIImage(named: "line-836fc0900f")
                bgView?.addSubview(stripingImageView!)
                stripingImageView?.snp_makeConstraints(closure: { (make) in
                    make.centerY.equalTo(dotImage!.snp_centerY).offset(0)
                    make.left.equalTo(dotImage!.snp_right).offset(5)
                    make.right.equalTo(bgView!).offset(-5)
                    make.height.equalTo(1)
                })
                stateLabel = IntroductionLabel()
                stateLabel?.font = UIFont.systemFontOfSize(10)
                stateLabel?.textColor = UIColor.grayColor()
                stateLabel?.text = jsonArray[i] as? String
                stateLabel?.hidden = false
                stateLabel?.tag = secton+1
                bgView?.addSubview(stateLabel!)
                stateLabel?.snp_makeConstraints(closure: { (make) in
                    make.left.equalTo(dotImage!.snp_right).offset(5)
                    make.bottom.equalTo(stripingImageView!.snp_top).offset(-2)
                })
            }
        }
    }
// MARK: - 解决重用问题
    func removeObj() {
        
        for subView in (bgView!.subviews) {
            if subView.isKindOfClass(IntroductionLabel) {
                subView.removeFromSuperview()
            }
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
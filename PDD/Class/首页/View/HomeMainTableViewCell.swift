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
    
    func releaseData(homeData:HomeTotalData){
        
        goodsName?.text = homeData.good_list.goods_name
        
    let imageURL = NSURL(string:homeData.good_list.image_url!)
        
        goodsImageView?.wxn_setImageWithURL(imageURL!, placeholderImage: UIImage(named: "homeWu.png")!)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

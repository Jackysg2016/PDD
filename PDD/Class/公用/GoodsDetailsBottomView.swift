//
//  GoodsDetailsBottomView.swift
//  PDD
//
//  Created by 周磊 on 16/4/8.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

typealias groupViewClickBlock = () -> Void
typealias aloneViewClickBlock = () -> Void
typealias buttonClickBlock = (Int) -> Void

class GoodsDetailsBottomView: UIView {
    
    var clickblock:groupViewClickBlock?
    var aloneClickblock:aloneViewClickBlock?
    var buttonBlock:buttonClickBlock?

    var homeButton:GoodsDetailsButton!///首页
    var enshrineButton:GoodsDetailsButton!///收藏
    var serviceButton:GoodsDetailsButton!///客服
    var aloneView:UIView!///单独购买
    var groupView:UIView!///团购
    var groupPrice:UILabel!///团购价
    var alonePrice:UILabel!///单独购买价
    var numberGroup:UILabel!///几人团
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        homeButton = GoodsDetailsButton()
        homeButton.setTitle("首页", forState: UIControlState.Normal)
        homeButton.tag = 1
        homeButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        homeButton.titleLabel?.font = UIFont.systemFontOfSize(10)
        homeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center;
        homeButton.setImage(UIImage(named: "index-38d3d45c2c"), forState: UIControlState.Normal)
        homeButton.addTarget(self, action: #selector(GoodsDetailsBottomView.click), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(homeButton)
        homeButton.snp_makeConstraints { (make) in
            make.top.left.bottom.equalTo(self).offset(0)
            make.width.equalTo(ScreenWidth/7-1)
        }
        
        enshrineButton = GoodsDetailsButton()
        enshrineButton.tag = 2
        enshrineButton.setTitle("收藏", forState: UIControlState.Normal)
        enshrineButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        enshrineButton.titleLabel?.font = UIFont.systemFontOfSize(10)
        enshrineButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center;
        enshrineButton.setImage(UIImage(named: "collection_1.jpg"), forState: UIControlState.Normal)
        enshrineButton.addTarget(self, action: #selector(GoodsDetailsBottomView.click), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(enshrineButton)
        enshrineButton.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(self).offset(0)
            make.left.equalTo(self).offset(ScreenWidth/7)
            make.width.equalTo(ScreenWidth/7-1)
        }
        
        serviceButton = GoodsDetailsButton()
        serviceButton.tag = 3
        serviceButton.setTitle("客服", forState: UIControlState.Normal)
        serviceButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        serviceButton.titleLabel?.font = UIFont.systemFontOfSize(10)
        serviceButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center;
        serviceButton.setImage(UIImage(named: "chat-4f13924c39"), forState: UIControlState.Normal)
        serviceButton.addTarget(self, action: #selector(GoodsDetailsBottomView.click), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(serviceButton)
        serviceButton.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(self).offset(0)
            make.left.equalTo(self).offset(ScreenWidth/7*2)
            make.width.equalTo(ScreenWidth/7)
        }
        
        let verticalView1 = UIView()
        verticalView1.backgroundColor = UIColor.grayColor()
        self.addSubview(verticalView1)
        let verticalView2 = UIView()
        verticalView2.backgroundColor = UIColor.grayColor()
        self.addSubview(verticalView2)
        
        verticalView1.snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(5)
            make.bottom.equalTo(self).offset(-5)
            make.width.equalTo(1)
            make.left.equalTo(homeButton.snp_right).offset(0)
        }
        verticalView2.snp_makeConstraints { (make) in
            
            make.top.equalTo(self).offset(5)
            make.bottom.equalTo(self).offset(-5)
            make.width.equalTo(1)
            make.left.equalTo(enshrineButton.snp_right).offset(0)
        }
        
        aloneView = UIView()
        aloneView.backgroundColor = UIColor.grayColor()
        let singleTap = UITapGestureRecognizer.init(target: self, action: #selector(GoodsDetailsBottomView.handleSingleTap(_:)))
        aloneView.addGestureRecognizer(singleTap)
        self.addSubview(aloneView)
        aloneView.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(self).offset(0)
            make.left.equalTo(self).offset(ScreenWidth/7*3)
            make.width.equalTo(ScreenWidth/7*2)
        }
        
        groupView = UIButton()
        
        let group_singleTap = UITapGestureRecognizer.init(target: self, action: #selector(GoodsDetailsBottomView.group_handleSingleTap(_:)))
        groupView.addGestureRecognizer(group_singleTap)
        
        groupView.backgroundColor = UIColor.redColor()
        self.addSubview(groupView)
        groupView.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(self).offset(0)
            make.left.equalTo(self).offset(ScreenWidth/7*5)
            make.width.equalTo(ScreenWidth/7*2)
        }
        
        alonePrice = UILabel()
        alonePrice.textColor = UIColor.whiteColor()
        alonePrice.font = UIFont.systemFontOfSize(12)
        alonePrice.text = "¥ 118.00"
        aloneView.addSubview(alonePrice)
        alonePrice.snp_makeConstraints { (make) in
            make.centerX.equalTo(aloneView.snp_centerX).offset(0)
            make.top.equalTo(aloneView.snp_top).offset(10)
        }
        
        let aloneBuy = UILabel()
        aloneBuy.textColor = UIColor.whiteColor()
        aloneBuy.font = UIFont.systemFontOfSize(12)
        aloneBuy.text = "单独购买"
        aloneView.addSubview(aloneBuy)
        aloneBuy.snp_makeConstraints { (make) in
            make.centerX.equalTo(aloneView.snp_centerX).offset(0)
            make.bottom.equalTo(aloneView.snp_bottom).offset(-5)
        }
        
        groupPrice = UILabel()
        groupPrice.textColor = UIColor.whiteColor()
        groupPrice.font = UIFont.systemFontOfSize(12)
        groupPrice.text = "¥ 1.00"
        groupView.addSubview(groupPrice)
        groupPrice.snp_makeConstraints { (make) in
            make.centerX.equalTo(groupView.snp_centerX).offset(0)
            make.top.equalTo(groupView.snp_top).offset(10)
        }
        
        numberGroup = UILabel()
        numberGroup.textColor = UIColor.whiteColor()
        numberGroup.font = UIFont.systemFontOfSize(12)
        numberGroup.text = "10人团"
        groupView.addSubview(numberGroup)
        numberGroup.snp_makeConstraints { (make) in
            make.centerX.equalTo(groupView.snp_centerX).offset(0)
            make.bottom.equalTo(groupView.snp_bottom).offset(-5)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func handleSingleTap(sender:UITapGestureRecognizer) {
        
        self.aloneClickblock!()
        
    }
    
    func group_handleSingleTap(sender:UITapGestureRecognizer) {
 
        self.clickblock!()
    }
    
    func click(sender:UIButton) {
        
        self.buttonBlock!(sender.tag)

    }
    
    
    //团购闭包变量的Seter方法
    func setclickblockClosure(tempClosure:groupViewClickBlock) {
        
        self.clickblock = tempClosure
    }
    
    //独自购买闭包变量的Seter方法
    func setaloneClickblockClosure(tempClosure:aloneViewClickBlock) {
        
        self.aloneClickblock = tempClosure
    }
    
    //button闭包变量的Seter方法
    func setbuttonBlockClosure(tempClosure:buttonClickBlock) {
        
        self.buttonBlock = tempClosure
        
    }
    
    
}

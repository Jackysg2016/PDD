//
//  PersonageModel.swift
//  PDD
//
//  Created by 周磊 on 16/3/23.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class PersonageModel: NSObject {
    
    lazy var itemNameArray:[String] = {
        var itemNameArray = ["我的团","我的抽奖","我的收藏","我的优惠劵","收货地址","我的消息","常见问题"]
        return itemNameArray
    }()
    
    lazy var itemImageArray:[String] = {
        var itemImageArray = ["wodetuan.jpg","choujiang.jpg","soucang.jpg","youhuijuan.jpg","shouhuodizhi.jpg","xiaoxi.jpg","wenti.jpg"]
        return itemImageArray
    }()
    
    lazy var segmentTitleArray:[String] = {
        var segmentTitleArray = ["待付款","待发货","待收货","待评价"]
        return segmentTitleArray
    }()
    
    lazy var segmentImageArray:[String] = {
        var segmentImageArray = ["daifukuan.jpg","daifahuo.jpg","daishouhuo.jpg","daipingjia.jpg"]
        return segmentImageArray
    }()
    
    
    
    
    
}


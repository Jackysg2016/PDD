//
//  HaiTaoDataModel.swift
//  PDD
//
//  Created by zhoulei on 16/3/20.
//  Copyright © 2016年 ZL. All rights reserved.
//  海淘的数据模型和首页的有一些相同，所以这里只创建不同的地方，相同的直接拿来用，不在重复造轮子

import UIKit

class HaiTaoDataModel: NSObject {

    var good_list = HomeModel()
    
    var home_recommend = home_recommend_subjectsModel()
    
    var mobile_app = mobile_app_groups_Model()
    
    var country_list = HomeRollModel()
    
    var promotion_list = HomeRollModel()

    var cellType = CellType.group

}


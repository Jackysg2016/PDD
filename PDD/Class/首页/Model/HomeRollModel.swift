//
//  HomeRollModel.swift
//  PDD
//
//  Created by 周磊 on 16/3/16.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class HomeRollModel: NSObject {

    var desc:String?
    var home_banner:String?
    var position:String?
    var subject:String?
    var subject_id:String?
    var type:String?
    
    func mapping(map:Dictionary<String,AnyObject>){
        desc = map["desc"] as? String
        home_banner = map["home_banner"] as? String
        position = map["position"] as? String
        subject = map["subject"] as? String
        subject_id = map["subject_id"] as? String
        type = map["type"] as? String
    }

}

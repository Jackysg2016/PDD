//
//  GoodsDetailsModel.swift
//  PDD
//
//  Created by 周磊 on 16/4/7.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit
import SwiftyJSON

class GoodsDetailsModel: NSObject {
    
    var goodsJson:JSON!
    var mallJson:JSON?
    var reviewsJson:JSON?
    var recommendationJson:JSON?

    func resolvegoodsJsonData(jsonData:JSON) {
    
        goodsJson = jsonData
        
    }
     func resolvemallJsonData(jsonData:JSON) {
        
        mallJson = jsonData
    }
     func resolvereviewsJsonData(jsonData:JSON) {
        
        reviewsJson = jsonData
    }
     func resolverecommendationJsonData(jsonData:JSON) {
        
        recommendationJson = jsonData
    }
    
    
    func jiexiData() {
        
    }
    
    
}
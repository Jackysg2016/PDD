//
//  UserEvaluationRequest.swift
//  PDD
//
//  Created by 周磊 on 16/4/14.
//  Copyright © 2016年 ZL. All rights reserved.
//  用户评价

import UIKit
import SwiftyJSON

class UserEvaluationRequest: NSObject {

    
    //http://apiv2.yangkeduo.com/reviews/14627?page=2&size=20
    
    
    func userEvaluationRequest(goodsId:String,page:Int,successBlock:(successJson:JSON)->Void,errorBlock:(error:NSError)->Void) {
        
        let url = "http://apiv2.yangkeduo.com/reviews/\(goodsId)?page=\(page)&size=20"
        
        request.defaultInstance().GetRequest(url).responseData { response in
            switch response.result {
            case .Success:
                
                guard let JsonData = response.result.value else { return }
                
                let json = JSON(data: JsonData)
                
                successBlock(successJson: json)
                
            case .Failure(let error):
                
                errorBlock(error: error)
            }
        }
    }
}

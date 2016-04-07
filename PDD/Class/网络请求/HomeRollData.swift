//
//  HomeRollData.swift
//  PDD
//
//  Created by 周磊 on 16/3/16.
//  Copyright © 2016年 ZL. All rights reserved.
//  首页滚动图片数据请求

import UIKit

class HomeRollData: NSObject {

    weak var delegate:HomeRollDataDelegate?

    func requestData(){
        
        request.defaultInstance().GetRequest(SubjectsUrl).responseJSON { response in
            
            switch response.result {
            case .Success:
                
                guard let JsonData = response.result.value else { return }
                
                let dataSouce = JsonData as? NSArray
                                
                var homeRollDataArray = [HomeRollModel]()

                for data in dataSouce! {
                    
                    let homeRoll = HomeRollModel()
                    homeRoll.mapping(data as! Dictionary<String, AnyObject>)                    
                    homeRollDataArray.append(homeRoll)
                }
                
                self.delegate?.requestResult(homeRollDataArray)
                
            case .Failure(let error):
                
                print(error)
            }
        }
    }
    
    
}

protocol HomeRollDataDelegate: NSObjectProtocol {
    
    func requestResult(homeRollDataArray:NSArray)
    
}
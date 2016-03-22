//
//  SearchRequest.swift
//  PDD
//
//  Created by 周磊 on 16/3/21.
//  Copyright © 2016年 ZL. All rights reserved.
//  搜索网络请求

import UIKit

class SearchRequest: NSObject {

    weak var delegate:searchRequestDataDelegate?
    
    func searchRequest(){
        
        request.defaultInstance().GetRequest(OperationsUrl).responseJSON { response in
            
            switch response.result {
                
            case .Success:
                
                guard let JsonData = response.result.value as? NSArray else { return }
                
                var searchArray = [SearchModel]()
                
                for searchData in JsonData {
                    let search = SearchModel()
                    search.mapping(searchData as! Dictionary<String, AnyObject>)
                    searchArray.append(search)
                }
                self.delegate?.searchRequest(searchArray)
                
            case .Failure(let error):
                
                print(error)
            }
        }
    }
    
}
protocol searchRequestDataDelegate: NSObjectProtocol {
    
    func searchRequest(searchDataArray:[SearchModel])
    
}
//
//  GoodsDetailsViewController.swift
//  PDD
//
//  Created by 周磊 on 16/4/7.
//  Copyright © 2016年 ZL. All rights reserved.
//  商品详情

import UIKit

class GoodsDetailsViewController: BaseViewController {
    
    /// 商品id
    var goodsId:String!
    /// 商家id
    var mallId:String!
    let goodsRequest = GoodsDetailsrequest()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.cyanColor()
        
        goodsRequest.goodsDetailsrequest(goodsId,mallId: mallId)

        
        
    }
   
}

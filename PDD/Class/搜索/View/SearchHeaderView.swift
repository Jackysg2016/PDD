//
//  SearchHeaderView.swift
//  PDD
//
//  Created by 周磊 on 16/3/22.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class SearchHeaderView: UIView {

    var searchView:UIView?
    var searchImageView:UIImageView?
    var searchLabel:UILabel?
    var searchIcon:UIImageView?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        searchImageView = UIImageView()
        searchImageView?.image = UIImage(named: "product_search")
        self.addSubview(searchImageView!)
        searchImageView?.snp_makeConstraints(closure: { (make) -> Void in
            make.left.top.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.bottom.equalTo(self).offset(0)
        })
        
        searchLabel = UILabel()
        searchLabel?.textAlignment = NSTextAlignment.Center
        searchLabel?.font = UIFont.systemFontOfSize(13)
        searchLabel?.textColor = UIColor.lightGrayColor()
        searchLabel?.text = "输入您想要查找的商品名称"
        self.addSubview(searchLabel!)
        searchLabel?.snp_makeConstraints(closure: { (make) -> Void in
            make.centerX.equalTo(searchImageView!.snp_centerX).offset(0)
            make.centerY.equalTo(searchImageView!.snp_centerY).offset(0)
        })
        
        searchIcon = UIImageView()
        searchIcon?.image = UIImage(named: "home_search_icon")
        self.addSubview(searchIcon!)
        searchIcon?.snp_makeConstraints(closure: { (make) -> Void in
            make.right.equalTo(searchLabel!.snp_left).offset(-10)
            make.centerY.equalTo(searchImageView!.snp_centerY).offset(0)
            make.height.width.equalTo(15)

        })
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

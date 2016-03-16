//
//  HomeFirstTableViewCell.swift
//  PDD
//
//  Created by 周磊 on 16/3/16.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class HomeFirstTableViewCell: UITableViewCell {

    var goodsImageView:UIImageView?
    var goodsName:UILabel?
    var determineButton:UIButton?
    var importField:UITextField?
    var smallIcon:UIImageView?

    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        goodsImageView = UIImageView()
        self.contentView.addSubview(goodsImageView!)
        goodsImageView?.snp_makeConstraints(closure: { (make) -> Void in
            make.left.equalTo(self).offset(10)
            make.top.equalTo(self).offset(20)
            make.bottom.equalTo(self).offset(0)
            make.width.equalTo(60)
        })
        smallIcon = UIImageView()
        self.contentView.addSubview(smallIcon!)
        smallIcon?.snp_makeConstraints(closure: { (make) -> Void in
            make.left.equalTo(goodsImageView!.snp_right).offset(10)
            make.top.equalTo(self).offset(20)
            make.width.height.equalTo(10)
        })
        
        goodsName = UILabel()
        goodsName?.textColor = UIColor.grayColor()
        goodsName?.font = UIFont.systemFontOfSize(12)
        goodsName?.numberOfLines = 1
        self.contentView.addSubview(goodsName!)
        goodsName?.snp_makeConstraints(closure: { (make) -> Void in
            make.left.equalTo(smallIcon!.snp_right).offset(5)
            make.top.equalTo(self).offset(20)
        })
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    
}

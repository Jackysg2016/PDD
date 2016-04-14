
//
//  GroupBuyingCell.swift
//  PDD
//
//  Created by 周磊 on 16/4/12.
//  Copyright © 2016年 ZL. All rights reserved.
//  参加团购

import UIKit

class GroupBuyingCell: UICollectionViewCell {
    
    var groupBuyingLabel:UILabel?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        groupBuyingLabel = UILabel()
        groupBuyingLabel?.font = UIFont.systemFontOfSize(13)
        groupBuyingLabel?.textColor = UIColor.grayColor()
        groupBuyingLabel!.text = "以下小伙伴正在发起团购，您可以直接参与"
        self.contentView.addSubview(groupBuyingLabel!)
        groupBuyingLabel?.snp_makeConstraints(closure: { (make) in
            make.centerY.equalTo(self.snp_centerY).offset(0)
            make.left.equalTo(self).offset(10)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

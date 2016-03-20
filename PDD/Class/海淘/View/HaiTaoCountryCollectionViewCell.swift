//
//  HaiTaoCountryCollectionViewCell.swift
//  PDD
//
//  Created by zhoulei on 16/3/20.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class HaiTaoCountryCollectionViewCell: UICollectionViewCell {
    
    var  goodsImageView:UIImageView?
    var  goodsName:UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        goodsImageView = UIImageView()
        self.addSubview(goodsImageView!)
        
        goodsImageView?.snp_makeConstraints(closure: { (make) -> Void in
            make.left.top.equalTo(self).offset(10)
            make.bottom.right.equalTo(self).offset(-10)

        })
        
        goodsName = UILabel()
        goodsName?.textColor = UIColor.whiteColor()
        goodsName?.font = UIFont.systemFontOfSize(13)
        goodsName?.textAlignment = NSTextAlignment.Center
        self.addSubview(goodsName!)
        
        goodsName?.snp_makeConstraints(closure: { (make) -> Void in
            make.left.equalTo(self).offset(10)
            make.right.bottom.equalTo(self).offset(-10)
            make.height.equalTo(20)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func releaseData(country:HomeRollModel) {
        
        let imageURL = NSURL(string: country.home_banner!)
        goodsImageView?.pdd_setImageWithURL(imageURL!, placeholderImage: UIImage(named:"wu.jpg")!)
        goodsName?.text = country.subject
    }

}

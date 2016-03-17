//
//  HomeAdCollectionViewCell.swift
//  PDD
//
//  Created by 周磊 on 16/3/17.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class HomeAdCollectionViewCell: UICollectionViewCell {
    
    var  goodsImageView:UIImageView?
    var  goodsName:UILabel?
    var  goosPice:UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        goodsImageView = UIImageView()
        goodsImageView?.layer.borderWidth = 1
        goodsImageView?.layer.borderColor = UIColor.grayColor().CGColor
        self.addSubview(goodsImageView!)
        
        goodsImageView?.snp_makeConstraints(closure: { (make) -> Void in
            make.top.left.right.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(-80)
        })
        
        goodsName = UILabel()
        goodsName?.textColor = UIColor.grayColor()
        goodsName?.font = UIFont.systemFontOfSize(13)
        goodsName?.numberOfLines = 0
        goodsName?.lineBreakMode = NSLineBreakMode.ByCharWrapping//保留整个字符，不显示省略号
        self.addSubview(goodsName!)
        goodsName?.snp_makeConstraints(closure: { (make) -> Void in
            make.left.right.equalTo(self).offset(0)
            make.top.equalTo(goodsImageView!.snp_bottom).offset(5)
            make.bottom.equalTo(self).offset(-40)
            
        })
        
        goosPice = UILabel()
        goosPice?.textColor = UIColor.redColor()
        goosPice?.font = UIFont.systemFontOfSize(17)
        self.addSubview(goosPice!)
        goosPice?.snp_makeConstraints(closure: { (make) -> Void in
            make.left.right.equalTo(self).offset(0)
            make.top.equalTo(goodsName!.snp_bottom).offset(5)
            make.bottom.equalTo(self).offset(-10)
            
        })
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func releaseData(homeData:home_recommend_goodlistModel){
        
        var pice :Float?
        pice = NSString(string: homeData.price!).floatValue / 100
        
        var price:String?
        price = String(format: "%.2f", pice!)
        
        
        goodsName?.text = homeData.goods_name
        goosPice?.text = "¥"  + price!
        let imageURL = NSURL(string:homeData.thumb_url!)
        
        goodsImageView?.wxn_setImageWithURL(imageURL!, placeholderImage: UIImage(named: "wu.jpg")!)
    }
    
}

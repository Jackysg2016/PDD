//
//  RecommendedGoodsCell.swift
//  PDD
//
//  Created by 周磊 on 16/4/13.
//  Copyright © 2016年 ZL. All rights reserved.
//  推荐的商品

import UIKit

class RecommendedGoodsCell: UICollectionViewCell {
    //商品图片
    var headImageView:UIImageView!
    //商品名称
    var goodsNameLabel:UILabel!
    //商品价格
    var goodsPriceLabel:UILabel!
    
    
    var recommend = recommendInformation() {
        
        didSet {
            
            let url = NSURL.init(string: recommend.thumb_url!)
            headImageView.pdd_setImageWithURL(url!, placeholderImage: UIImage(named: "wu.jpg")!)
            goodsNameLabel.text = recommend.goods_name
            let floatPrice = Float(recommend.price!)!/100
            goodsPriceLabel.text = String(format: "¥ %.2f", floatPrice)

        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        headImageView = UIImageView()
        headImageView.layer.borderColor = UIColor.grayColor().CGColor
        headImageView.layer.borderWidth = 0.5
        self.contentView.addSubview(headImageView)
        headImageView.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.top.equalTo(self).offset(0)
            make.height.equalTo(100)
        }
        
        goodsNameLabel = UILabel()
        goodsNameLabel.font = UIFont.systemFontOfSize(11)
        goodsNameLabel.textColor = UIColor.grayColor()
        goodsNameLabel.numberOfLines = 2
        goodsNameLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping//保留整个字符，不显示省略号
        goodsNameLabel.text = "【意大利进口】24.5元/两组 费列罗健达Kinder牛奶夹心巧克力T8*2装共16条 根本停不下来"
        self.contentView.addSubview(goodsNameLabel)
        goodsNameLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.top.equalTo(headImageView.snp_bottom).offset(10)
            make.right.equalTo(self).offset(-10)
        }
        
        goodsPriceLabel = UILabel()
        goodsPriceLabel.font = UIFont.systemFontOfSize(13)
        goodsPriceLabel.textColor = UIColor.redColor()
        goodsPriceLabel.text = "¥ 8.80"
        self.contentView.addSubview(goodsPriceLabel)
        goodsPriceLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.top.equalTo(headImageView.snp_bottom).offset(40)
        }
   
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

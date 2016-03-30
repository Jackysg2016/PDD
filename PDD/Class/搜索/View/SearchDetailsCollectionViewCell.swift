//
//  SearchDetailsCollectionViewCell.swift
//  PDD
//
//  Created by 周磊 on 16/3/30.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class SearchDetailsCollectionViewCell: UICollectionViewCell {
    ///商品图片
    var bgImageView:UIImageView!
    ///商品名称
    var goodsName:UILabel!
    ///收藏按钮
    var collectButton:UIButton!
    ///开团人数
    var regimentPersonLabel:UILabel!
    ///开团价
    var piceLabel:UILabel!
    
    var datsSouce:SearchDetailsGoods_listModel? {
        
        didSet {
            let imgUrl = NSURL(string: datsSouce!.thumb_url!)
            bgImageView?.pdd_setImageWithURL(imgUrl!, placeholderImage: UIImage(named: "wu.jpg")!)
            goodsName?.text = datsSouce!.goods_name
            
            if datsSouce!.customer_num != nil {
                regimentPersonLabel?.text = datsSouce!.customer_num! + "人团"
            }
            if datsSouce!.price != nil {
                var pice :Float?
                pice = NSString(string: datsSouce!.price!).floatValue / 100
                var price:String?
                price = String(format: "%.2f", pice!)
                piceLabel?.text = "¥" +  price!
            }

        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 3
        
        let bgView = UIView()
        bgView.backgroundColor = UIColor.whiteColor()
        self.contentView.addSubview(bgView)
        bgView.snp_makeConstraints { (make) in
            make.top.left.equalTo(self).offset(0)
            make.bottom.right.equalTo(self).offset(0)
        }
        
        
        bgImageView = UIImageView()
        bgView.addSubview(bgImageView)
        bgImageView.snp_makeConstraints { (make) in
            make.top.left.equalTo(bgView).offset(5)
            make.right.equalTo(bgView).offset(-5)
            make.bottom.equalTo(bgView).offset(-70)
        }
        goodsName = UILabel()
        goodsName.font = UIFont.systemFontOfSize(13)
        goodsName.textColor = UIColor.blackColor()
        goodsName.numberOfLines = 2
        goodsName?.lineBreakMode = NSLineBreakMode.ByCharWrapping//保留整个字符，不显示省略号
        bgView.addSubview(goodsName)
        goodsName.snp_makeConstraints { (make) in
            make.top.equalTo(bgImageView.snp_bottom).offset(5)
            make.left.equalTo(bgView).offset(5)
            make.right.equalTo(bgView).offset(-5)
        }
        
        regimentPersonLabel = UILabel()
        regimentPersonLabel?.font = UIFont.systemFontOfSize(10)
        regimentPersonLabel?.textColor = UIColor.grayColor()
        bgView.addSubview(regimentPersonLabel!)
        regimentPersonLabel?.snp_makeConstraints(closure: { (make) -> Void in
            make.left.equalTo(bgView).offset(5)
            make.bottom.equalTo(bgView).offset(-10)
        })
        
        piceLabel = UILabel()
        piceLabel?.font = UIFont.systemFontOfSize(15)
        piceLabel?.textColor = UIColor.redColor()
        bgView.addSubview(piceLabel!)
        piceLabel?.snp_makeConstraints(closure: { (make) -> Void in
            make.bottom.equalTo(bgView).offset(-10)
            make.left.equalTo(regimentPersonLabel!.snp_right).offset(5)
        })
        
        collectButton = UIButton(type: UIButtonType.Custom)
        collectButton?.setImage(UIImage(named: "collection_1.jpg"), forState: UIControlState.Normal)
        collectButton?.addTarget(self, action: #selector(HomeMainTableViewCell.collection), forControlEvents: UIControlEvents.TouchUpInside)
        bgView.addSubview(collectButton!)
        collectButton?.snp_makeConstraints(closure: { (make) -> Void in
            make.right.equalTo(bgView).offset(-5)
            make.width.equalTo(20)
            make.height.equalTo(18)
            make.bottom.equalTo(bgView).offset(-10)
        })
    }
    
    func collection(){
        
//        collectButton?.setImage(UIImage(named: "collection.jpg"), forState: UIControlState.Normal)
        print("收藏")
        
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

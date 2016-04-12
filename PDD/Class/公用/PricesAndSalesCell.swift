//
//  PricesAndSalesCell.swift
//  PDD
//
//  Created by 周磊 on 16/4/11.
//  Copyright © 2016年 ZL. All rights reserved.
//  价格和销量

import UIKit
import SwiftyJSON

class PricesAndSalesCell: UICollectionViewCell {
    
    var nowPrice:UILabel!
    var oldPrice:UILabel!
    var salesNumber:UILabel!
    var lotteryImageView:UIImageView!
    
    var basicDataSouce:JSON = [] {
        
        didSet {
            
            let sales = String(basicDataSouce["sales"])
            let numberSales = Float(sales)
            if numberSales > 10000 {
                salesNumber.text = "累计销售：10000+件"
            }else  {
                salesNumber.text = "累计销售：\(basicDataSouce["sales"])件"
            }
            let price = String(basicDataSouce["group"][1]["price"])
            let floatPrice = Float(price)!/100
            nowPrice.text = String(format: "¥ %.2f", floatPrice)

            let marketPrice = String(basicDataSouce["market_price"])
            let oldFloatPrice = Float(marketPrice)!/100
            let hyperLinkString = NSMutableAttributedString.init(string: String(format: "¥%.2f", oldFloatPrice))
            let selectedRange = NSRange(location: 0,length:hyperLinkString.length)
            hyperLinkString.addAttribute(NSStrikethroughStyleAttributeName, value: NSNumber.init(integer: 1), range: selectedRange)
            oldPrice.attributedText = hyperLinkString
            
            if basicDataSouce["lucky_end_time"] != nil {
                lotteryImageView.hidden = false
            }else {
                lotteryImageView.hidden = true
            }
            
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        nowPrice = UILabel()
        nowPrice.textColor = UIColor.redColor()
        nowPrice.font = UIFont.systemFontOfSize(18)
        self.contentView.addSubview(nowPrice)
        nowPrice.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.centerY.equalTo(self.snp_centerY).offset(0)
        }
    
        oldPrice = UILabel()
        oldPrice.textColor = UIColor.grayColor()
        oldPrice.font = UIFont.systemFontOfSize(13)
        self.contentView.addSubview(oldPrice)
        oldPrice.snp_makeConstraints { (make) in
            make.left.equalTo(nowPrice.snp_right).offset(10)
            make.centerY.equalTo(self.snp_centerY).offset(5)
        }
        
        salesNumber = UILabel()
        salesNumber.textColor = UIColor.grayColor()
        salesNumber.font = UIFont.systemFontOfSize(13)
        self.contentView.addSubview(salesNumber)
        salesNumber.snp_makeConstraints { (make) in
            make.right.equalTo(self).offset(-10)
            make.centerY.equalTo(self.snp_centerY).offset(5)
        }
        
        lotteryImageView = UIImageView()
        lotteryImageView.image = UIImage.init(named: "choujiangkuang.jpg")
        self.contentView.addSubview(lotteryImageView)
        lotteryImageView.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.snp_centerY).offset(0)
            make.left.equalTo(oldPrice.snp_right).offset(10)
            make.width.equalTo(30)
            make.height.equalTo(15)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

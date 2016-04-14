
//
//  ImportedGoodsCell.swift
//  PDD
//
//  Created by 周磊 on 16/4/11.
//  Copyright © 2016年 ZL. All rights reserved.
//  进口地和发货地

import UIKit
import SwiftyJSON

class ImportedGoodsCell: UICollectionViewCell {
    
    var countryLabel:UILabel!
    var countryImageView:UIImageView!

    var basicDataSouce:JSON = [] {
        
        didSet {
            countryLabel.text = "\(String(basicDataSouce["country"]))进口 \(String(basicDataSouce["warehouse"]))发货"
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        countryImageView = UIImageView()
        countryImageView.image = UIImage.init(named: "choujiangkuang.jpg")
        self.contentView.addSubview(countryImageView)
        countryImageView.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.snp_centerY).offset(0)
            make.left.equalTo(self).offset(10)
            make.width.equalTo(15)
            make.height.equalTo(10)
        }
        
        countryLabel = UILabel()
        countryLabel.textColor = UIColor.grayColor()
        countryLabel.font = UIFont.systemFontOfSize(13)
        self.contentView.addSubview(countryLabel)
        countryLabel.snp_makeConstraints { (make) in
            make.left.equalTo(countryImageView.snp_right).offset(5)
            make.centerY.equalTo(self.snp_centerY).offset(0)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

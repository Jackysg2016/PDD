//
//  AllowedRegionCell.swift
//  PDD
//
//  Created by 周磊 on 16/4/12.
//  Copyright © 2016年 ZL. All rights reserved.
//  商家许可范围

import UIKit

class AllowedRegionCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let allowedRegionArray = ["包邮","7天退货","正品保障"]

        var  rectArray = [CGFloat]()
        
        for j in 0 ..< allowedRegionArray.count {
            
            let tmpRect:CGRect = (allowedRegionArray[j] as NSString).boundingRectWithSize(CGSizeMake(100, 1000), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.systemFontOfSize(13)], context: nil)
            rectArray.append(tmpRect.width)
        }
        
        
        for i in 0 ..< allowedRegionArray.count {
            
            let pigeonImageView = UIImageView()
            pigeonImageView.image = UIImage(named: "td2_num_img-51155b64c3")
            pigeonImageView.frame = CGRectMake((CGFloat(i)*(ScreenWidth/4))+5, 7.5, 15, 15)
            self.contentView.addSubview(pigeonImageView)
            
            let allowedRegionLabel = UILabel()
            allowedRegionLabel.font = UIFont.systemFontOfSize(13)
            allowedRegionLabel.textColor = UIColor.grayColor()
            allowedRegionLabel.text = allowedRegionArray[i]
            allowedRegionLabel.frame = CGRectMake((CGFloat(i)*(ScreenWidth/4))+25, 5, ScreenWidth/4, 20)
            self.contentView.addSubview(allowedRegionLabel)
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

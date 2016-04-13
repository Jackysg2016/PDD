
//
//  ImageCell.swift
//  PDD
//
//  Created by 周磊 on 16/4/13.
//  Copyright © 2016年 ZL. All rights reserved.
//  图片

import UIKit

class ImageCell: UICollectionViewCell {
    
    var bgImageView:UIImageView!
    
    var imageDataSouce = imagesInformation() {
        
        didSet {
            
            let url = NSURL.init(string: imageDataSouce.url!)
            bgImageView.pdd_setImageWithURL(url!, placeholderImage: UIImage(named: "wu.jpg")!)
            
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        bgImageView = UIImageView()
        self.contentView.addSubview(bgImageView)
        bgImageView.snp_makeConstraints { (make) in
            make.left.right.equalTo(self).offset(0)
            make.top.bottom.equalTo(self).offset(0)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

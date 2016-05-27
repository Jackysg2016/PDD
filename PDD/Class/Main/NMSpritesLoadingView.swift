//
//  NMSpritesLoadingView.swift
//  BaiDuNuoMi
//
//  Created by 周磊 on 16/4/22.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit
import SnapKit

class NMSpritesLoadingView: UIView {

    var loadingImageView:UIImageView!
    var titleLabel:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        let bgView = UIView.init(frame: self.bounds)
        self.addSubview(bgView)

        self.backgroundColor = UIColor.clearColor()
        loadingImageView = UIImageView()
        
        let imageArray: [UIImage] = [UIImage.init(named: "icon_hud_1")!,UIImage.init(named: "icon_hud_2")!,UIImage.init(named: "icon_hud_3")!,UIImage.init(named: "icon_hud_4")!,UIImage.init(named: "icon_hud_5")!,UIImage.init(named: "icon_hud_6")!,UIImage.init(named: "icon_hud_7")!,UIImage.init(named: "icon_hud_8")!,UIImage.init(named: "icon_hud_9")!]

        loadingImageView.animationImages = imageArray
        loadingImageView.animationDuration = 0.7
        loadingImageView.startAnimating()
        bgView.addSubview(loadingImageView)
        
        loadingImageView.snp_makeConstraints { (make) in
            make.centerX.equalTo(bgView.snp_centerX).offset(0)
            make.centerY.equalTo(bgView.snp_centerY).offset(-30)
        }
        
        titleLabel = UILabel()
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.textColor = UIColor.grayColor()
        titleLabel.font = UIFont.systemFontOfSize(15)
        bgView.addSubview(titleLabel)
        titleLabel.snp_makeConstraints { (make) in
            
            make.centerX.equalTo(bgView.snp_centerX).offset(0)
            make.centerY.equalTo(bgView.snp_centerY).offset(30)
        }
        
    }
    
    deinit {
        
        loadingImageView.stopAnimating()
        loadingImageView.removeFromSuperview()
        loadingImageView = nil;
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}


//
//  HomeSubjectHeaderView.swift
//  PDD
//
//  Created by 周磊 on 16/3/29.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class HomeSubjectHeaderView: UIView {

    var bgImageView:UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = BgColor
        setBgImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBgImageView() {
        
        bgImageView = UIImageView()
        self.addSubview(bgImageView!)
        bgImageView?.snp_makeConstraints(closure: { (make) in
            make.left.top.equalTo(self).offset(10)
            make.right.bottom.equalTo(self).offset(-10)
        })
    }
    func reloadImage(urlString:String) {
        
        bgImageView!.pdd_setImageWithURL(NSURL(string: urlString)!, placeholderImage: UIImage(named: "homeWu.png")!)

    }
    
}

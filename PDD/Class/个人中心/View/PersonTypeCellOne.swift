//
//  PersonTypeCellOne.swift
//  PDD
//
//  Created by 周磊 on 16/3/24.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class PersonTypeCellOne: UICollectionViewCell {
    
    var bgImageView:UIImageView?
    var photoImageView:UIImageView?
    var nameTitle:UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        bgImageView = UIImageView()
        bgImageView?.image = UIImage(named: "bgCellOne")
        self.addSubview(bgImageView!)
        bgImageView?.snp_makeConstraints(closure: { (make) in
            make.top.left.right.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(0)
        })
        
        
        nameTitle = UILabel()
        nameTitle?.textColor = UIColor.whiteColor()
        nameTitle?.font = UIFont.systemFontOfSize(18)
        self.addSubview(nameTitle!)
        nameTitle?.snp_makeConstraints(closure: { (make) in
            make.centerX.equalTo(self.snp_centerX).offset(0)
            make.bottom.equalTo(bgImageView!.snp_bottom).offset(-5)
        })
        
        photoImageView = UIImageView()
        photoImageView!.layer.masksToBounds = true
        photoImageView!.layer.cornerRadius = 30
        photoImageView?.image = UIImage(named: "phoneImage.jpg")
        self.addSubview(photoImageView!)
        photoImageView?.snp_makeConstraints(closure: { (make) in
            make.centerX.equalTo(self.snp_centerX).offset(0)
            make.top.equalTo(self).offset(20)
            make.width.height.equalTo(60)

        })
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func reloadData (name:String) {
        
        nameTitle?.text = name
    }
    
}

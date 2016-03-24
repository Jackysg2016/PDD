//
//  PersonTypeCellThree.swift
//  PDD
//
//  Created by 周磊 on 16/3/24.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class PersonTypeCellThree: UICollectionViewCell {
    
    var bgImageView:UIImageView?
    var nameTitle:UILabel?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
            bgImageView = UIImageView()
            self.addSubview(bgImageView!)
            bgImageView?.snp_makeConstraints(closure: { (make) in
                make.centerX.equalTo(self.snp_centerX).offset(0)
                make.top.equalTo(self).offset(10)
                make.width.height.equalTo(30)
            })
            
            nameTitle = UILabel()
            nameTitle?.textColor = UIColor.blackColor()
            nameTitle?.font = UIFont.systemFontOfSize(15)
            self.addSubview(nameTitle!)
            nameTitle?.snp_makeConstraints(closure: { (make) in
                make.centerX.equalTo(self.snp_centerX).offset(0)
                make.bottom.equalTo(self).offset(-5)
            })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func typeCellThreeReloadData (title:String,imageName:String) {
        
        bgImageView?.image = UIImage(named: imageName)
        nameTitle?.text = title
    }

}

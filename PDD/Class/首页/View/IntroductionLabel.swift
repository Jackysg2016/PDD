

//
//  IntroductionLabel.swift
//  PDD
//
//  Created by 周磊 on 16/3/25.
//  Copyright © 2016年 ZL. All rights reserved.
//  单纯的为了解决MainTableViewCell重用的问题

import UIKit

class IntroductionLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

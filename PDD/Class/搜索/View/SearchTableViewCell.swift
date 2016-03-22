//
//  SearchTableViewCell.swift
//  PDD
//
//  Created by 周磊 on 16/3/21.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    var bgImageView:UIImageView?
    var titleName:UILabel?
    var bgView:UIView?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        bgView = UIView()
        bgView?.backgroundColor = UIColor.whiteColor()
        bgView!.layer.masksToBounds = true
        bgView!.layer.cornerRadius = 5.0
        self.contentView.addSubview(bgView!)
        
        bgView?.snp_makeConstraints(closure: { (make) -> Void in
            make.left.equalTo(self).offset(2.5)
            make.right.equalTo(self).offset(-2.5)
            make.top.equalTo(self).offset(10)
            make.bottom.equalTo(self).offset(0)

        })
        
        bgImageView = UIImageView()
        bgView?.addSubview(bgImageView!)
        bgImageView?.snp_makeConstraints(closure: { (make) -> Void in
            make.left.right.top.equalTo(bgView!).offset(0)
            make.height.equalTo(50)
        })
        
        titleName = UILabel()
        titleName?.textColor = UIColor.whiteColor()
        titleName?.font = UIFont.systemFontOfSize(20)
        titleName?.textAlignment = NSTextAlignment.Center
        bgView?.addSubview(titleName!)
        titleName?.snp_makeConstraints(closure: { (make) -> Void in
            make.centerX.equalTo(bgView!.snp_centerX).offset(0)
            make.centerY.equalTo(bgImageView!.snp_centerY).offset(0)
        })
        
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloaddata(datsSouce:SearchModel,childrendatasouce:NSArray) {
        
        let imgUrl = NSURL(string: datsSouce.image_url!)
        bgImageView?.pdd_setImageWithURL(imgUrl!, placeholderImage: UIImage(named: "wu.jpg")!)
        titleName?.text = datsSouce.opt_name
        
        for var i = 0;i<childrendatasouce.count;i++ {
            
            var childrenEntity = childrenModel()
            childrenEntity.mapping(childrendatasouce[i] as! Dictionary<String, AnyObject>)
            
            let nameLabel_W = (ScreenWidth - 5)/4
            let line = 4 //列数
            
            let  nameLabel = UILabel()
            nameLabel.text = childrenEntity.opt_name
            nameLabel.textAlignment = NSTextAlignment.Center
            nameLabel.tag = i+1
            nameLabel.font = UIFont.systemFontOfSize(15)
            nameLabel.backgroundColor = UIColor.whiteColor()
            nameLabel.userInteractionEnabled = true
            let labelTapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("labelTouchUpInside:"))
            nameLabel.addGestureRecognizer(labelTapGestureRecognizer)
            
            let nameLabel_H = 30
            let nameLabel_X = CGFloat((i%line)) * nameLabel_W
            let nameLabel_Y = ((i/line) * nameLabel_H) + 50
            
            nameLabel.frame = CGRectMake(nameLabel_X, CGFloat(nameLabel_Y), nameLabel_W, CGFloat(nameLabel_H))
            
            bgView?.addSubview(nameLabel)
            
        }
        
    }
    
    func labelTouchUpInside(recognizer:UITapGestureRecognizer){
        
        let label:UILabel = recognizer.view as! UILabel
        
        print("\(label.tag)")
    }
    
}

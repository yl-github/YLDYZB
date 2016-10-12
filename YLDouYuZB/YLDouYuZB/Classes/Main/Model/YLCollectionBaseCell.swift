//
//  YLCollectionBaseCell.swift
//  YLDouYuZB
//
//  Created by yl on 2016/10/12.
//  Copyright © 2016年 yl. All rights reserved.
//

import UIKit

class YLCollectionBaseCell: UICollectionViewCell {
    //MARK:- 定义控件属性
    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var anchorNameLabel: UILabel!
    @IBOutlet weak var onlineNum: UIButton!
    
    var anchor : YLAnchorModel?{
        didSet{
            // 这里使用可选链不合适，所以直接校验一下anchor是否有值
            guard let anchor = anchor else { return }
            
            // 1.设置房间封面图片 （这里使用到了一个加载网络图片的第三方Kingfirs）
            guard let iconUrl = NSURL(string: anchor.vertical_src) else { return };
            iconImg.kf_setImageWithURL(iconUrl);
            
            // 2.设置主播昵称
            anchorNameLabel.text = anchor.nickname;
            
            // 3.设置在线人数
            var onlineStr : String = "";
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线";
            }else {
                onlineStr = "\(anchor.online)在线";
            }
            onlineNum.setTitle(onlineStr, forState: .Normal);
        }
    }
}

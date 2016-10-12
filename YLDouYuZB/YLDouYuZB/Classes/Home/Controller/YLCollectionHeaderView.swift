//
//  YLCollectionHeaderView.swift
//  YLDouYuZB
//
//  Created by yl on 16/10/9.
//  Copyright © 2016年 yl. All rights reserved.
//

import UIKit
import Kingfisher
class YLCollectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var headerImgView: UIImageView!

    //MARK:- 定义模型属性
    var group : YLAnchorGroupModel? {
        didSet {
            headerTitleLabel.text = group?.tag_name;
            // 这里用到可选链，可选链这里需要传一个确定的值，??双问号表示，如果没有值就使用后面的
            if group?.icon_url.characters.count == 84 {
                group?.icon_url = "home_header_normal";
            }
            headerImgView.image = UIImage(named: group?.icon_url ?? "home_header_normal");
        }
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}

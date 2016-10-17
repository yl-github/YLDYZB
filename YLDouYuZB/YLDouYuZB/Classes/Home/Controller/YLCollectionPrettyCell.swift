//
//  YLCollectionPrettyCell.swift
//  YLDouYuZB
//
//  Created by yl on 16/10/9.
//  Copyright © 2016年 yl. All rights reserved.
//

import UIKit
import Kingfisher

class YLCollectionPrettyCell: YLCollectionBaseCell {
    //MARK:- 定义控件属性
    @IBOutlet weak var anchorCity: UIButton!
    
    //MARK:- 定义一个模型属性，来接受从controller中传过来的数据模型
    override var anchor : YLAnchorModel? {
        //当需要监听属性的变化的时候，用didSet，属性发生改变是触发这个方法
        didSet{
            // 1.将模型传递给父类
            super.anchor = anchor;
            // 3.设置主播所在城市
            anchorCity.setTitle(anchor?.anchor_city, for: UIControlState());
        }
    }
}

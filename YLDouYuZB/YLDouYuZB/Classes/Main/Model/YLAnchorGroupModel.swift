//
//  YLAnchorGroupModel.swift
//  YLDouYuZB
//
//  Created by yl on 16/10/10.
//  Copyright © 2016年 yl. All rights reserved.
//

import UIKit

class YLAnchorGroupModel: YLBaseGameModel {
    /** 该组中对应的房间信息（数组）*/
    var room_list : [[String : NSObject]]? {
        
        // didSet属性监听器(监听属性的改变)，一旦监听到属性有改变就执行
        didSet{
            guard let room_list = room_list else{ return }
            for anchorDict in room_list {
                anchorsArr.append(YLAnchorModel(dict: anchorDict));
            }
        }
    }
    
    /** 该组显示的图标 */
    var icon_name : String = "home_header_normal"
    
    /** 定义主播的对象模型数组 */
    lazy var anchorsArr : [YLAnchorModel] = [YLAnchorModel]();
    
}

//
//  YLCycleModel.swift
//  YLDouYuZB
//
//  Created by yl on 2016/10/13.
//  Copyright © 2016年 yl. All rights reserved.
//

import UIKit

class YLCycleModel: NSObject {
    /** 轮播图上的标题 */
    var title : String = ""
    /** 轮播图图片地址 */
    var pic_url : String = "";
    
    /** 主播信息对应的字典 (这个字典用起来不方便所以将其转换成AnchorModel模型)*/
    var room : [String : NSObject]? {
        didSet {   // 当发现属性发生改变的时候，直接走着个didSet方法
            guard let room = room else { return }
            anchor = YLAnchorModel(dict: room);
        }
    }
    /** 主播信息对应的模型对象*/
    var anchor : YLAnchorModel?
    
    //MARK:- 自定义构造函数
    init(dict : [String :NSObject]) {
        super.init();
        
        setValuesForKeys(dict);
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}

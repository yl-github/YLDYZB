//
//  YLAnchorModel.swift
//  YLDouYuZB
//
//  Created by yl on 16/10/10.
//  Copyright © 2016年 yl. All rights reserved.
//

import UIKit

class YLAnchorModel: NSObject {
    /** 房间号 */
    var room_id : Int = 0
    
    /** 房间图片对应的URLString */
    var vertical_src : String = ""
    
    /** isVertical判断是手机直播还是电脑直播 0代表是电脑直播，1代表是手机直播*/
    var isVertical : Int = 0
    
    /** room_name 房间名称 */
    var room_name : String = ""
    
    /** nickname 主播昵称 */
    var nickname : String = ""
    
    /** online 观看人数 */
    var online : Int = 0
    
    /** 主播所在城市 */
    var anchor_city : String = "";
    
    
    // 构造函数
    init(dict : [String : NSObject]) {
        super.init();
        
        setValuesForKeys(dict);
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}

//
//  YLAmuseViewModel.swift
//  YLDouYuZB
//
//  Created by yl on 2016/10/18.
//  Copyright © 2016年 yl. All rights reserved.
//

import UIKit

class YLAmuseViewModel : YLBaseViewModel{
    
}

//MARK: -数据请求
extension YLAmuseViewModel {
    // 发送请求
    func requestAmuseData(finisedCallback : @escaping () -> ()){
        requestBaseAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finisedCallback: finisedCallback);
    }
}

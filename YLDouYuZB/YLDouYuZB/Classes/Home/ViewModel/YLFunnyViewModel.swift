//
//  YLFunnyViewModel.swift
//  YLDouYuZB
//
//  Created by yl on 2016/10/19.
//  Copyright © 2016年 yl. All rights reserved.
//

import UIKit

class YLFunnyViewModel: YLBaseViewModel {

}

extension YLFunnyViewModel {
    func loadFunnyData(finishedCallback : @escaping()->()){
        requestBaseAnchorData(isGroupData: false, URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters: ["limit" : "30", "offset" : "0"], finisedCallback:finishedCallback);
    }
}

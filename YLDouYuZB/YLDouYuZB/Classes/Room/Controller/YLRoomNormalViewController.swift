//
//  YLRoomNormalViewController.swift
//  YLDouYuZB
//
//  Created by yl on 2016/10/19.
//  Copyright © 2016年 yl. All rights reserved.
//

import UIKit

class YLRoomNormalViewController: UIViewController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.purple
    }
    override func viewWillAppear(_ animated: Bool) {
        // 先调用父类的
        super.viewWillAppear(animated);
        // 隐藏navbar
        navigationController?.setNavigationBarHidden(true, animated: true);
        
        // 依旧保持左侧滑返回手势 （我们添加过全屏pop手势之后，这里就不需要添加了）
        // 遵守这个代理
//        navigationController?.interactivePopGestureRecognizer?.delegate = self;
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = true;
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        navigationController?.setNavigationBarHidden(false, animated: true);
    }
}

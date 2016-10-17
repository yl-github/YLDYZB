//
//  YLMainViewController.swift
//  YLDouYuZB
//
//  Created by pj-Macmini on 16/9/20.
//  Copyright © 2016年 yl. All rights reserved.
//

import UIKit

class YLMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVC("Home");
        addChildVC("Live");
        addChildVC("Follow");
        addChildVC("Proflie");
    }
    
    fileprivate func addChildVC(_ storyboardName : String){
        
        // 1. 通过storyboard获取控制器
        let childVC = UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController()!;
        
        // 2. 将childVC作为自控制器
        addChildViewController(childVC);
    }

}

//
//  YLAmuseViewController.swift
//  YLDouYuZB
//
//  Created by yl on 2016/10/18.
//  Copyright © 2016年 yl. All rights reserved.
//

import UIKit
private let kAmuseViewH : CGFloat = 200

class YLAmuseViewController: YLBaseAnchorViewController {
    
    //MARK:- 懒加载添加控件
    fileprivate lazy var amuseViewModel : YLAmuseViewModel = YLAmuseViewModel();
    fileprivate lazy var amuseView : YLAmuseMenuView = {
        let amuseView = YLAmuseMenuView.amuseMenuView();
        amuseView.frame = CGRect(x: 0, y: -kAmuseViewH, width: kScreenW, height: kAmuseViewH);
        return amuseView;
    }()

}

//MARK:- 设置UI界面
extension YLAmuseViewController {
    
    // 重写父类的方法
    override func setupUI() {
        super.setupUI();
        
        self.recommendCollectionView.addSubview(amuseView);
        self.recommendCollectionView.contentInset = UIEdgeInsets(top: kAmuseViewH, left: 0, bottom: 0, right: 0);
    }
}

//MARK: - 请求数据
extension YLAmuseViewController {
    override func loadData() {
        // 1.将model传递给父类的model
        self.baseViewModel = self.amuseViewModel;
        
        // 2. 请求数据
        amuseViewModel.requestAmuseData {
            self.recommendCollectionView.reloadData();
            
            var tempArr = self.amuseViewModel.anchorGroupArr;
            tempArr.removeFirst();
            self.amuseView.anchorGroupsMArr = tempArr;
        }
    }
}



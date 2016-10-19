//
//  YLFunnyViewController.swift
//  YLDouYuZB
//
//  Created by yl on 2016/10/19.
//  Copyright © 2016年 yl. All rights reserved.
//

import UIKit

private let kTopMargin : CGFloat = 8

class YLFunnyViewController: YLBaseAnchorViewController {
    //MARK:- 定义属性
    var funnyViewModel : YLFunnyViewModel = YLFunnyViewModel();
}

extension YLFunnyViewController {
    override func setupUI() {
        super.setupUI();
        
        let layout = recommendCollectionView.collectionViewLayout as! UICollectionViewFlowLayout;
        layout.headerReferenceSize = CGSize.zero;
        
        recommendCollectionView.contentInset = UIEdgeInsets(top: kTopMargin, left: 0, bottom: 0, right: 0);
    }
}

extension YLFunnyViewController {
    override func loadData() {
        // 将viewmodel传递给父类
        self.baseViewModel = self.funnyViewModel;
        
        funnyViewModel.loadFunnyData { 
            self.recommendCollectionView.reloadData();
        }
    }
}

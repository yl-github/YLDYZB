//
//  YLPageContentView.swift
//  YLDouYuZB
//
//  Created by yl on 16/9/26.
//  Copyright © 2016年 yl. All rights reserved.
//

import UIKit
private let cellID = "cellID";

class YLPageContentView: UIView {
    
    // MARK:- 定义属性,来保存传进来的内容
    private var childVcs: [UIViewController];
    private var parentViewControlle: UIViewController
    
    // MARK:- 懒加载属性
    private lazy var collectionView: UICollectionView = {
        // 1.创建layout
        let layout = UICollectionViewFlowLayout();
        layout.itemSize = self.bounds.size;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = .Horizontal;
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout);
        collectionView.showsHorizontalScrollIndicator = false;
        collectionView.pagingEnabled = true;
        collectionView.bounces = false;
        collectionView.dataSource = self;
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID);
        
        return collectionView;
    }();
    
    // MARK:- 自定义构造函数
    init(frame: CGRect,childVcs: [UIViewController],parentViewControlle: UIViewController) {
        
        self.childVcs = childVcs;
        self.parentViewControlle = parentViewControlle;
        
        super.init(frame: frame);
        
        // 设置UI界面
        setupUI();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK:- 设置UI界面
extension YLPageContentView {
    private func setupUI(){
        // 1.将所欲的子控制器添加到父控制器当中
        for childVc in childVcs{
            parentViewControlle.addChildViewController(childVc);
        }
        
        // 2.添加UICollectionView，用于在cell中存放控制器的View
        addSubview(collectionView);
        collectionView.frame = bounds;
    }
    
}

// MARK:- 遵守UICollectionView的datasource协议
extension YLPageContentView:UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count;
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // 1.创建cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath);
        
        // 2.给cell设置内容
        let childVC = childVcs[indexPath.item];
        childVC.view.frame = self.bounds;
        cell.contentView.addSubview(childVC.view);
        
        return cell;
    }
}

















//
//  YLRecommendationViewController.swift
//  YLDouYuZB
//
//  Created by yl on 16/9/30.
//  Copyright © 2016年 yl. All rights reserved.
//

import UIKit
private let kMargin : CGFloat = 10;
private let kItemW : CGFloat = (kScreenW - 3 * kMargin) / 2
private let kNormalItemH : CGFloat = kItemW * 3 / 4
private let kPrettyItemH : CGFloat = kItemW * 4 / 3

private let kHeaderViewH : CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kPrettyCellID = "kPrettyCellID"
private let kHeaderViewID = "kHeaderViewID"

class YLRecommendationViewController: UIViewController {

    //MARK:- 懒加载添加控件
    private lazy var recommendCollectionView : UICollectionView = {[unowned self] in
        // 1.创建layout
        let layout = UICollectionViewFlowLayout();
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = kMargin;
        // 设置分区的内边距
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10);
        
        // 1.1 设置区头
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH);
    
        // 2.创建collectionView
        let recommendCollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout);
        
        recommendCollectionView.backgroundColor = UIColor.whiteColor();
        recommendCollectionView.dataSource = self;
        recommendCollectionView.delegate = self;
        
        // 希望子控件的宽高随着父控件的款高的改变而改变 （或者可以给collectionview做约束）
        recommendCollectionView.autoresizingMask = [.FlexibleHeight,.FlexibleWidth];
        
        // 注册cell
//        // 代码注册
//        recommendCollectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID);
        // XIB注册
        recommendCollectionView.registerNib(
            UINib(nibName: "YLCollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID);
        recommendCollectionView.registerNib(
            UINib(nibName: "YLCollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID);
        
        // 注册区头
//        // 使用最普通的注册UICollectionReusableView
//        recommendCollectionView.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID);
        // 使用XIB自定义创建区头
        recommendCollectionView.registerNib(
            UINib(nibName: "YLCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID);
        
        return recommendCollectionView;
    }();
    
    //MARK:- 系统的回调方法
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1.设置UI界面
        setupUI();
    }
    
}

extension YLRecommendationViewController {
    private func setupUI(){
        self.view.addSubview(recommendCollectionView);
    }
}

extension YLRecommendationViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 12;
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8;
        }
        return 4;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // 1.定义cell
        var cell : UICollectionViewCell!;
        
        // 2.根据分区的不同选择不同的cell
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCellWithReuseIdentifier(kPrettyCellID, forIndexPath: indexPath);
        }else {
            cell = collectionView.dequeueReusableCellWithReuseIdentifier(kNormalCellID, forIndexPath: indexPath);
        }
        
        return cell;
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        // 1.取出scetion的headerView
        let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: kHeaderViewID, forIndexPath: indexPath);
        
        return headerView;
    }
    
    // 这个方法是返回collectionItem的一个大小
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH);
        }
        return CGSize(width: kItemW, height: kNormalItemH);
    }

}













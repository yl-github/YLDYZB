//
//  YLRecommendationViewController.swift
//  YLDouYuZB
//
//  Created by yl on 16/9/30.
//  Copyright © 2016年 yl. All rights reserved.
//

import UIKit
private let kMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 3 * kMargin) / 2
private let kNormalItemH : CGFloat = kItemW * 3 / 4
private let kPrettyItemH : CGFloat = kItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50
private let kCycleViewH : CGFloat = kScreenW * 3 / 8

private let kNormalCellID = "kNormalCellID"
private let kPrettyCellID = "kPrettyCellID"
private let kHeaderViewID = "kHeaderViewID"

class YLRecommendationViewController: UIViewController {

    //MARK:- 懒加载YLRecommendViewModel属性
    private lazy var recommendViewModel : YLRecommendViewModel = YLRecommendViewModel();
    
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
        // 使用XIB自定义创建区头
        recommendCollectionView.registerNib(
            UINib(nibName: "YLCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID);
        
        // 注册区头
//        // 使用最普通的注册UICollectionReusableView
//        recommendCollectionView.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID);
        
        return recommendCollectionView;
    }();
    
    //MARK:- 懒加载创建cycleView
    private lazy var cycleView : YLRecommendCycleView = {
        let cycleView = YLRecommendCycleView.recommendCycleView();
        cycleView.frame = CGRect(x: 0, y: -kCycleViewH, width: kScreenW, height: kCycleViewH);
        return cycleView;
    }();
    
    //MARK:- 系统的回调方法
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.设置UI界面
        setupUI();
        
        // 2.发送网络请求
        loadNetWorkData();
    }
    
}
// MARK:- 设置UI界面
extension YLRecommendationViewController {
    private func setupUI(){
        // 1.将recommendCollectionView添加到View上
        view.addSubview(recommendCollectionView);
        
        // 2.将cycle添加到collectionView上
        recommendCollectionView.addSubview(cycleView);
        
        // 3.设置collectionView的内边距，以显示在上面的轮播图cycleView
        recommendCollectionView.contentInset = UIEdgeInsets(top: kCycleViewH, left: 0, bottom: 0, right: 0);
    }
}

// MARK:- 发送网络请求-请求数据
extension YLRecommendationViewController {
    // 发送请求
    private func loadNetWorkData(){
        // 1.请求推荐数据
        recommendViewModel.requestData {
            self.recommendCollectionView.reloadData();
        }
        
        // 2.请求轮播数据
        recommendViewModel.requestCycleViewData { 
            self.cycleView.cycleModelArr = self.recommendViewModel.cycleArr
        }
    }
}

extension YLRecommendationViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return recommendViewModel.anchorGroupArr.count;
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendViewModel.anchorGroupArr[section];
        return group.anchorsArr.count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // 0.取出对象模型
        let groupModel = recommendViewModel.anchorGroupArr[indexPath.section];
        let anchor = groupModel.anchorsArr[indexPath.item];
        
        // 1.定义cell
        var cell : YLCollectionBaseCell;
        
        // 2.根据分区的不同选择不同的cell
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCellWithReuseIdentifier(kPrettyCellID, forIndexPath: indexPath) as! YLCollectionPrettyCell;
        }else {
            cell = collectionView.dequeueReusableCellWithReuseIdentifier(kNormalCellID, forIndexPath: indexPath) as! YLCollectionNormalCell;
        }
        // 3.传递模型数据
        cell.anchor = anchor;
        return cell;
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        // 1.取出scetion的headerView
        let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: kHeaderViewID, forIndexPath: indexPath) as! YLCollectionHeaderView;
        
        // 2.给headerView上的控件赋值 (取出模型)
        headerView.group = recommendViewModel.anchorGroupArr[indexPath.section];
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













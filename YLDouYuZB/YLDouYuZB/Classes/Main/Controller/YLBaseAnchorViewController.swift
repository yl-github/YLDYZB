//
//  YLBaseAnchorViewController.swift
//  YLDouYuZB
//
//  Created by yl on 2016/10/18.
//  Copyright © 2016年 yl. All rights reserved.
//

import UIKit

private let kMargin : CGFloat = 10
private let kHeaderViewH : CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"

let kPrettyCellID = "kPrettyCellID"
let kNormalItemW : CGFloat = (kScreenW - 3 * kMargin) / 2
let kPrettyItemH = kNormalItemW * 4 / 3
let kNormalItemH = kNormalItemW * 3 / 4

class YLBaseAnchorViewController: YLBaseViewController {
    
    //MARK:- 定义属性
    var baseViewModel : YLBaseViewModel = YLBaseViewModel();
    
    //MARK:- 懒加载添加控件
    lazy var recommendCollectionView : UICollectionView = {[unowned self] in
        // 1.创建layout
        let layout = UICollectionViewFlowLayout();
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = kMargin;
        // 设置分区的内边距
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10);
        
        // 1.1 设置区头
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH);
        
        // 2.创建collectionView
        let recommendCollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout);
        
        recommendCollectionView.backgroundColor = UIColor.white;
        recommendCollectionView.dataSource = self;
        recommendCollectionView.delegate = self;
        
        // 希望子控件的宽高随着父控件的款高的改变而改变 （或者可以给collectionview做约束）
        recommendCollectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth];
        
        // XIB注册
        recommendCollectionView.register(
            UINib(nibName: "YLCollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID);
        recommendCollectionView.register(
            UINib(nibName: "YLCollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID);
        // 使用XIB自定义创建区头
        recommendCollectionView.register(
            UINib(nibName: "YLCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID);
        
        return recommendCollectionView;
        }();

    //MARK: -系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI();
        loadData();
    }
}

//MARK: -设置UI界面
extension YLBaseAnchorViewController {
    override func setupUI(){
        // 将collectionview在调用父类的setupUI之前传给父类中的contentView，来隐藏他
        contentView = recommendCollectionView;
        
        super.setupUI();
        self.view.addSubview(recommendCollectionView);
    }
}

//MARK: - 请求数据
extension YLBaseAnchorViewController {
    func loadData() {
        
    }
}

//MARK: -遵守uicollectionbview的datasource
extension YLBaseAnchorViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if baseViewModel.anchorGroupArr.count == 0 {
            return 1;
        }
        return baseViewModel.anchorGroupArr.count;
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if baseViewModel.anchorGroupArr.count == 0 {
            return 30;
        }
        return baseViewModel.anchorGroupArr[section].anchorsArr.count;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! YLCollectionNormalCell;
        
        if baseViewModel.anchorGroupArr.count == 0 {
            return cell;
        }
        // 2.设置数据
        cell.anchor = baseViewModel.anchorGroupArr[indexPath.section].anchorsArr[indexPath.item];
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 取出headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! YLCollectionHeaderView;
        
        if baseViewModel.anchorGroupArr.count == 0 {
            return headerView;
        }
        headerView.group = baseViewModel.anchorGroupArr[indexPath.section];
        return headerView;
    }
}

//MARK:- collectionview的delegate代理协议
extension YLBaseAnchorViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let anchorModel = baseViewModel.anchorGroupArr[indexPath.section].anchorsArr[indexPath.item];
        anchorModel.isVertical == 0 ? pushRoomNormalVc() : presentRoomShowVc();
        
    }
    
    // 普通的房间控制器  ，电脑直播的
    private func pushRoomNormalVc(){
        let roomNormalVc = YLRoomNormalViewController();
        self.navigationController?.pushViewController(roomNormalVc, animated: true) ;
    }
    
    // 秀场房间控制器
    private func presentRoomShowVc(){
        let roomShowVc = YLRoomShowViewController();
        present(roomShowVc, animated: true, completion: nil);
    }
}


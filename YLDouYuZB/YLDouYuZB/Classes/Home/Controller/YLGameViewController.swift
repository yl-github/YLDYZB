//
//  YLGameViewController.swift
//  YLDouYuZB
//
//  Created by yl on 2016/10/17.
//  Copyright © 2016年 yl. All rights reserved.
//

import UIKit
private let kEdgeMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 2 * kEdgeMargin) / 3
private let kItemH : CGFloat = kItemW * 6 / 5
private let kHeaderViewH : CGFloat = 50
private let kGameViewH : CGFloat = 90

private let kGameCellID = "kGameCellID"
private let kHeaderViewID = "kHeaderViewID"
class YLGameViewController: YLBaseViewController {
    
    //MARK:- 懒加载创建属性
    lazy var gameViewModel : YLGameViewModel = YLGameViewModel();
    
    //MARK:- 懒加载创建topHeaderView
    fileprivate lazy var topHeaderView : YLCollectionHeaderView = {
        let topHeaderView = YLCollectionHeaderView.collectionHeaderView();
        topHeaderView.frame = CGRect(x: 0, y: -(kHeaderViewH + kGameViewH), width: kScreenW, height: kHeaderViewH);
        topHeaderView.headerTitleLabel.text = "常见"
        topHeaderView.headerImgView.image = UIImage(named: "Img_orange");
        topHeaderView.moreBtn.isHidden = true;
        return topHeaderView;
    }()
    //MARK:- 懒加载创建YLRecommendGameView
    fileprivate lazy var gameView : YLRecommendGameView = {
        let gameView = YLRecommendGameView.recommendGameView();
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH);
        return gameView;
    }()
    
    //MARK:- 懒加载创建collectionview
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        
        // 1.创建layout
        let layout = UICollectionViewFlowLayout();
        layout.itemSize = CGSize(width: kItemW, height: kItemH);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin);
        
        // 设置headerView
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH);
        
        // 2.创建collectionview
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout);
        // 随父控件的拉伸而拉伸
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth];
        collectionView.backgroundColor = UIColor.white;
        collectionView.dataSource = self;
        
        // 设置collectionview的内边距，以来显示顶部的view
        collectionView.contentInset = UIEdgeInsets(top: kHeaderViewH + kGameViewH, left: 0, bottom: 0, right: 0);
    
        // 3.注册cell
        collectionView.register(UINib(nibName: "YLCollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID);
        collectionView.register(UINib(nibName: "YLCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        return collectionView;
    }()
    
    //MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置UI界面
        setupUI();
        // 数据请求
        loadAllGameData();
    }
    
}

//MARK:- 设置UI界面
extension YLGameViewController {
    override func setupUI(){
        // 1.将collectionview在调用父类的setupUI之前传给父类中的contentView，来隐藏他
        contentView = collectionView;
        // 2.调用父类的setupUI来显示父类的东西
        super.setupUI();
        
        // 3.将collectionview添加到View上
        self.view.addSubview(collectionView);
        // 4.添加topheaderView
        collectionView.addSubview(topHeaderView);
        // 5.添加gameview
        collectionView.addSubview(gameView);
    }
}

//MARK:- 请求数据刷新界面
extension YLGameViewController {
    func loadAllGameData(){
        
        gameViewModel.loadAllGameData {
            self.collectionView.reloadData();
            
            /*
            var gameDataArr = [YLBaseGameModel]();
            for i in 0 ..< 10 {
                gameDataArr.append(self.gameViewModel.gameDataArr[i]);
            }
            self.gameView.anchorGroupMArr = gameDataArr;
            */
            let temp = self.gameViewModel.gameDataArr[0..<10]; // 这里是数组的一个区间
            self.gameView.anchorGroupMArr = Array(temp);
            
            // 请求完成，停止加载图片的动画
            self.loadDataFinished();
        }
    }
}

//MARK:- 遵守collectionview的datasource协议
extension YLGameViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameViewModel.gameDataArr.count;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! YLCollectionGameCell;
        
        cell.gameGroupM = gameViewModel.gameDataArr[indexPath.item];
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1.取出headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! YLCollectionHeaderView;
        
        headerView.headerTitleLabel.text = "全部"
        headerView.headerImgView.image = UIImage(named: "Img_orange");
        headerView.moreBtn.isHidden = true;
        return headerView;
    }
}

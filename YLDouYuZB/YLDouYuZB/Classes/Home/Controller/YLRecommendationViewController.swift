//
//  YLRecommendationViewController.swift
//  YLDouYuZB
//
//  Created by yl on 16/9/30.
//  Copyright © 2016年 yl. All rights reserved.
//

import UIKit

private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH :CGFloat = 90


class YLRecommendationViewController: YLBaseAnchorViewController {

    //MARK:- 懒加载YLRecommendViewModel属性
    fileprivate lazy var recommendViewModel : YLRecommendViewModel = YLRecommendViewModel();
    
    //MARK:- 懒加载创建cycleView
    fileprivate lazy var cycleView : YLRecommendCycleView = {
        let cycleView = YLRecommendCycleView.recommendCycleView();
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH);
        return cycleView;
    }();
    
    //MARK:- 懒加载创建cycleView
    fileprivate lazy var gameView : YLRecommendGameView = {
        let gameView = YLRecommendGameView.recommendGameView();
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH);
        return gameView;
    }();
    
    
}
// MARK:- 设置UI界面
extension YLRecommendationViewController {
     override func setupUI(){
        // 1.调用父类的添加collectionview
        super.setupUI();
        
        // 2.将cycle添加到collectionView上
        recommendCollectionView.addSubview(cycleView);
        
        // 3.将gameView添加到collectionView上
        recommendCollectionView.addSubview(gameView);
        
        // 3.设置collectionView的内边距，以显示在上面的轮播图cycleView
        recommendCollectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0);
    }
}

// MARK:- 发送网络请求-请求数据
extension YLRecommendationViewController {
    // 重写父类方法
    override func loadData() {
       
        // 请求推荐数据
        recommendViewModel.requestData {
            // 0.传递模型
            self.baseViewModel = self.recommendViewModel;
            
            // 1.刷新界面
            self.recommendCollectionView.reloadData();
            
            var anchorGroupMArr = self.recommendViewModel.anchorGroupArr;
            // 1.1删除组中的前两个数据 （热门和颜值）
            anchorGroupMArr.removeFirst();
            anchorGroupMArr.removeFirst();
            
            // 1.2添加更多组
            let moreGroup = YLAnchorGroupModel();
            moreGroup.tag_name = "更多";
            anchorGroupMArr.append(moreGroup);
            
            // 2.将数据传递给gamecell
            self.gameView.anchorGroupMArr = anchorGroupMArr;
            
            // 3.请求完成，停止加载图片的动画
            self.loadDataFinished();
        }
        
        // 2.请求轮播数据
        recommendViewModel.requestCycleViewData { 
            self.cycleView.cycleModelArr = self.recommendViewModel.cycleArr
        }
    }
}

//MARK:- 重新遵守协议
extension YLRecommendationViewController : UICollectionViewDelegateFlowLayout {
   //MARK:- 重写父类的方法
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 1 {
            // 1.获取cell
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! YLCollectionPrettyCell;
            // 2.传递数据
            prettyCell.anchor = recommendViewModel.anchorGroupArr[indexPath.section].anchorsArr[indexPath.item];
            return prettyCell;
        }else {
            return super.collectionView(collectionView, cellForItemAt: indexPath);
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kPrettyItemH);
        }
        return CGSize(width: kNormalItemW, height: kNormalItemH);
    }
}












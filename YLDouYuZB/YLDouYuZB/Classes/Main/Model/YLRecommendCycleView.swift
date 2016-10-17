//
//  YLRecommendCycleView.swift
//  YLDouYuZB
//
//  Created by yl on 2016/10/13.
//  Copyright © 2016年 yl. All rights reserved.
//

import UIKit

private let kCycleCellID = "kCycleCellID"

class YLRecommendCycleView: UIView {
    //MARK:- 定义定时器属性
    var cycleTimer : Timer?
    
    //MARK:- 定义属性
    var cycleModelArr : [YLCycleModel]? {
        // 当从controller中将模型数据专递到这里的时候，我们需要监听属性的改变
        didSet {
            // 1.这里直接reloadData一下，collectionview将会重新走数据源代理方法（在数据源方法里面赋值即可）
            collectionView.reloadData();
            
            // 2.设置pagecontrol的个数
            pageControl.numberOfPages = cycleModelArr?.count ?? 0;
            
            // 3.实现无限轮播的时候设置默认所在的item（防止用户第一次就向前滚动）
            let indexPath = IndexPath(item: (cycleModelArr?.count ?? 0) * 10, section: 0);
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false);
            
            // 当有数据的时候就添加定时器  （一般情况下为了防止出现问题，我们首先要先移除一下定时器然后在添加）
            removeCycleTimer();
            addCycleTimer();
        }
    }
    
    //MARK:- 设置控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // 开始加载XIB文件的时候触发
    override func awakeFromNib() {
        super.awakeFromNib();
        //MARK:- 在这里设置不让View随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing();
        
        // 可以在加载xib文件的时候直接注册cell
        collectionView.register(UINib(nibName: "YLCollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID);
    }
    
    // 因为xib中collectionview的大小不是真实的大小，真实的大小是我们在外面自己设置的，所以这边在layoutsubview中设置大小才可以得到真实的大小
    override func layoutSubviews() {
        super.layoutSubviews();
        
        // 设置collectionView的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout;
        layout.itemSize = collectionView.bounds.size;
        
        //这些属性都在xib中设置也是可以的
//        layout.minimumLineSpacing = 0;
//        layout.minimumInteritemSpacing = 0;
//        layout.scrollDirection = .Horizontal;
//        collectionView.pagingEnabled = true;
    }
}

//MARK: -提供一个快速创建YLRecommendCycleView的类方法
extension YLRecommendCycleView {
   class func recommendCycleView() -> YLRecommendCycleView {
        // 在这里直接返回xib文件
        return Bundle.main.loadNibNamed("YLRecommendCycleView", owner: nil, options: nil)!.first as! YLRecommendCycleView;
    }
}

//MARK:- 遵守collectionView的datasource协议
extension YLRecommendCycleView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 这里乘以一个10000来实现无限轮播 （相当于很多的item）
        return (self.cycleModelArr?.count ?? 0) * 10000;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! YLCollectionCycleCell;
        // 这里膜上数据的count来防止越界，实现无限轮播
        let cycleModel = cycleModelArr![(indexPath as NSIndexPath).item % (cycleModelArr?.count ?? 1)];
        cell.cycleModel = cycleModel;
        
        cell.backgroundColor = (indexPath as NSIndexPath).item % 2 == 0 ? UIColor.red : UIColor.yellow;
        return cell;
    }
}

//MARK:- 遵守collectionView的delegate协议
extension YLRecommendCycleView : UICollectionViewDelegate {
    
    //MARK:- 监听collectionView的滚动（scrollView的滚动），来计算下面当前的pageControl
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 1.获取滚动的偏移量
        let offSetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5;
        
        // 2.计算pageControl当前的currentIndex (%是来实现无限轮播)
        pageControl.currentPage = Int(offSetX / scrollView.bounds.width) % (cycleModelArr?.count ?? 1);
    }
    
    //MARK:- 处理手动滚动和定时器滚动
    // 当手动拖拽的时候移除定时器
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer();
    }
    // 当停止拖拽的时候添加定时器
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer();
    }
}


//MARK:- 定时器的一些方法
extension YLRecommendCycleView {
    //MARK:- 添加定时器
    fileprivate func addCycleTimer(){
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true);
        //MARK:- 一般我们使用到定时器的时候都会将定时器添加到循环池中
        RunLoop.main.add(cycleTimer!, forMode: RunLoopMode.commonModes);
    }
    
    //MARK:- 移除定时器
    fileprivate func removeCycleTimer(){
        // 移除定时器时，首先要从循环池中移除掉
        cycleTimer?.invalidate();  // invalidate这个方法是从循环池中移除
        cycleTimer = nil;
    
    }
    
    //MARK:- 定时器触发的方法事件
    @objc func scrollToNext(){
        // 1.获取滚动的偏移量
        let currentOffsetX = collectionView.contentOffset.x;
        let offsetX = currentOffsetX + collectionView.bounds.width;
        
        // 2.滚动到该位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true);
    }
}

//
//  YLCollectionGameCell.swift
//  YLDouYuZB
//
//  Created by yl on 2016/10/14.
//  Copyright © 2016年 yl. All rights reserved.
//

import UIKit
import Kingfisher

class YLCollectionGameCell: UICollectionViewCell {
    //MARK:- 定义控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK:- 定义属性
    var anchorGroupM : YLAnchorGroupModel?{
        didSet {
            titleLabel.text = anchorGroupM?.tag_name;
            // swift3.0中如果你传个空字符串，系统会定义为他是空的一个字符串，所以这里要判断
            if let icon_url = URL(string: anchorGroupM?.icon_url ?? "") {
                iconImageView.kf.setImage(with: icon_url);
            }else {
                iconImageView.image = UIImage(named: "home_more_btn");
            }
        }
    }
    //MARK:- 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

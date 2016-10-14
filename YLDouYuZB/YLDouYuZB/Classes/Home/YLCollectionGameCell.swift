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
            let icon_url = NSURL(string: anchorGroupM?.icon_url ?? "");
            iconImageView.kf_setImageWithURL(icon_url,placeholderImage: UIImage(named: "home_more_btn"));
        }
    }
    //MARK:- 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

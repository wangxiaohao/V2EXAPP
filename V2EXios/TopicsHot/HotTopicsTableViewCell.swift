//
//  HotTopicsTableViewCell.swift
//  V2EXios
//
//  Created by 王浩 on 2017/6/20.
//  Copyright © 2017年 haowang. All rights reserved.
//

import UIKit

class HotTopicsTableViewCell: UITableViewCell {

    @IBOutlet weak var repliesLab: UILabel!
    @IBOutlet weak var timeLab: UILabel!
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var tagLab: UILabel!
    @IBOutlet weak var createNameLab: UILabel!
    @IBOutlet weak var avatarView: UIImageView!
    var model : HotModel?{
        didSet{
            avatarView.sd_setImage(with: URL.init(string: "https:" + ( model?.member?.avatar_normal ?? "")), placeholderImage: placeholder_Image)
            createNameLab.text = model?.member?.username
            titleLab.text = model?.title
            tagLab.text = model?.node?.title
            timeLab.text = Date.returnTimeString(WithTimestamp: Int(model?.created ?? 0))
            repliesLab.text = "\(model?.replies ?? 0)回复"
                    }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarView.layer.masksToBounds = true
        avatarView.layer.cornerRadius = 25
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

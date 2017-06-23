//
//  CommentTableViewCell.swift
//  V2EXios
//
//  Created by 王浩 on 2017/6/22.
//  Copyright © 2017年 haowang. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var contentLab: UILabel!
    @IBOutlet weak var timeLab: UILabel!
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var avatarView: UIImageView!
    var model:CommentModel!{
        didSet{
            nameLab.text = model.member?.username
            timeLab.text = Date.returnTimeString(WithTimestamp: Int(model.created))
            avatarView.sd_setImage(with: URL.init(string: "https:" + (model.member?.avatar_large ?? "")), placeholderImage: placeholder_Image)
            contentLab.text = model.content
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarView.layer.masksToBounds = true
        avatarView.layer.cornerRadius = 20
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

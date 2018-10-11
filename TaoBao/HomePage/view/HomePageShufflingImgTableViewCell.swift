//
//  HomePageShufflingImgTableViewCell.swift
//  TaoBao
//
//  Created by liushungxi on 2018/10/11.
//  Copyright © 2018年 liushungxi. All rights reserved.
//

import UIKit

class HomePageShufflingImgTableViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    let lunBoView = LunBo()
    override func awakeFromNib() {
        super.awakeFromNib()
        lunBoView.initView(tempHight: 140)
        view.addFullView(view: lunBoView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

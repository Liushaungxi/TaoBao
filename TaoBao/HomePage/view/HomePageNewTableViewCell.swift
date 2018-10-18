//
//  HomePageNewTableViewCell.swift
//  TaoBao
//
//  Created by liushungxi on 2018/10/12.
//  Copyright © 2018年 liushungxi. All rights reserved.
//

import UIKit

class HomePageNewTableViewCell: UITableViewCell {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        button1.layer.cornerRadius = 5
        button1.layer.borderColor = UIColor.red.cgColor
        button1.layer.borderWidth = 0.5
        button2.layer.cornerRadius = 5
        button2.layer.borderColor = UIColor.red.cgColor
        button2.layer.borderWidth = 0.5
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

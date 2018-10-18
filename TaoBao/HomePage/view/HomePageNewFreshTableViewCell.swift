//
//  HomePageNewFreshTableViewCell.swift
//  TaoBao
//
//  Created by liushungxi on 2018/10/12.
//  Copyright © 2018年 liushungxi. All rights reserved.
//

import UIKit

class HomePageNewFreshTableViewCell: UITableViewCell {

    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var exampleImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func initCell(titleImg:UIImage,titleText:String,contentText:String,exampleImage:UIImage){
        titleImage.image = titleImg
        titleLabel.text = titleText
        contentLabel.text = contentText
        exampleImg.image = exampleImage
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

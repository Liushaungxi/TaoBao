//
//  HomePageTitleTableViewCell.swift
//  TaoBao
//
//  Created by liushungxi on 2018/10/12.
//  Copyright © 2018年 liushungxi. All rights reserved.
//

import UIKit
import LeanCloud
class HomePageTitleTableViewCell: UITableViewCell {

    @IBOutlet weak var titleImg: UIImageView!
    @IBOutlet weak var leftImg: UIImageView!
    @IBOutlet weak var leftImgWight: NSLayoutConstraint!
    @IBOutlet weak var rightImg: UIImageView!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    var tempTitle = ""
    var title = ""{
        didSet{
            if title != tempTitle{
                getData()
            }
        }
    }
    var data = KfTitleCell(){
        didSet{
            initData()
        }
    }
    func getData(){
        var tempData = [KfTitleCell]()
        let query = LCQuery(className: "KfTitleCell")
        query.whereKey("title", .equalTo(title))
        query.find { (result) in
            switch result{
            case .success(let objects):
                for item in objects{
                    if let netModel = KfTitleCell.deserialize(from: item.jsonString){
                        tempData.append(netModel)
                    }
                }
                self.data = tempData.first ?? KfTitleCell()
            case .failure(let error):
                print(error)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        leftImgWight.constant = (mainScreen_wight-1)/3*2
    }
    func initData(){
        titleImg.kf.setImage(with: data.titleImg.url.url())
        leftImg.kf.setImage(with: data.leftImg.url.url())
        leftLabel.text = data.leftText
        rightImg.kf.setImage(with: data.rightImg.url.url())
        rightLabel.text = data.rightText
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

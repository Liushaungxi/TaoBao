//
//  HomePageLiveStudyTableViewCell.swift
//  TaoBao
//
//  Created by liushungxi on 2018/10/17.
//  Copyright © 2018年 liushungxi. All rights reserved.
//

import UIKit
import LeanCloud
class HomePageLiveStudyTableViewCell: UITableViewCell {

    @IBOutlet var views: [UIView]!
    @IBOutlet weak var titleImg: UIImageView!
    @IBOutlet var imgs: [UIImageView]!
    @IBOutlet var contents: [UILabel]!
    
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
        for item in views{
            item.layer.borderWidth = 0.5
            item.layer.borderColor = UIColor.white.cgColor
        }
    }
    func initData(){
        titleImg.kf.setImage(with: data.titleImg.url.url())
        imgs[0].kf.setImage(with: data.leftImg.url.url())
        contents[0].text = data.leftText
        imgs[1].kf.setImage(with: data.rightImg.url.url())
        contents[1].text = data.rightText
        imgs[2].kf.setImage(with: data.threeImg.url.url())
        contents[2].text = data.threeText
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

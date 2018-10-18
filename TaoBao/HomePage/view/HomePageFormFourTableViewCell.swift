//
//  HomePageFormFourTableViewCell.swift
//  TaoBao
//
//  Created by liushungxi on 2018/10/17.
//  Copyright © 2018年 liushungxi. All rights reserved.
//

import UIKit
import LeanCloud
class HomePageFormFourTableViewCell: UITableViewCell {

    @IBOutlet var views: [UIView]!
    @IBOutlet var imgs: [UIImageView]!
    @IBOutlet var titleLabels: [UILabel]!
    @IBOutlet var subtitleLabels: [UILabel]!
    var data = [KfLiveStreamingCellData](){
        didSet{
            initData()
        }
    }
    func initData(){
        for i in 0..<data.count{
            imgs[i].kf.setImage(with: data[i].img.url.url())
            titleLabels[i].text = data[i].title
            subtitleLabels[i].text = data[i].subtitle
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        for item in views{
            item.layer.borderColor = UIColor.groupTableViewBackground.cgColor
            item.layer.borderWidth = 0.5
        }
        // Initialization code
    }
    var tempTitle = ""
    var title = ""{
        didSet{
            if title != tempTitle{
                getData()
            }
        }
    }
    func getData(){
        tempTitle = title
        var tempData = [KfLiveStreamingCellData]()
        let query = LCQuery(className: "KfLiveStreamingCellData")
        query.whereKey("supers", .equalTo(title))
        query.find { (result) in
            switch result{
            case .success(let objects):
                for item in objects{
                    if let netModel = KfLiveStreamingCellData.deserialize(from: item.jsonString){
                        tempData.append(netModel)
                    }
                }
                self.data = tempData
            case .failure(let error):
                print(error)
            }
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

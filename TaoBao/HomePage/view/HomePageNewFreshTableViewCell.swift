//
//  HomePageNewFreshTableViewCell.swift
//  TaoBao
//
//  Created by liushungxi on 2018/10/12.
//  Copyright © 2018年 liushungxi. All rights reserved.
//

import UIKit
import LeanCloud
class HomePageNewFreshTableViewCell: UITableViewCell {

    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var exampleImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var data = KfLiveStreamingCellData(){
        didSet{
            initData()
        }
    }
    func initData(){
        titleLabel.text = data.title
        contentLabel.text = data.subtitle
        exampleImg.kf.setImage(with: data.img.url.url())
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
        let query = LCQuery(className: "KfLiveStreamingCellData")
        query.whereKey("supers", .equalTo(title))
        query.find { (result) in
            switch result{
            case .success(let objects):
                for item in objects{
                    if let netModel = KfLiveStreamingCellData.deserialize(from: item.jsonString){
                        self.data = netModel
                    }
                }
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

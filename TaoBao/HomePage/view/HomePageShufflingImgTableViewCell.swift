//
//  HomePageShufflingImgTableViewCell.swift
//  TaoBao
//
//  Created by liushungxi on 2018/10/11.
//  Copyright © 2018年 liushungxi. All rights reserved.
//

import UIKit
import LeanCloud
class HomePageShufflingImgTableViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    let lunBoView = LunBo()
    var images = [String]()
    var data = [KfLunBoCellData](){
        didSet{
            for item in data{
                images.append(item.img.url)
                print(item.img.url)
            }
            lunBoView.images = images
            lunBoView.initView(tempHight: 140)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        view.addFullView(view: lunBoView)
        getData()
    }
    func getData(){
        var tempData = [KfLunBoCellData]()
        let query = LCQuery(className: "KfLunBoCellData")
        query.find { (result) in
            switch result{
            case .success(let objects):
                for item in objects{
                    if let netModel = KfLunBoCellData.deserialize(from: item.jsonString){
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
    }
    
}

//
//  HomePageNavigationTableViewCell.swift
//  TaoBao
//
//  Created by liushungxi on 2018/10/12.
//  Copyright © 2018年 liushungxi. All rights reserved.
//

import UIKit
import LeanCloud
class HomePageNavigationTableViewCell: UITableViewCell {

    @IBOutlet var titleImgs: [UIImageView]!
    @IBOutlet var titleLabels: [UILabel]!
    var data = [KfNavigationCellData](){
        didSet{
            initData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        for item in titleImgs{
            item.layer.cornerRadius = 30
            item.clipsToBounds = true
        }
        getData()
    }
    func initData(){
        for (i,item) in data.enumerated(){
            titleLabels[i].font = UIFont.systemFont(ofSize: 12)
            titleImgs[i].kf.setImage(with: item.img.url.url())
            titleLabels[i].text = item.name
        }
    }
    func getData(){
        var tempData = [KfNavigationCellData]()
        let query = LCQuery(className: "KfNavigationCellData")
        query.find { (result) in
            switch result{
            case .success(let objects):
                for item in objects{
                    if let netModel = KfNavigationCellData.deserialize(from: item.jsonString){
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

//
//  HomePageGoodStorTableViewCell.swift
//  TaoBao
//
//  Created by liushungxi on 2018/10/17.
//  Copyright © 2018年 liushungxi. All rights reserved.
//

import UIKit
import LeanCloud
class HomePageGoodStorTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: [UILabel]!
    @IBOutlet var subtitleLabel: [UILabel]!
    @IBOutlet var image1: [UIImageView]!
    @IBOutlet var image2: [UIImageView]!
    @IBOutlet var imag3: [UIImageView]!
    
    var data = [KfGoodStorCellData](){
        didSet{
            initData()
        }
    }
    var index = 0
    func getData(){
        var tempData = [KfGoodStorCellData]()
        let query = LCQuery(className: "KfGoodStorCellData")
        query.find { (result) in
            switch result{
            case .success(let objects):
                for item in objects{
                    if let netModel = KfGoodStorCellData.deserialize(from: item.jsonString){
                        tempData.append(netModel)
                    }
                }
                self.data = tempData
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        getData()
    }
    func initData(){
        titleLabel[0].text = data[index].title
        subtitleLabel[0].text = data[index].subtitle
        image1[0].kf.setImage(with: data[index].img1.url.url())
        image2[0].kf.setImage(with: data[index].img2.url.url())
        imag3[0].kf.setImage(with: data[index].img3.url.url())
        index+=1
        
        titleLabel[1].text = data[index].title
        subtitleLabel[1].text = data[index].subtitle
        image1[1].kf.setImage(with: data[index].img1.url.url())
        image2[1].kf.setImage(with: data[index].img2.url.url())
        imag3[1].kf.setImage(with: data[index].img3.url.url())
        index-=1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

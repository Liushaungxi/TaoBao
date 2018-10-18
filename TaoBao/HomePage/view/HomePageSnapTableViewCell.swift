//
//  HomePageSnapTableViewCell.swift
//  TaoBao
//
//  Created by liushungxi on 2018/10/12.
//  Copyright © 2018年 liushungxi. All rights reserved.
//

import UIKit
import LeanCloud
class HomePageSnapTableViewCell: UITableViewCell {

    
    @IBOutlet weak var leftTitleLabel: UILabel!
    @IBOutlet weak var leftSubtitleLabel: UILabel!
    @IBOutlet weak var leftSmallImg: UIImageView!
    @IBOutlet weak var leftBigImg: UIImageView!
    @IBOutlet weak var rightTitleLabel: UILabel!
    @IBOutlet weak var rightSubtitleLabel: UILabel!
    @IBOutlet weak var rightSmallImg: UIImageView!
    @IBOutlet weak var rightBigImg: UIImageView!
    @IBOutlet weak var leftBoxView: UIView!
    @IBOutlet weak var rightBoxView: UIView!
    var tempTitle = ""
    var title = ""{
        didSet{
            if title != tempTitle{
                getData()
            }
        }
    }
    var index = 0
    var data = [KfSnapCellData](){
        didSet{
            initData()
        }
    }
    func getData(){
        //防止从释放池里拿出来再次获取数据
        tempTitle = title
        var tempData = [KfSnapCellData]()
        let query = LCQuery(className: "KfSnapCellData")
        query.whereKey("supers", .equalTo(title))
        query.find { (result) in
            switch result{
            case .success(let objects):
                for item in objects{
                    if let netModel = KfSnapCellData.deserialize(from: item.jsonString){
                        tempData.append(netModel)
                    }
                }
                self.data = tempData
            case .failure(let error):
                print(error)
            }
        }
    }
    func initData(){
        leftBigImg.kf.setImage(with: data[index].bigImg.url.url())
        leftSmallImg.kf.setImage(with: data[index].smallImg.url.url())
        leftSubtitleLabel.text = data[index].sbutitle
        leftTitleLabel.text = data[index].title
        index += 1
        rightBigImg.kf.setImage(with: data[index].bigImg.url.url())
        rightSmallImg.kf.setImage(with: data[index].smallImg.url.url())
        rightSubtitleLabel.text = data[index].sbutitle
        rightTitleLabel.text = data[index].title
        index -= 1
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        leftBoxView.layer.borderWidth = 1
        leftBoxView.layer.borderColor = UIColor.groupTableViewBackground.cgColor
       
        rightBoxView.layer.borderWidth = 1
        rightBoxView.layer.borderColor = UIColor.groupTableViewBackground.cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  HomePageNewsTableViewCell.swift
//  TaoBao
//
//  Created by liushungxi on 2018/10/12.
//  Copyright © 2018年 liushungxi. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire
import LeanCloud
class HomePageNewsTableViewCell: UITableViewCell {

    @IBOutlet weak var allNewButton: UIButton!
    @IBOutlet weak var newsTableview: UITableView!
    var provider:TableViewProvider!
    var data = [KfNewsCellData]()
    override func awakeFromNib() {
        super.awakeFromNib()
        newsTableview.isScrollEnabled = false
        provider = TableViewProvider.init(newsTableview)
        provider.registerCells(cells: [HomePageNewTableViewCell.self])
        getData()
    }
    func getData(){
        let query = LCQuery(className: "KfNewsCellData")
        query.find { (result) in
            switch result{
            case .success(let objects):
                for item in objects{
                    if let netModel = KfNewsCellData.deserialize(from: item.jsonString){
                        self.data.append(netModel)
                    }
                }
                self.data.append(self.data.first!)
                self.initCell()
            case .failure(let error):
                print(error)
            }
        }
    }
    func initTimer(){
        lunboTimer.invalidate()
        lunboTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(lunBoAction), userInfo: nil, repeats: true)
        RunLoop.current.add(lunboTimer, forMode: .commonModes)
    }
    @objc func lunBoAction(){
        UIView.animate(withDuration: 0.3) {
            self.provider.customTableView.contentOffset.y += 55
        }
        if self.provider.customTableView.contentOffset.y >= CGFloat(55*(data.count-1)){
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                self.provider.customTableView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            }
        }
        
    }
    var lunboTimer = Timer()
    func initCell() {
        provider.addSection { (section) in
            for item in data{
                section.addRow(HomePageNewTableViewCell.self, { (cell) in
                    cell.button1.isSelected = item.newType1
                    cell.button2.isSelected = item.newType2
                    cell.label1.text = item.title1
                    cell.label2.text = item.title2
                    cell.img.kf.setImage(with: item.img.url.url())
                }, nil)
            }
        }
        initTimer()
    }
    @IBAction func allNewAction(_ sender: UIButton) {
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

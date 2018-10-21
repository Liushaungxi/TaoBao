//
//  HomePageTableViewController.swift
//  TaoBao
//
//  Created by liushungxi on 2018/10/11.
//  Copyright © 2018年 liushungxi. All rights reserved.
//

import UIKit

class HomePageTableViewController: UITableViewController{
    var provider:TableViewProvider!
    override func viewDidLoad() {
        super.viewDidLoad()
        provider = TableViewProvider.init(tableView)
        addScrollAction()
        provider.registerCells(cells: [HomePageShufflingImgTableViewCell.self,HomePageNavigationTableViewCell.self,HomePageNewsTableViewCell.self,HomePageNewFreshTableViewCell.self,BlankTableViewCell.self,HomePageSnapTableViewCell.self,HomePageTitleTableViewCell.self,HomePageLiveStreamingTableViewCell.self,HomePageFormFourTableViewCell.self,HomePageLiveStudyTableViewCell.self,HomePageGoodStorTableViewCell.self,HomePageFormThreeTableViewCell.self,HomePageYouLikeTableViewCell.self])
//        navigationController?.navigationBar.alpha = 1
//        let nibView = Bundle.main.loadNibNamed("HomePageBarItemView", owner: self, options: nil)
//        let navgationBarView = nibView?.first as? HomePageBarItemView ?? UIView()
//        navigationController?.navigationBar.addFullView(view: navgationBarView)
        initCell()
    }
    func addScrollAction(){
        provider.scrollDidEndDraggingBlock = {
            if self.lunBoTableViewCells[0] is HomePageShufflingImgTableViewCell && self.lunBoTableViewCells[1] is HomePageNewsTableViewCell{
                let cell1 = self.lunBoTableViewCells[0] as! HomePageShufflingImgTableViewCell
                let cell2 = self.lunBoTableViewCells[1] as! HomePageNewsTableViewCell
                if self.tableView.contentOffset.y<140{
                    cell1.lunBoView.initTimer()
                    cell2.initTimer()
                }
                else if self.tableView.contentOffset.y>=140 && self.tableView.contentOffset.y<416{
                    cell1.lunBoView.lunBoTimer.invalidate()
                    cell2.initTimer()
                }
                else{
                    cell1.lunBoView.lunBoTimer.invalidate()
                    cell2.lunboTimer.invalidate()
                }
            }
        }
    }
    var lunBoTableViewCells = [UITableViewCell]()
    func initCell() {
        provider.addSection { (section) in
            lunBoTableViewCells.removeAll()
            //轮播图
            section.addRow(HomePageShufflingImgTableViewCell.self, { (cell) in
                cell.lunBoView.clickBlock = {[weak self](index)in
                    guard let weakSelf = self else{return}
                    print(index)
                }
                self.lunBoTableViewCells.append(cell)
            }, nil)
            //分类
            section.addRow(HomePageNavigationTableViewCell.self, { (cell) in
            }, nil)
            //头条
            section.addRow(HomePageNewsTableViewCell.self, { (cell) in
                self.lunBoTableViewCells.append(cell)
            }, nil)
            section.addRow(BlankTableViewCell.self)
            //淘鲜达
            section.addRow(HomePageNewFreshTableViewCell.self, { (cell) in
                cell.title = "淘鲜达"
            }, nil)
            section.addRow(BlankTableViewCell.self)
            //抢购
            section.addRow(HomePageSnapTableViewCell.self, { (cell) in
                cell.index = 0
                cell.rightTitleLabel.textColor = UIColor.init(red: 40/255, green: 132/255, blue: 247/255, alpha: 1)
                cell.leftTitleLabel.textColor = UIColor.init(red: 255/255, green: 0/255, blue: 0/255, alpha: 1)
                cell.title = "HomePage"
            }, nil)
            section.addRow(HomePageSnapTableViewCell.self, { (cell) in
                cell.title = "HomePage"
                cell.index = 2
                cell.leftTitleLabel.textColor = UIColor.init(red: 255/255, green: 0/255, blue: 90/255, alpha: 1)
                cell.rightTitleLabel.textColor = UIColor.init(red: 255/255, green: 0/255, blue: 67/255, alpha: 1)
            }, nil)
            //淘宝直播
            section.addRow(HomePageTitleTableViewCell.self, { (cell) in
                cell.title = "淘宝直播"
            }, nil)
            section.addRow(HomePageLiveStreamingTableViewCell.self, { (cell) in
                cell.title = "淘宝直播"
            }, nil)
            //潮流酷玩
            section.addRow(HomePageTitleTableViewCell.self, { (cell) in
                cell.title = "潮流酷玩"
            }, nil)
            section.addRow(HomePageSnapTableViewCell.self, { (cell) in
                cell.index = 0
                cell.title = "潮流酷玩"
            }, nil)
            section.addRow(HomePageSnapTableViewCell.self, { (cell) in
                cell.title = "潮流酷玩"
                cell.index = 2
            }, nil)
            //实惠好货
            section.addRow(HomePageTitleTableViewCell.self, { (cell) in
                cell.title = "实惠好货"
            }, nil)
            section.addRow(HomePageSnapTableViewCell.self, { (cell) in
                cell.index = 0
                cell.leftTitleLabel.textColor = UIColor.darkText
                cell.rightTitleLabel.textColor = UIColor.darkText
                cell.title = "实惠好货"
            }, nil)
            section.addRow(HomePageFormFourTableViewCell.self, { (cell) in
                cell.title = "实惠好货"
            }, nil)
            //买遍全球
            section.addRow(HomePageTitleTableViewCell.self, { (cell) in
                cell.title = "买遍全球"
            }, nil)
            section.addRow(HomePageSnapTableViewCell.self, { (cell) in
                cell.index = 0
                cell.title = "买遍全球"
            }, nil)
            section.addRow(HomePageSnapTableViewCell.self, { (cell) in
                cell.title = "买遍全球"
                cell.index = 2
            }, nil)
            //时尚大咖
            section.addRow(HomePageTitleTableViewCell.self, { (cell) in
                cell.title = "时尚大咖"
            }, nil)
            section.addRow(HomePageSnapTableViewCell.self, { (cell) in
                cell.index = 0
                cell.title = "时尚大咖"
            }, nil)
            section.addRow(HomePageSnapTableViewCell.self, { (cell) in
                cell.title = "时尚大咖"
                cell.index = 2
            }, nil)
            //我淘我家
            section.addRow(HomePageTitleTableViewCell.self, { (cell) in
                cell.title = "我淘我家"
            }, nil)
            section.addRow(HomePageSnapTableViewCell.self, { (cell) in
                cell.index = 0
                cell.title = "我淘我家"
            }, nil)
            section.addRow(HomePageSnapTableViewCell.self, { (cell) in
                cell.title = "我淘我家"
                cell.index = 2
            }, nil)
            section.addRow(BlankTableViewCell.self)
            section.addRow(HomePageFormFourTableViewCell.self, { (cell) in
                cell.title = "我淘我家"
            }, nil)
            section.addRow(HomePageSnapTableViewCell.self, { (cell) in
                cell.title = "我淘我家"
                cell.index = 4
            }, nil)
            //生活研究所
            section.addRow(HomePageLiveStudyTableViewCell.self, { (cell) in
                cell.title = "生活研究所"
            }, nil)
            section.addRow(HomePageFormThreeTableViewCell.self, { (cell) in
                cell.index = 0
                cell.title = "生活研究所"
            }, nil)
            section.addRow(HomePageFormThreeTableViewCell.self, { (cell) in
                cell.index = 3
                cell.title = "生活研究所"
            }, nil)
            //每日好店
            section.addRow(HomePageTitleTableViewCell.self, { (cell) in
                cell.title = "每日好店"
            }, nil)
            section.addRow(HomePageGoodStorTableViewCell.self, { (cell) in
                cell.index = 0
            }, nil)
            section.addRow(HomePageGoodStorTableViewCell.self, { (cell) in
                cell.index = 2
            }, nil)
            section.addRow(BlankTableViewCell.self)
            //猜你喜欢
            section.addRow(HomePageYouLikeTableViewCell.self, { (cell) in
            }, nil)
        }
    }
}

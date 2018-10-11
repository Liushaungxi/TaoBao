//
//  HomePageTableViewController.swift
//  TaoBao
//
//  Created by liushungxi on 2018/10/11.
//  Copyright © 2018年 liushungxi. All rights reserved.
//

import UIKit

class HomePageTableViewController: UITableViewController {

    var provider:TableViewProvider!
    override func viewDidLoad() {
        super.viewDidLoad()
        provider = TableViewProvider.init(tableView)
        provider.registerCells(cells: [HomePageShufflingImgTableViewCell.self])
        initCell()
    }
    func initCell() {
        provider.addSection { (section) in
            section.addRow(HomePageShufflingImgTableViewCell.self, { (cell) in
                
            }, nil)
        }
    }
}

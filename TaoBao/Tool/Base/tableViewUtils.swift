//
//  tableViewUtils.swift
//  MyMooc2
//
//  Created by lyonse on 2018/5/6.
//  Copyright © 2018年 lyonse. All rights reserved.
//

import Foundation
import UIKit
extension UITableView {

    func registerNibCell(_ type:UITableViewCell.Type) {
        let id = "\(type)"
        let nib1 = UINib.init(nibName: id, bundle: nil)
        self.register(nib1, forCellReuseIdentifier: id)
    }
    
    func registerClassCell(_ type: UITableViewCell.Type) {
        self.register(type, forCellReuseIdentifier: "\(type)")
    }
    
    func registerNibCells(_ cells: [UITableViewCell.Type]) {
        for cell in cells {
            registerNibCell(cell)
        }
    }
    
    func registerClassCells(_ cells: [UITableViewCell.Type]) {
        for cell in cells {
            registerClassCell(cell)
        }
    }
}

protocol UITableViewCellReUse {}

extension UITableViewCellReUse {
    static func reuseFrom(tableView:UITableView) -> Self {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(self)") else {
            fatalError("\(self) is not registed")
        }
        return cell as! Self
    }
    static func reuseFrom(tableView:UITableView, indexPath:IndexPath) -> Self {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(self)", for: indexPath)
        return cell as! Self
    }
    
}
extension UITableViewCell:UITableViewCellReUse {}

protocol TableViewRowProtocol:NSObjectProtocol {
    func configCell(_ tableView:UITableView, _ indexPath:IndexPath) -> UITableViewCell
    func didSelected(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
}

class TableViewSection: NSObject {
    var customRows = [TableViewRowProtocol]()

    func addRow<T:UITableViewCell>(_ type:T.Type, _ cell:((T)->Void)?=nil, _ didSelected:(()->Void)?=nil) {
        let newRow = TableViewRow<T>.init(cell)
        newRow.didSelected0 = didSelected
        customRows.append(newRow)
    }

    func addRow<T:UITableViewCell>(_ type:T.Type, _ cell:((T,UITableView,IndexPath)->Void)?=nil, _ didSelected:((UITableView,IndexPath)->Void)?=nil) {
        let newRow = TableViewRow<T>.init(cell)
        newRow.didSelected1 = didSelected
        customRows.append(newRow)
    }
    
    func addRow<T:UITableViewCell>(_ type:T.Type, _ row:((TableViewRow<T>)->Void)?=nil) {
        let newRow = TableViewRow<T>.init()
        customRows.append(newRow)
        row?(newRow)
    }
}

class TableViewRow<T:UITableViewCell>: NSObject, TableViewRowProtocol {

    var cell0:((T)->Void)?
    var cell1:((T,UITableView,IndexPath)->Void)?
    var didSelected0:(()->Void)?
    var didSelected1:((UITableView,IndexPath)->Void)?
    override init() {
        super.init()
    }
    init(_ cell:((T)->Void)?=nil) {
        self.cell0 = cell
    }
    init(_ cell:((T,UITableView,IndexPath)->Void)?=nil) {
        self.cell1 = cell
    }
    func configCell(_ tableView:UITableView, _ indexPath:IndexPath) -> UITableViewCell {
        let tempT = T.reuseFrom(tableView: tableView, indexPath: indexPath)
        tempT.selectionStyle = .none
        cell0?(tempT)
        cell1?(tempT,tableView,indexPath)
        return tempT
    }
    func didSelected(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelected0?()
        didSelected1?(tableView, indexPath)
    }
}
class TableViewProvider: NSObject, UITableViewDelegate, UITableViewDataSource {
    weak var customTableView:UITableView!
    init(_ tableView:UITableView) {
        super.init()
        self.customTableView = tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none

    }
    var customSections = [TableViewSection]()
    
    func reload() {
        customTableView.reloadData()
    }
    func addSection(_ sectionBlock:((TableViewSection)->Void)) {
        let newSection = TableViewSection()
        customSections.append(newSection)
        sectionBlock(newSection)
        customTableView.reloadData()
    }
    
    func lastSection(_ sectionBlock:((TableViewSection)->Void)) {
        if let newSection = customSections.last {
            sectionBlock(newSection)
            return
        }
        addSection(sectionBlock)
    }
    
    func resetSection(_ sectionBlock:((TableViewSection)->Void)) {
        customSections.removeAll()
        addSection(sectionBlock)
    }
    
    func resetSection() {
        customSections.removeAll()
        customTableView.reloadData()
    }
    func registerCells(cells:[UITableViewCell.Type]) {
        for temp in cells {
            customTableView.registerCell(cell: temp.self)
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return customSections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customSections[section].customRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = customSections[indexPath.section].customRows[indexPath.row]
        return cell.configCell(tableView,indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = customSections[indexPath.section].customRows[indexPath.row]
        cell.didSelected(tableView, didSelectRowAt: indexPath)
    }

}

//
//  File.swift
//  TestNewWayToWriteCell
//
//  Created by lyonse on 2017/12/27.
//  Copyright © 2017年 lyonse. All rights reserved.
//

import Foundation
import UIKit

func sections(of dataSource:[[TableCellProviderProtocol]]) -> Int {
    return dataSource.count
}

func rows(of section:Int, dataSource:[[TableCellProviderProtocol]]) -> Int {
    return dataSource[section].count
}

func provider(of indexPath:IndexPath, dataSource:[[TableCellProviderProtocol]]) -> TableCellProviderProtocol {
    return dataSource[indexPath.section][indexPath.row]
}

func filterRows(of section:Int, dataSource:[[TableCellProviderProtocol]]) -> Int {
    return dataSource[section].filter({$0.isHidden == false}).count
}

func filterProvider(of indexPath:IndexPath, dataSource:[[TableCellProviderProtocol]]) -> TableCellProviderProtocol {
    return dataSource[indexPath.section].filter({$0.isHidden == false})[indexPath.row]
}

protocol TableCellProviderProtocol:NSObjectProtocol {
    var isHidden:Bool { get set}
    func makeCell(_ tableView:UITableView, _ indexPath:IndexPath) -> UITableViewCell
    func respondsToSelected(_ tableView:UITableView, _ indexPath:IndexPath)
    func respondsToDeleted(_ tableView:UITableView, _ indexPath:IndexPath)
    func delete(_ tableView:UITableView, _ indexPath:IndexPath, _ dataSource:inout [[TableCellProviderProtocol]])
    func insert(_ tableView:UITableView, _ indexPath:IndexPath, _ dataSource:inout [[TableCellProviderProtocol]])
    func replace(_ tableView:UITableView, _ indexPath:IndexPath, _ dataSource:inout [[TableCellProviderProtocol]])
}

typealias CellConfiger<T:UITableViewCell> = (UITableView, IndexPath, T) -> ()
typealias CellBlocker<T:UITableViewCell> = (UITableView, IndexPath, T) -> ()

class TableCellProvider<T:UITableViewCell>:NSObject, TableCellProviderProtocol {
    var identifier = ""
    var cell:CellConfiger<T>?
    var didSelected:CellBlocker<T>?
    var didDeleted:CellBlocker<T>?
    func makeCell(_ tableView:UITableView, _ indexPath:IndexPath) -> UITableViewCell {
        let tempT = T.reuseFrom(tableView: tableView, indexPath: indexPath)
        cell?(tableView, indexPath, tempT)
        return tempT
    }
    func respondsTo(_ tableView:UITableView, _ indexPath:IndexPath, _ block:CellBlocker<T>?) {
        let tempT = tableView.cellForRow(at: indexPath) as! T
        block?(tableView, indexPath, tempT)
    }
    func respondsToSelected(_ tableView:UITableView, _ indexPath:IndexPath) {
        respondsTo(tableView, indexPath, didSelected)
    }
    func respondsToDeleted(_ tableView:UITableView, _ indexPath:IndexPath) {
        respondsTo(tableView, indexPath, didDeleted)
    }
    var open = true {
        didSet {
            for child in children {
                child.isHidden = !open
            }
        }
    }
    var isHidden = false {
        didSet {
            for child in children {
                child.isHidden = !open || isHidden
            }
        }
    }
    //
    var currentIndexPath = IndexPath(row: 0, section: 0)
    var offsetIndexPath = IndexPath(row: 1, section: 0)
    var children = [TableCellProvider]() {
        didSet {
            for child in children {
                child.isHidden = !open
            }
        }
    }
    var childrenPaths:[IndexPath] {
        var arr = [IndexPath]()
        for i in 0..<children.count {
            arr.append(IndexPath(row: i + offsetIndexPath.row + currentIndexPath.row, section: offsetIndexPath.section  + currentIndexPath.section))
            if children[i].open {
                arr.append(contentsOf: children[i].childrenPaths)
            }
        }
        return arr
    }
    
    func unpack(_ tableView:UITableView) {
        open = !open
        let arr = childrenPaths
        if open {
            tableView.insertRows(at: arr, with: .fade)
        } else {
            tableView.deleteRows(at: arr, with: .fade)
        }
        tableView.reloadRows(at: [currentIndexPath], with: .none)
    }
    
    func delete(_ tableView:UITableView, _ indexPath:IndexPath, _ dataSource:inout [[TableCellProviderProtocol]]) {
        guard dataSource.count > indexPath.section else {
            return
        }
        guard dataSource[indexPath.section].count > indexPath.row else {
            return
        }
        dataSource[indexPath.section].remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    func replace(_ tableView:UITableView, _ indexPath:IndexPath, _ dataSource:inout [[TableCellProviderProtocol]]) {
        guard dataSource.count > indexPath.section else {
            return
        }
        guard dataSource[indexPath.section].count > indexPath.row else {
            return
        }
        dataSource[indexPath.section][indexPath.row] = self
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    func insert(_ tableView:UITableView, _ indexPath:IndexPath, _ dataSource:inout [[TableCellProviderProtocol]]) {
        if dataSource.count == 0 && indexPath == IndexPath(row:0, section:0) {
            dataSource = [[self]]
            tableView.insertRows(at: [indexPath], with: .fade)
            return
        }
        if dataSource.count == indexPath.section && indexPath.row == 0 {
            dataSource.append([self])
            tableView.insertRows(at: [indexPath], with: .fade)
            return
        }
        if dataSource.count > indexPath.section && dataSource[indexPath.section].count >= indexPath.row {
            dataSource[indexPath.section].insert(self, at: indexPath.row)
            tableView.insertRows(at: [indexPath], with: .fade)
            return
        }
    }
}

extension UITableView {
    func autoHeight(_ value:CGFloat = 90) {
        self.estimatedRowHeight = value
        self.rowHeight = UITableView.automaticDimension
        self.tableFooterView = UIView()
    }
}

//protocol UITableViewCellReUse {}
//
//extension UITableViewCellReUse {
//    static func reuseFrom(tableView:UITableView) -> Self {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: className(self)) else {
//            fatalError("\(className(self)) is not register")
//        }
//        return cell as! Self
//    }
//    static func reuseFrom(tableView:UITableView, indexPath:IndexPath) -> Self {
//        let cell = tableView.dequeueReusableCell(withIdentifier: className(self), for: indexPath)
//        return cell as! Self
//    }
//    
//}
//extension UITableViewCell:UITableViewCellReUse {}
//
//extension UITableView {
//    func registerNibCell(_ cell: UITableViewCell.Type) {
//        let nib = UINib.init(nibName: className(cell), bundle: nil)
//        self.register(nib, forCellReuseIdentifier: className(cell))
//    }
//    
//    func registerClassCell(_ cell: UITableViewCell.Type) {
//        self.register(cell, forCellReuseIdentifier: className(cell))
//    }
//    
//    func registerNibCells(_ cells: [UITableViewCell.Type]) {
//        for cell in cells {
//            registerNibCell(cell)
//        }
//    }
//    
//    func registerClassCells(_ cells: [UITableViewCell.Type]) {
//        for cell in cells {
//            registerClassCell(cell)
//        }
//    }
//}


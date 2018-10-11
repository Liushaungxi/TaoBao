//
//  CellDelegater.swift
//  TestNewWayToWriteCell
//
//  Created by lyonse on 2017/12/27.
//  Copyright © 2017年 lyonse. All rights reserved.
//

import Foundation
import UIKit

class TableCellDelegater: NSObject, UITableViewDelegate, UITableViewDataSource {
    var enableFilter = false
    var dataSource = [[TableCellProviderProtocol]]()
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections(of: dataSource)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if enableFilter {
            return filterRows(of: section, dataSource: dataSource)
        }
        return rows(of: section, dataSource: dataSource)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if enableFilter {
            return filterProvider(of: indexPath, dataSource: dataSource).makeCell(tableView, indexPath)
        }
        return provider(of: indexPath, dataSource: dataSource).makeCell(tableView, indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if enableFilter {
            filterProvider(of: indexPath, dataSource: dataSource).respondsToSelected(tableView, indexPath)
            return
        }
        provider(of: indexPath, dataSource: dataSource).respondsToSelected(tableView, indexPath)
    }
}

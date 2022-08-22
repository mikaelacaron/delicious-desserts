//
//  UITableView+Ext.swift
//  DeliciousDesserts
//
//  Created by David Ruvinskiy on 8/16/22.
//

import UIKit

extension UITableView {
    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}

extension UITableViewController {
    func reloadDataOnMainThread() {
        DispatchQueue.main.async { self.tableView.reloadData() }
    }
}

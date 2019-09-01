//
//  TabResultCollectionViewCell.swift
//  CustomTabBar
//
//  Created by 홍주연 on 01/09/2019.
//  Copyright © 2019 hongjuyeon. All rights reserved.
//

import UIKit

class TabResultCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tableView: UITableView!
    var dataArray: [String]?{
        didSet{
            tableView.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tableView.tableFooterView = UIView()
    }
}

extension TabResultCollectionViewCell: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let data = dataArray else {
            return 0
        }
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultTableViewCell", for: indexPath) as! ResultTableViewCell
        cell.textData = dataArray?[indexPath.row]
        return cell
        
    }
}

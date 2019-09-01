//
//  TabBarCollectionViewCell.swift
//  CustomTabBar
//
//  Created by 홍주연 on 01/09/2019.
//  Copyright © 2019 hongjuyeon. All rights reserved.
//

import UIKit

class TabBarCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var indicatorView: UIView!
    
    var customTabBar: CustomTabBar?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        label.text = ""
        indicatorView.isHidden = true
    }
    
    func setUI(){
        label.text = customTabBar?.label
        guard let isSelected = customTabBar?.isSelected else { return }
        
        indicatorView.isHidden = !isSelected
        
        if isSelected {
            label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            indicatorView.isHidden = false
        }
        else {
            label.textColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1)
            indicatorView.isHidden = true
        }
    }
    
}

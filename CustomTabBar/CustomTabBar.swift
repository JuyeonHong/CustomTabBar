//
//  CustomTabBar.swift
//  CustomTabBar
//
//  Created by 홍주연 on 01/09/2019.
//  Copyright © 2019 hongjuyeon. All rights reserved.
//

import Foundation

class CustomTabBar {
    let label: String
    let index: Int
    var isSelected: Bool
    
    init(label: String, index: Int, isSelected: Bool) {
        self.label = label
        self.index = index
        self.isSelected = isSelected
    }
}

class CustomTabBarManager{
    static func create() -> [CustomTabBar]{
        var tabBarArray: [CustomTabBar] = []
        
        let item1 = CustomTabBar.init(label: "Label1", index: 0, isSelected: true)
        let item2 = CustomTabBar.init(label: "Label2", index: 1, isSelected: false)
        let item3 = CustomTabBar.init(label: "Label3", index: 2, isSelected: false)
        
        tabBarArray.append(item1)
        tabBarArray.append(item2)
        tabBarArray.append(item3)
        
        return tabBarArray
    }
}

class DummyDataManager{
    static func create() -> [[String]]{
        var dataArray: [[String]] = []
        
        let item1 = ["Hi", "tableView", "swift", "collectionView", "Uikit"]
        let item2 = ["Gustav", "Klimt", "Italian", "Horticultural", "Landscape", "1913"]
        let item3 = ["Climb", "Bouldering Gym", "Trial", "Starter", "Block"]
        
        dataArray.append(item1)
        dataArray.append(item2)
        dataArray.append(item3)
        
        return dataArray
    }
}

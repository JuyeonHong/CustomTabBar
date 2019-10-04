//
//  ViewController.swift
//  CustomTabBar
//
//  Created by 홍주연 on 01/09/2019.
//  Copyright © 2019 hongjuyeon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tabBarCollectionView: UICollectionView!
    @IBOutlet weak var tabResultCollectionView: UICollectionView!
    
    var tabBarArray: [CustomTabBar]?
    var dataArray: [[String]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarArray = CustomTabBarManager.create()
        dataArray = DummyDataManager.create()
        
        let cellWidth = tabResultCollectionView.bounds.width
        let cellHeight = tabResultCollectionView.bounds.height
        
        if let layout = tabResultCollectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
            layout.minimumLineSpacing = 0
        }
        
        tabResultCollectionView.decelerationRate = UIScrollView.DecelerationRate.fast
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        configureCollectionViewLayoutItemSize()
    }
    
    private func configureCollectionViewLayoutItemSize() {
        if let layout = tabResultCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            layout.itemSize = CGSize(width: layout.collectionView?.frame.width ?? 414, height: layout.collectionView?.frame.height ?? 725)
        }
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == tabBarCollectionView{
            return CGSize(width: tabBarCollectionView.frame.width / 3, height: 57)
        }
        else if collectionView == tabResultCollectionView{
            return CGSize(width: tabResultCollectionView.frame.width, height: tabResultCollectionView.frame.height)
        }
        else {
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tabBarCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabBarCollectionViewCell", for: indexPath) as! TabBarCollectionViewCell
            cell.customTabBar = tabBarArray?[indexPath.row]
            cell.setUI()
            return cell
        }
        else if collectionView == tabResultCollectionView{
            let cell = tabResultCollectionView.dequeueReusableCell(withReuseIdentifier: "TabResultCollectionViewCell", for: indexPath) as! TabResultCollectionViewCell
            cell.dataArray = dataArray?[indexPath.row]
            return cell
            
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == tabBarCollectionView{
            tabResultCollectionView.scrollToItem(at: IndexPath(item: indexPath.row, section: 0), at: .centeredHorizontally, animated: true)
            
            tabBarArray?.forEach { $0.isSelected = false }
            tabBarArray?[indexPath.row].isSelected = true
            tabBarCollectionView.reloadData()
        }
    }
    
}

extension ViewController: UIScrollViewDelegate{
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if let layout = tabResultCollectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            // targetContentOffset: 스크롤 속도가 줄어들어 정지될 때 예상되는 위치
            let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
            var offset = targetContentOffset.pointee
            let pageIndex = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
            var roundedIndex = round(pageIndex)
            
            if scrollView.contentOffset.x > targetContentOffset.pointee.x {
                roundedIndex = floor(pageIndex)
            }
            else {
                roundedIndex = ceil(pageIndex)
            }
            
            offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: 0)
            targetContentOffset.pointee = offset
            
            tabBarArray?.forEach { $0.isSelected = false }
            tabBarArray?[Int(roundedIndex)].isSelected = true
            tabBarCollectionView.reloadData()
        }
    }
}

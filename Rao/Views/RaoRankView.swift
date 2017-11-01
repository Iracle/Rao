//
//  RaoRankView.swift
//  Rao
//
//  Created by Iracle Zhang on 8/27/16.
//  Copyright © 2016 Iracle. All rights reserved.
//

import UIKit

private let reuseIdentifier = "RaoRankCollectionViewCell"

protocol RaoRankViewDelegate {
    func raoRankViewDidSelectItemAt(rankView: RaoRankView, indexPath: NSIndexPath) -> Void
}

class RaoRankView: UIView {
    var raoRankList = [RaoRankInfo]()
    var delegate: RaoRankViewDelegate!
    
    //MARK: getter
    lazy var raoListView: UICollectionView = {
        let listView = UICollectionView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: rankHeight), collectionViewLayout: self.listViewLayout)
        listView.backgroundColor = UIColor.raoHomeListBackgroundColor()
        listView.showsHorizontalScrollIndicator = false
        listView.dataSource = self
        listView.delegate = self
        listView.register(RaoRankCollectionViewCell().classForCoder, forCellWithReuseIdentifier: reuseIdentifier)
        return listView
    }()
    
    lazy var listViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: screenWidth*0.5, height: rankHeight*0.68)
        layout.minimumLineSpacing = raoListTopOffset
        layout.minimumInteritemSpacing = 14.0
        return layout
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.yellow
        self.addSubview(raoListView)
        loadRankData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadRankData() {
        for index in 1 ... 6 {
            let raoInfo = RaoRankInfo(groupPriority: String(index), rankDescription: "从心所欲，是谓无距")
            raoRankList.append(raoInfo)
        }
        raoListView.reloadData()
    }
    
    func scrollAnimation()  {
        print(raoListView.contentSize.width - screenWidth)
        let contentOffset  = (self.raoListView.contentSize.width - screenWidth)/2
        delay(0.35) {
            UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: UIViewAnimationOptions(), animations: {
                self.raoListView.setContentOffset(CGPoint(x: (contentOffset + screenWidth/4 + 7.0), y: 0.0), animated: false)
                }, completion: nil)
        }
    }
}

extension RaoRankView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return raoRankList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RaoRankCollectionViewCell
        cell.raoRankInfo = raoRankList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.raoRankViewDidSelectItemAt(rankView: self, indexPath: indexPath as NSIndexPath)
    }
    
}













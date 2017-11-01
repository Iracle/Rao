//
//  RaoListViewController.swift
//  Rao
//
//  Created by Iracle Zhang on 6/24/16.
//  Copyright © 2016 Iracle. All rights reserved.
//

import UIKit
import SnapKit
import RealmSwift

let listViewCellWitdh = screenWidth - 28.0
let listViewCellHeight: CGFloat = 112.0

private let reuseIdentifier = "RaoListCollectionViewCell"
private let raoContentViewMaxSpeed: CGFloat = 30.0
let menuBgViewHeight: CGFloat = 75.0
let raoListTopOffset: CGFloat = 18.0

class RaoListViewController: UIViewController {
    var raoList = [RaoKouLingInfo]()
    
    var zoomAnimation = Spring(value:raoListCellFrame)
    var springConfig  = SpringConfiguration()
    var centerAnimation = Animatable(value:UIScreen.main.bounds.origin.y)
    var seletedCellY:CGFloat!
    var raoListOffsetY: CGFloat!
    var scrollViewOffestY: CGFloat!
    var raoKouLingInfo: RaoKouLingInfo!
    let realm = try! Realm()
    var isFavorite: Bool = false
    
    
    //MARK: getter
    lazy var raoListView: UICollectionView = {
        let listView = UICollectionView(frame: self.view.bounds, collectionViewLayout: self.listViewLayout)
        listView.backgroundColor = UIColor.raoHomeListBackgroundColor()
        listView.showsVerticalScrollIndicator = false
        listView.contentInset = UIEdgeInsetsMake(raoListTopOffset, 14.0, 0.0, 14.0)
        listView.alwaysBounceVertical = true
        listView.dataSource = self
        listView.delegate = self
        listView.register(RaoListCollectionViewCell().classForCoder, forCellWithReuseIdentifier: reuseIdentifier)
        return listView
    }()
    
    lazy var listViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: listViewCellWitdh, height: listViewCellHeight)
        layout.minimumLineSpacing = raoListTopOffset
        layout.minimumInteritemSpacing = 14.0
        return layout
    }()
    
    lazy var raoContentView: RaoContentView = {
        let aView = RaoContentView()
        return aView
    }()
    
    lazy var bgView: UIView = {
        let aView = UIView(frame: self.view.bounds)
        aView.backgroundColor = UIColor.white
        return aView
    }()
    
    
    var blurEffect = UIBlurEffect(style: .light)
    
    lazy var blurEffectView: UIVisualEffectView = {
        let effectView = UIVisualEffectView(effect: self.blurEffect)
        effectView.frame = self.view.bounds
        effectView.isHidden = true
        return effectView
    }()
    
    lazy var favoriteView: UILabel = {
        let label = UILabel()
        label.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
        label.center = CGPoint(x: screenMidX, y: (screenHight - screenWidth)/4)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 46)
        label.text = "♥"
        label.textColor = UIColor.red
        label.alpha = 0.0
        return label
        
    }()
    
    lazy var menuBgView: RaoMenuBgView = {
       let view = RaoMenuBgView(frame: CGRect(x: 0, y: -menuBgViewHeight, width: screenWidth, height: menuBgViewHeight))
       return view
    }()
    
    lazy var bgScrollView: UITableView = {
        let s = UITableView(frame: UIScreen.main.bounds)
        s.delegate = self
        s.backgroundColor = UIColor.raoHomeListBackgroundColor()
        s.separatorStyle = .none
        return s
    }()
    
    lazy var rankView: RaoRankView = {
        let r = RaoRankView()
        r.delegate = self
        r.center = self.view.center
        r.bounds = CGRect(x: 0.0, y: 0.0, width: screenWidth, height: rankHeight)
        return r
    }()
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        view.addSubview(bgView)
        bgView.addSubview(raoListView)
        view.addSubview(blurEffectView)
        view.addSubview(raoContentView)
        view.addSubview(menuBgView)
        //rank
        view.addSubview(bgScrollView)
        bgScrollView.addSubview(rankView)
        bgScrollView.isHidden = true
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(raoContentViewTaped))
        raoContentView.addGestureRecognizer(tapGes)
        let panGes = UIPanGestureRecognizer(target: self, action: #selector(raoContentViewPaned))
        raoContentView.addGestureRecognizer(panGes)
        raoContentView.isUserInteractionEnabled = false
        
        loadRaoList(sql: sql_allRecord)
        
        springConfig.tension = 70.0
        springConfig.damping = 15.0
        zoomAnimation.configuration = springConfig
        zoomAnimation.changed.observe { [unowned self] (value) in
            self.raoContentView.bounds = value
            //update rao content view subview
            if value.size.height >= screenWidth*0.7 && value.size.height <= screenWidth*0.85{
                self.raoContentView.showSubViews()
                self.raoContentView.setupLayout()
            }
            if value.size.height <= screenWidth*0.8 {
                self.raoContentView.hiddenSubViews()
                
            }
        }

        centerAnimation.changed.observe { [unowned self] (value) in
            self.raoContentView.center.y = value
        }
        
    }

    override var prefersStatusBarHidden : Bool {
        return true
        
    }
    
    func loadRaoList(sql: String) {
        raoList = DBHelper.shareInstance.recordSetQuery(sql)

        DBHelper.shareInstance.closeDb()
        raoListView.reloadData()        
    }
    
    @objc func raoContentViewTaped() {

    }
    
    @objc  func raoContentViewPaned(_ gesture: UIPanGestureRecognizer) {
        let translate = gesture.translation(in: view)
        let positionY = (gesture.view?.center.y)! + translate.y
        gesture.view?.center = CGPoint(x: view.center.x, y: positionY)
        gesture.setTranslation(CGPoint.zero, in: view)

        let favoriteViewY = favoriteView.frame.origin.y
        let raoContentViewY = raoContentView.frame.origin.y
        let percentOffset: CGFloat = favoriteViewY/raoContentViewY
        favoriteView.alpha = percentOffset
//        print(percentOffset)
        if gesture.state == .ended {
            
            if raoContentViewY > favoriteViewY {
                centerAnimation.value = positionY
                centerAnimation.animate(screenHight/2, duration: 0.5, timingFunction: UnitBezier.init(preset: .easeInEaseOut))
            }
            //pan up
            if percentOffset >= 1 || percentOffset <= 0{
                dismissRaoContentView(true)
            }
            //pan down
            if percentOffset <= 0.2 && percentOffset >= 0.0 {
                dismissRaoContentView(false)
            }
        }
        
    }
    
    func dismissRaoContentView(_ direction: Bool) {
        centerAnimation.value = self.raoContentView.center.y
        let fleeDistance: CGFloat = direction == true ? -screenWidth : screenHight+screenWidth/2

        centerAnimation.animate(fleeDistance, duration: 0.35, timingFunction: UnitBezier.init(preset: .easeInEaseOut)) { (finished) in
            self.raoContentView.isUserInteractionEnabled = true
        }

        //1.blurEffectView alpha
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions(), animations: {
            self.blurEffectView.alpha = 0.0
        }) { (filished) in
            
            self.blurEffectView.isHidden = true
            self.raoContentView.isUserInteractionEnabled = false
            self.favoriteView.alpha = 0.0
        }
        
        //2.bgView scale
        UIView.animate(withDuration: 0.6, delay: 0.15, options: UIViewAnimationOptions(), animations: {
            self.bgView.transform = CGAffineTransform.identity
        }) { (filished) in
            
        }
        //add favorite or delete
        guard direction == true else {return}
        switch menuBgView.currentItem.rawValue {
        case -1:
            if  isFavorite == false {
                print("add favorite")
//                let aRaokouLing = RaoKouLingEntity(value: [raoKouLingInfo.groupPriority, raoKouLingInfo.title, raoKouLingInfo.content])
                try! realm.write {
                    realm.create(RaoKouLingEntity.self, value:  [raoKouLingInfo.groupPriority, raoKouLingInfo.title, raoKouLingInfo.content], update: true)
                }
                print(realm.configuration.fileURL ?? "no path")
            } else {
                print("delete favorite")
                let row = raoList.index(of: raoKouLingInfo)
                raoList.removeObject(object: raoKouLingInfo)
                delay(0.8, completion: {
                    let indexPath = IndexPath(row: row!, section: 0)
                    self.raoListView.deleteItems(at: [indexPath])
                })

                let raoTitle = raoKouLingInfo.title!
                let raoItem = realm.objects(RaoKouLingEntity.self).filter("title = '\(raoTitle)'")
                try! realm.write {
                    realm.delete(raoItem)
                }
                
            }
            break
          default:
            break
        }
    }
}

extension RaoListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return raoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RaoListCollectionViewCell
        cell.raoCellInfo = raoList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //2.blurEffectView alpha
        self.blurEffectView.alpha = 0.0
        UIView.animate(withDuration: 0.6, delay: 0.15, options: UIViewAnimationOptions(), animations: {
            self.blurEffectView.isHidden = false
            self.blurEffectView.alpha = 1.0
            }) { (filished) in
//                self.blurEffectView.addSubview(self.favoriteView)
        }
        //1.bgView scale
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions(), animations: {
             self.bgView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }) { (filished) in
                
        }
        
        let cell = collectionView.cellForItem(at: indexPath)!
        let raoFrame = collectionView.convert(cell.frame, to: view)
        raoContentView.frame = raoFrame
        raoContentView.alpha = 1.0
        zoomAnimation.reset(raoListCellFrame)
        delay(0.5) {
             self.zoomAnimation.target = squareFrame
        }
        //1.raoContentView position
        seletedCellY = raoFrame.origin.y + raoFrame.size.height/2
        centerAnimation.value = seletedCellY
        centerAnimation.animate(screenHight/2, duration: 0.35, timingFunction: UnitBezier.init(preset: .easeInEaseOut)) { (finished) in
             self.raoContentView.isUserInteractionEnabled = true
        }
        //1.raoContentView cornerRadius
        _ = 5.0.animate(0.0, duration: 0.5, timingFunction:  UnitBezier.init(preset: .easeInEaseOut)) { [unowned self] (value) in
            self.raoContentView.layer.cornerRadius = CGFloat(value)

            }
        let raoCellInfo = raoList[indexPath.row]
        raoKouLingInfo = raoCellInfo
        raoContentView.raoPriorityLogo.image = UIImage(named: "groupPriority_\(raoCellInfo.groupPriority!)")
        raoContentView.raoContent.attributedText = String.raoAttributedString(raoCellInfo.content, alignment: .center)
        raoContentView.raoTitle.text = raoCellInfo.title
    }
    
}

extension RaoListViewController: UIScrollViewDelegate, UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        scrollViewOffestY = scrollView.contentOffset.y
        guard scrollViewOffestY <= 0 else { menuBgView.frame.origin.y = -menuBgViewHeight; return}
        
        raoListOffsetY = abs(scrollViewOffestY) - raoListTopOffset
        let menuBgViewY = raoListOffsetY - menuBgViewHeight
        if menuBgViewY >= 0.0 {

            menuBgView.animationOffset = menuBgViewY
        }
        guard menuBgViewY <= 0 else { menuBgView.frame.origin.y = 0.0; return}
        menuBgView.frame.origin.y = menuBgViewY
        //increase user experience
        if abs(menuBgViewY) > 15 {
            menuBgView.currentItem = .begin
        } else {
            menuBgView.currentItem = .random
        }
        print(menuBgViewY)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard scrollViewOffestY <= -raoListTopOffset else {return}
        _ = scrollViewOffestY.animate(-raoListTopOffset, duration: 0.6, timingFunction: UnitBezier.init(preset: .easeInEaseOut)) { (value) in
            scrollView.contentOffset.y = value
        }
        
        switch menuBgView.currentItem.rawValue {
        case 0:
            loadRaoList(sql: sql_allRecord)
            bgScrollView.isHidden = true
            raoListView.isHidden = false
            isFavorite = false
            favoriteView.text = "♥"
            break
        case 1:
            raoListView.isHidden = true
            bgScrollView.isHidden = false
            rankView.scrollAnimation()
            isFavorite = false
            favoriteView.text = "♥"
            break
        case 2:
            let raokouLingItems: Results<RaoKouLingEntity> = realm.objects(RaoKouLingEntity.self)
            raoList.removeAll()
            for raokouling in raokouLingItems {
                let rao = RaoKouLingInfo(groupPriority: raokouling.groupPriority, title: raokouling.title, content: raokouling.content)
                raoList.append(rao)
            }
//            print(raoList)
            bgScrollView.isHidden = true
            raoListView.isHidden = false
            self.raoListView.reloadData()
            isFavorite = true
            favoriteView.text = "♡"
            break
        default:
            break
        }
         view.bringSubview(toFront: menuBgView)
    }
}

extension RaoListViewController: RaoRankViewDelegate {
    func raoRankViewDidSelectItemAt(rankView: RaoRankView, indexPath: NSIndexPath) {
       loadRaoList(sql: "\(sql_seletedRecord)\(indexPath.row+1)")
//        loadRaoList(sql: sql_allRecord)
        bgScrollView.isHidden = true
        raoListView.isHidden = false
        view.bringSubview(toFront: menuBgView)

    }
}

extension Array where Element: Equatable
{
    mutating func removeObject(object: Element) {
        
        if let index = index(of: object) {
            remove(at: index)
        }
    }
}







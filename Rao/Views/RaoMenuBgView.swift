//
//  RaoMenuBgView.swift
//  Rao
//
//  Created by Iracle Zhang on 8/9/16.
//  Copyright © 2016 Iracle. All rights reserved.
//

import UIKit

enum MenuItemType: Int {
    case begin = -1
    case random = 0
    case rank = 1
    case favorite = 2
}

private let animationViewMargin: CGFloat = 10.0
private let animationViewWidth = sectionItemWidth - animationViewMargin * 2.0
private let baseTag = 300
class RaoMenuBgView: UIView {
    
    let sectionTitles = ["随机", "等级", "收藏"]
    var currentItem: MenuItemType!
    
    var animationOffset: CGFloat!  {
        didSet {
//            print(animationOffset)
            let animationViewX = animationOffset*9.0 + 10.0
            
            let random: UIView = self.viewWithTag(baseTag)!
            let rank: UIView = self.viewWithTag(baseTag + 1)!
            let favorite: UIView = self.viewWithTag(baseTag + 2)!
            
            if animationViewX >= (random.frame.minX + 20) && animationViewX <=  random.frame.maxX{
                currentItem = .random
                changeAnimationViewPosition(random.center)
//                print("1")
            }
            
            if animationViewX >= rank.frame.minX && animationViewX <=  rank.frame.maxX{
              
                currentItem = .rank
                changeAnimationViewPosition(rank.center)
//                 print("2")
            }
            
            if animationViewX >= favorite.frame.minX{
              
                currentItem = .favorite
                changeAnimationViewPosition(favorite.center)
//                print("3")
            }
        }
    }
    
    //MARK: getter
    var animationView: UIView = {
        let view = UIView(frame: CGRect(x: animationViewMargin, y: 15.0, width: animationViewWidth, height: 45.0))
        view.backgroundColor = UIColor.cyan
        view.layer.cornerRadius = 20.0
        view.alpha = 0.3
        return view
    }()
    
    required init(coder aDecoder: NSCoder) {
        fatalError("")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        currentItem = .begin
    }
    
    func setupUI() {
        self.backgroundColor = UIColor.yellow
        for index in 0 ..< 3 {
            let label = UILabel(frame: CGRect(x: sectionItemWidth*CGFloat(index), y: 0.0, width:sectionItemWidth, height:menuBgViewHeight))
            label.tag = baseTag + index
            label.text = sectionTitles[index]
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 19)
            label.backgroundColor = UIColor.white
            self.addSubview(label)
        }
        
        self.addSubview(animationView)
    }
    
    func changeAnimationViewPosition(_ center: CGPoint)  {
        UIView.animate(withDuration: 0.25, animations: { 
            self.animationView.center = center
        }) 
    }
}









//
//  RaoContentView.swift
//  Rao
//
//  Created by Iracle Zhang on 8/1/16.
//  Copyright © 2016 Iracle. All rights reserved.
//

import UIKit
import SnapKit
//import Advance

class RaoContentView: UIView {
    fileprivate var didSetupConstraints = false
    //MARK:getter
    lazy var raoPriorityLogo: UIImageView = {
        let imageView = UIImageView()
//        imageView.backgroundColor = UIColor ( red: 0.7893, green: 1.0, blue: 0.8972, alpha: 0.318755278716216 )
        return imageView
    }()
    
    lazy var raoTitle: UILabel = {
        let label = UILabel()
//        label.backgroundColor = UIColor ( red: 0.7893, green: 1.0, blue: 0.8972, alpha: 0.318755278716216 )
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 22.0)
        label.textColor = UIColor.raoTitleColor()
        return label
    }()
    
    lazy var raoContent: UILabel = {
        let label = UILabel()
//        label.backgroundColor = UIColor ( red: 0.7893, green: 1.0, blue: 0.8972, alpha: 0.318755278716216 )
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = UIColor.raoContent()
        label.numberOfLines = 0
        return label
    }()

    required init(coder aDecoder: NSCoder) {
        fatalError("")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.height, height: frame.size.width)
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 5.0
        self.layer.shadowColor = UIColor.raoContentViewshadowColor()
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        
        self.addSubview(raoContent)
        self.addSubview(raoTitle)
        self.addSubview(raoPriorityLogo)
        
        self.setNeedsUpdateConstraints()
    }
    
    func setupLayout() {

        raoContent.snp.updateConstraints { (make) in
            _ = make.center.equalTo(self)
            _ = make.left.equalTo(self).offset(20)
            _ = make.right.equalTo(self).offset(-20)
            _ = make.top.greaterThanOrEqualTo(self).offset(100.0)
            _ = make.bottom.greaterThanOrEqualTo(self).offset(-85.0)
        }
        
        raoTitle.snp.updateConstraints { (make) in
            _ = make.left.equalTo(self).offset(50.0)
            _ = make.right.equalTo(self).offset(-50.0)
            _ = make.top.lessThanOrEqualTo(self.snp.top).offset(50.0)
            _ = make.height.equalTo(30)
            
        }
        
        raoPriorityLogo.snp.updateConstraints { (make) in
            
            _ = make.size.equalTo(CGSize(width: 47.0*0.7, height: 71.0*0.7))
            _ = make.centerX.equalTo(self)
            _ = make.bottom.lessThanOrEqualTo(self.snp.bottom).offset(-15.0)
        }
        
        _ = 0.0.animate(1.0, duration: 1.0, timingFunction:  UnitBezier.init(preset: .easeInEaseOut)) {(value) in
            self.raoContent.alpha = CGFloat(value)
            self.raoTitle.alpha = CGFloat(value)
            self.raoPriorityLogo.alpha = CGFloat(value)
        }

    }
    
    func hiddenSubViews() {
        raoContent.isHidden = true
        raoTitle.isHidden = true
        raoPriorityLogo.isHidden = true
    }
    
    func showSubViews() {
        raoContent.isHidden = false
        raoTitle.isHidden = false
        raoPriorityLogo.isHidden = false
    }

    override func updateConstraints() {
        
        super.updateConstraints()
    }
}

















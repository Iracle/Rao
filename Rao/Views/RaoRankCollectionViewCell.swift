//
//  RaoRankCollectionViewCell.swift
//  Rao
//
//  Created by Iracle Zhang on 8/27/16.
//  Copyright © 2016 Iracle. All rights reserved.
//

import UIKit
import SnapKit

class RaoRankCollectionViewCell: UICollectionViewCell {
    
    fileprivate var didSetupConstraints = false
    
    //MARK:getter
    lazy var raoPriorityLogo: UIImageView = {
        let imageView = UIImageView()
//        imageView.backgroundColor = UIColor.redColor()
        return imageView
    }()
    
    lazy var rankDescription: UILabel = {
        let label = UILabel()
//        label.backgroundColor = UIColor.redColor()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = UIColor.raoTitleColor()
        return label
    }()
    
    lazy var cornerRadiusLayer: CALayer = {
        let layer = CALayer()
        layer.frame = self.layer.bounds
        layer.backgroundColor = UIColor.white.cgColor
        layer.masksToBounds = true
        layer.cornerRadius = 5.0
        return layer
    }()
    
    var raoRankInfo: RaoRankInfo! {
        didSet {
            raoPriorityLogo.image = UIImage(named: "groupPriority_\(raoRankInfo.groupPriority!)")
            rankDescription.text = raoRankInfo.rankDescription
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.layer.addSublayer(cornerRadiusLayer)
        
        layer.shadowColor = UIColor.raoContentViewshadowColor()
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 1.0
        layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
        
        contentView.addSubview(raoPriorityLogo)
        contentView.addSubview(rankDescription)
        self.setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        
        if !didSetupConstraints {
            raoPriorityLogo.snp.makeConstraints { (make) -> Void in
                _ = make.center.equalTo(self.snp.center)
                _ = make.size.equalTo(CGSize(width: 78.0, height: 142.0))
            }
            rankDescription.snp.makeConstraints { (make) in
                _ = make.left.equalTo(self.snp.left).offset(15.0)
                _ = make.right.equalTo(self.snp.right).offset(-15.0)
                _ = make.height.equalTo(18.0)
                _ = make.bottom.equalTo(self.snp.bottom).offset(-20.0)
            }
            
            didSetupConstraints = true
        }
        super.updateConstraints()
        
        
    }

    
}







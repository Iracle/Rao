//
//  RaoListCollectionViewCell.swift
//  Rao
//
//  Created by Iracle Zhang on 6/17/16.
//  Copyright © 2016 Iracle. All rights reserved.
//

import UIKit
import SnapKit

class RaoListCollectionViewCell: UICollectionViewCell {

   var didSetupConstraints = false
   let raoContentLimitNumber = 28
    
    //MARK:getter
    lazy var raoPriorityLogo: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var raoTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17.0)
        label.textColor = UIColor.raoTitleColor()
        return label
    }()
    
    lazy var raoContent: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.textColor = UIColor.raoContent()
        label.numberOfLines = 0
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
    
    
   override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var raoCellInfo: RaoKouLingInfo! {
        didSet {
            raoTitle.text = raoCellInfo.title
            raoPriorityLogo.image = UIImage(named: "groupPriority_\(raoCellInfo.groupPriority!)")
            var currentRaoContent = ""
            if raoCellInfo.content.count >= raoContentLimitNumber {
                let offset = 28
                currentRaoContent = String(raoCellInfo.content.prefix(offset))
            } else {
                currentRaoContent = raoCellInfo.content
            }
            
            raoContent.attributedText = String.raoAttributedString(currentRaoContent, alignment: .center);
        
        }
    }
    
    func setupUI() {
        contentView.layer.addSublayer(cornerRadiusLayer)
        contentView.addSubview(raoPriorityLogo)
        contentView.addSubview(raoTitle)
        contentView.addSubview(raoContent)
        
        layer.shadowColor = UIColor.raoContentViewshadowColor()
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 1.0
        layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
        
        self.setNeedsUpdateConstraints()
    }
    override func updateConstraints() {
        
        if !didSetupConstraints {
    
            raoPriorityLogo.snp.makeConstraints { (make) -> Void in
                _ = make.centerY.equalTo(contentView)
                _ = make.leading.equalTo(20.0)
                _ = make.size.equalTo(CGSize(width: 49.0, height: 71.0))
            }
            
            raoTitle.snp.makeConstraints { (make) in
                _ = make.top.equalTo(raoPriorityLogo.snp.top)
                _ = make.left.equalTo(raoPriorityLogo.snp.right).offset(25.0)
                _ = make.right.equalTo(contentView).offset(-25.0)
                _ = make.height.equalTo(26.0)
            }
            
            raoContent.snp.makeConstraints { (make) in
                _ = make.left.equalTo(raoTitle.snp.left).offset(10.0)
                _ = make.right.equalTo(raoTitle.snp.right).offset(-5.0)
                _ = make.top.equalTo(raoTitle.snp.bottom).offset(10.0)
                _ = make.bottom.equalTo(raoPriorityLogo.snp.bottom)
            }
            
            didSetupConstraints = true
        }
        super.updateConstraints()
        

    }
    
}









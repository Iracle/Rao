//
//  ZhControlMakeHelper.swift
//  SwiftDemo
//
//  Created by Iracle Zhang on 2/19/16.
//  Copyright © 2016 Iracle Zhang. All rights reserved.
//

import Foundation
import UIKit


let screenWidth = UIScreen.main.bounds.size.width
let screenHight = UIScreen.main.bounds.size.height
let screenMidX = UIScreen.main.bounds.midX
let screenMidY = UIScreen.main.bounds.midY
let squareFrame = CGRect(x: 0, y: 0, width: screenWidth, height: screenWidth)
let raoListCellFrame = CGRect(x: 0, y: 0, width: listViewCellWitdh, height: listViewCellHeight)
let sectionItemWidth =  screenWidth/3

let rankHeight = screenHight*0.7



//MARK: UIView
func zhView(_ frame: CGRect, backgroundColor: UIColor, cornerRadius: CGFloat) ->UIView {
    let v = UIView(frame: CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: frame.size.height))
    v.backgroundColor = backgroundColor
    v.layer.cornerRadius = cornerRadius
    return v
    
}

//MARK: UIButton
class MyButton: UIButton {
    var onClick: (_ sender: UIButton) -> () = { _ in () }
    @objc func tapped(_ sender: UIButton) {
        onClick(self)
    }
}

func zhButton(_ text: String, frame: CGRect, onClick: @escaping (_ sender: UIButton) -> ()) -> UIButton {
    let b = MyButton(type: .system)
    b.isUserInteractionEnabled = true
    b.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: frame.size.height)
    b.setTitle(text, for: UIControlState())
    b.addTarget(b, action: #selector(MyButton.tapped(_:)), for: UIControlEvents.touchUpInside)
    b.onClick = onClick
    return b
}

//MARK: UILabel
func zhLabel(_ text: String, frame: CGRect, backgroundColor: UIColor, font: CGFloat) -> UILabel {
    let l = UILabel(frame: CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: frame.size.height))
    l.text = text
    l.backgroundColor = backgroundColor
    l.font = UIFont.systemFont(ofSize: font)
    l.textAlignment = .center
    l.numberOfLines = 0
    return l
}

//MARK: UITextField
func zhTextField(_ placeholder: String, frame: CGRect, borderStyle: UITextBorderStyle) -> UITextField {
    let t = UITextField(frame: CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: frame.size.height))
    t.placeholder = placeholder
    t.borderStyle = borderStyle
    return t
}

//MARK: UIImageView
func zhImageView(_ name: String, frame: CGRect, backgroundColor: UIColor) -> UIImageView {
    let i = UIImageView(frame: CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: frame.size.height))
    i.image = UIImage(named: name)
    i.backgroundColor = backgroundColor
    return i
}

//MARK: UISlider
func zhSlider(_ frame: CGRect, minimumValue: Float, maximumValue: Float, value: Float) -> UISlider {
    let s = UISlider(frame: CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: frame.size.height))
    s.minimumValue = minimumValue
    s.maximumValue = maximumValue
    s.value = value
    return s
}
//MARK: Auto dismiss alert
func alert(_ title: String, message: String?, inViewController viewController: UIViewController?) {
    
    DispatchQueue.main.async {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        viewController?.present(alertController, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double((Int64)(1 * NSEC_PER_SEC)) / Double(NSEC_PER_SEC)){() -> Void in
            viewController!.dismiss(animated: true, completion: nil)
        };
    }
}


func delay(_ seconds: Double, completion:@escaping ()->()) {
  let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * seconds )) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline: popTime) {
        completion()
  }
}
















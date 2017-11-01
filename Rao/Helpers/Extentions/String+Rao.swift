//
//  String+Rao.swift
//  Rao
//
//  Created by Iracle Zhang on 8/3/16.
//  Copyright © 2016 Iracle. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    static func raoAttributedString(_ content: String, alignment: NSTextAlignment) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: content)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        paragraphStyle.alignment = alignment
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        return attributedString
    }
    
}

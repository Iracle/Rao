//
//  UIColor+Rao.swift
//  Rao
//
//  Created by Iracle Zhang on 6/23/16.
//  Copyright © 2016 Iracle. All rights reserved.
//

import UIKit

extension UIColor {
    class func raoHomeListBackgroundColor() -> UIColor {
        return UIColor ( red: 0.9852, green: 0.9851, blue: 0.9852, alpha: 1.0 )
    }
    
    class func raoHomeListCellBackgroundColor() -> UIColor {
        return UIColor.white
    }
    
    class func raoTitleColor() -> UIColor {
        return UIColor ( red: 0.2151, green: 0.2151, blue: 0.2151, alpha: 1.0 )
    }
    
    class func raoContent() -> UIColor {
        return UIColor ( red: 0.2842, green: 0.2842, blue: 0.2842, alpha: 1.0 )
    }
    
    class func raoContentViewshadowColor() -> CGColor {
        return UIColor( red: 0.8614, green: 0.8614, blue: 0.8614, alpha: 1.0 ).cgColor
    }
    
}

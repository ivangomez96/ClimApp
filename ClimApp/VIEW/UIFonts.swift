//
//  UIFonts.swift
//  ClimApp
//
//  Created by Ivan on 17/11/2020.
//  Copyright © 2020 Ivan. All rights reserved.
//

import UIKit

extension UIFont {

    class var headerFont: UIFont {
        return UIFont.systemFont(ofSize: 17, weight: .semibold)
    }
    
    class var captionFont: UIFont {
        return UIFont.systemFont(ofSize: 11, weight: .regular)
    }
    
    class var tagFont: UIFont {
        return UIFont.systemFont(ofSize: 34, weight: .bold)
    }
    
    class var bodyFont: UIFont {
        return UIFont.systemFont(ofSize: 11, weight: .regular)
    }
    
}

//
//  Extensions.swift
//  MagmaExcercise
//
//  Created by Aldo Bonilla on 19/04/17.
//  Copyright © 2017 Aldo Bonilla. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    
    ///Obtains a viewcontroller from a storyboard
    class func getStoryboardViewController(storyboard: String, identifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
}


extension UILabel {
    
    //Enum to define label styles
    enum LabelStyle {
        case Title
        case Detail
        case SmallText
        case CellTitle
        case CellDetail
        
        var font: UIFont {
            switch self {
            case .Title:
                return FontMedium16
            case .Detail:
                return FontMedium14
            case .SmallText:
                return FontMedium12
            case .CellTitle:
                return FontBold16
            case .CellDetail:
                return FontRegular12
            }
        }
        
        var color: UIColor {
            switch self {
            case .Title, .CellTitle:
                return UIColor.darkText
            case .Detail, .SmallText, .CellDetail:
                return UIColor.gray
            }
        }
        
        var noLines: Int {
            switch self {
            case .Title, .CellTitle:
                return 1
            case .Detail, .SmallText, .CellDetail:
                return 0
            }
        }
    }
    
    ///Styles the label with predefined fonts
    func styleWithText(_ text: String?, labelStyle: LabelStyle, aligment: NSTextAlignment) {
        font = labelStyle.font
        textColor = labelStyle.color
        numberOfLines = labelStyle.noLines
        self.text = text
    }
}

extension Date {
    
    func convertToStringWithFormat(_ format: String? = nil) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format ?? "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: self)
    }
    
    static func convertFromString(_ string: String, format: String? = nil) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format ?? "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter.date(from: string)
    }
}

//
//  LocalizationFile.swift
//  DexgoHousekeeping
//
//  Created by Apple on 13/07/22.
//

import Foundation

import UIKit

private let appleLanguagesKey = "AppleLanguages"
private var bundleKey: UInt8  = 0

enum Localization: String {
    
    case english    = "en"
    case arabic     = "ar"
    case hindi      = "hi"
    case spanish    = "es"
    
    var semantic: UISemanticContentAttribute {
        switch self {
        case .arabic:
            return .forceRightToLeft
        default:
            return .forceLeftToRight
        }
    }
  

}
//===========================================================
//MARK: - String  Extension
//===========================================================
extension String {
    
    var localized: String {
        return CustomLanguageBundle.main.localizedString(forKey: self, value: nil, table: nil)
    }
//    var localizable: String {
//        return Bundle.localizedBundle.localizedString(forKey: self, value: nil, table: nil)
//    }
    var localizedImage: UIImage? {
        return localizedImage()
            ?? localizedImage(".png")
            ?? localizedImage(".jpg")
            ?? localizedImage(".jpeg")
            ?? UIImage(named: self)
    }
    
    private func localizedImage(_ type: String = "") -> UIImage? {
        guard let imagePath = CustomLanguageBundle.main.path(forResource: self, ofType: type) else {
            return nil
        }
        return UIImage(contentsOfFile: imagePath)
    }
}
//===========================================================
//MARK: - Bundle  Extension
//===========================================================
class CustomLanguageBundle: Bundle {
    override func localizedString(forKey key: String,
                                  value: String?,
                                  table tableName: String?) -> String {
        guard let path = objc_getAssociatedObject(self, &bundleKey) as? String,
            let bundle = Bundle(path: path) else {
                return super.localizedString(forKey: key, value: value, table: tableName)
        }
        return bundle.localizedString(forKey: key, value: value, table: tableName)
    }
}
extension Bundle {
    class func setLanguage(_ language: String) {
        defer {
            object_setClass(Bundle.main, CustomLanguageBundle.self)
        }
        objc_setAssociatedObject(Bundle.main, &bundleKey,Bundle.main.path(forResource: language, ofType: "lproj"), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}

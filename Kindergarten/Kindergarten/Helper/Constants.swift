//
//  Constants.swift
//  Kindergarten
//
//  Created by Sandeep Vinay on 10/09/23.
//

import Foundation

class Constants {
    
    // userdefault keys
    enum kUserDefaultsKey: String {
        case eLanguageSelection = "LanguageSelection"
    }
    
    // userdefault keys
    enum kLanguageKey: String {
        case eEnglish = "en"
        case eSpanish = "es"
    }
    
    // segue keys
    enum kSegueKey: String {
        case eShowClassify = "showClassify"
        case eShowClassifyItem = "showClassifyItem"
        case eShowDifference = "showDifference"
        case eShowDifferenceItem = "showDifferenceItem"
    }
}

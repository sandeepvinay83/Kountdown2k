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
        case eUsername = "Username"
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
        case eShowBasicColors = "showBasicColors"
        case eShowIdentifyShape = "showIdentifyShape"
        case eShowCountSets = "showCountSets"
        case eShowAddition = "showAddition"
        case eShowHome = "showHome"
        case eShowSignup = "showSignup"
        case eShowProfile = "showProfile"
    }
    
    // Alert button title English
    enum kAlertButtonTitleKey_English: String {
        case eYes = "Yes"
        case eNo = "No"
        case eOk = "Ok"
    }
    
    // Alert button title Spanish
    enum kAlertButtonTitleKey_Spanish: String {
        case eYes = "Sí"
        case eNo = "No"
        case eOk = "De acuerdo"
    }
}

//
//  OverrideExtensions.swift
//  Kindergarten
//
//  Created by Sandeep Vinay on 10/09/23.
//

import UIKit

extension UINavigationItem {
    /// Adds the segmented control to navigation item
    /// - Parameters:
    ///   - target: target file to execute the action
    ///   - selector: action method
    func addLanguageSegmentedControl(target: Any, selector: Selector) {
        let languageSegmentedControl = UISegmentedControl (items: [Constants.kLanguageKey.eEnglish.rawValue,Constants.kLanguageKey.eSpanish.rawValue])
        languageSegmentedControl.selectedSegmentIndex = 0
        languageSegmentedControl.addTarget(target, action: selector, for: .valueChanged)
        let segmentBarItem = UIBarButtonItem(customView: languageSegmentedControl)
        rightBarButtonItem = segmentBarItem
    }
    
    /// Adding profile icon
    func addProfileButton(target: Any, selector: Selector?) {
        self.hidesBackButton = true
        let backImage : UIImage? = UIImage.init(named: "profile")?.withRenderingMode(.alwaysTemplate)
        let newBackButton = UIBarButtonItem(image: backImage, style: UIBarButtonItem.Style.plain, target: target, action: selector)
        newBackButton.tintColor = UIColor.lightGray
        self.leftBarButtonItem = newBackButton
    }
}

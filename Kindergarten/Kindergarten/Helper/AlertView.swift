//
//  AlertView.swift
//  Kindergarten
//

import UIKit

final class AlertView: UIAlertController {
    
    /// To show alert view with message
    ///
    /// - Parameters:
    ///   - controller: parent controller
    ///   - title: title of the alert view
    ///   - message: message of the alert view
    func showAlertView(controller: UIViewController, title: String, message: String, okButtonTitle: String? = nil, cancelButtonTitle: String? = nil, handler: ((UIAlertAction) -> Void)? = nil) {
        let stringAttributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize:16.0)]
        let alertMessage = NSMutableAttributedString(string: message, attributes: stringAttributes)
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertView.setValue(alertMessage, forKey: "attributedMessage")
        let obButton = UIAlertAction(title: okButtonTitle ?? "Ok", style: .default, handler: handler)
        alertView.addAction(obButton)
        if let cancelButtonTitle = cancelButtonTitle {
            let cancelButton = UIAlertAction(title: cancelButtonTitle, style: .default, handler: handler)
            alertView.addAction(cancelButton)
        }
        controller.present(alertView, animated: true, completion: nil)
    }
}

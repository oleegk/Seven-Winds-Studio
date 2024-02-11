//
//  Extension.swift
//  Coffee
//
//  Created by Олег Ковалев on 07.02.2024.
//

import UIKit

extension UIColor {
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }
}

extension UIViewController {
     func moveViewUpAndDown() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { (nc) in
            self.view.frame.origin.y = -150
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { (nc) in
            self.view.frame.origin.y = 0
        }
    }
}


enum AlertPresenter {
    static func present(from controller: UIViewController?, with text: String, message: String? = nil) {
        guard let controller = controller else {
            return
        }
        let alertVC = UIAlertController(title: text, message: message, preferredStyle: .actionSheet)
        controller.present(alertVC, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            alertVC.dismiss(animated: true)
        }
    }

    
}

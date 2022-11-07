//
//  UIAlert.swift
//  AutomationSolutionzTest
//
//  Created by Sohanur Rahman on 8/11/22.
//

import UIKit

extension UIViewController {
    func addAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        alert.addAction(UIAlertAction(title: "Ok", style: .destructive){ (action) in })
        self.present(alert, animated: true, completion: nil)
    }
}


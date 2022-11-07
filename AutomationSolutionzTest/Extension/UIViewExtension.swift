//
//  LoaderView.swift
//  AutomationSolutionzTest
//
//  Created by Sohanur Rahman on 6/11/22.
//

import UIKit

let LoaderTag = 475647

extension UIView {
    
    func addRequestLoadingView(){
        let backgroundView = UIView()
        backgroundView.frame = self.bounds
        backgroundView.backgroundColor = .lightGray.withAlphaComponent(0.2)
        backgroundView.tag = LoaderTag
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: (self.bounds.width - 50) / 2, y: (self.bounds.height - 50) / 2, width: 50, height: 50))
        activityIndicator.center = self.center
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        backgroundView.addSubview(activityIndicator)
        self.addSubview(backgroundView)
    }

    func removeRequestLoadingView(){
        if let background = viewWithTag(LoaderTag){
            background.removeFromSuperview()
        }
    }
}

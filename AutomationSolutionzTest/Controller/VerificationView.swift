//
//  VerificationView.swift
//  AutomationSolutionzTest
//
//  Created by Sohanur Rahman on 8/11/22.
//

import UIKit

class VerificationView: UIView {

    var identifire = "VerificationView"
    
    @IBOutlet var viewSubview: UIView!
    
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var selectedProduct = StoreResponseModel()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initSubView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubView()
    }
    
    func initSubView() {
        let nib = UINib(nibName: identifire, bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        viewSubview.frame = bounds
        addSubview(viewSubview)
    }
}

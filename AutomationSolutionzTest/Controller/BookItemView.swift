//
//  BookItemView.swift
//  AutomationSolutionzTest
//
//  Created by Sohanur Rahman on 8/11/22.
//

import UIKit

class BookItemView: UIView {
    
    var identifire = "BookItemView"
    
    @IBOutlet var viewSubview: UIView!
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var fromDatePicker: UIDatePicker!
    @IBOutlet weak var toDatePicker: UIDatePicker!
    
    var viewController: UIViewController!
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
        
        productNameLabel.layer.borderColor = UIColor.lightGray.cgColor
        productNameLabel.layer.borderWidth = 1
        productNameLabel.layer.cornerRadius = 5
        productNameLabel.layer.masksToBounds = true
    }
    
    func bindData(data: StoreResponseModel){
        selectedProduct = data
        
        productNameLabel.text = "  " + (data.name ?? "") + "  "
    }
    
    @IBAction func continueButtonAction(_ sender: Any) {
        let verificationView = VerificationView(frame: viewSubview.frame)
        viewController.view.addSubview(verificationView)
        self.removeFromSuperview()
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.removeFromSuperview()
    }
}

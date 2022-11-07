//
//  StoreDataTableViewCell.swift
//  AutomationSolutionzTest
//
//  Created by Sohanur Rahman on 8/11/22.
//

import UIKit

class StoreDataTableViewCell: UITableViewCell {
    
    static let identifire = "StoreDataTableViewCell"
    
    @IBOutlet weak var serialNumberLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var availibilityLabel: UILabel!
    @IBOutlet weak var needToRepairLabel: UILabel!
    @IBOutlet weak var durabilityLabel: UILabel!
    @IBOutlet weak var mileageLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        contentView.backgroundColor = .lightText
    }
    
    func bindData(_ data: StoreResponseModel) {
        serialNumberLabel.text = String(describing: data.id ?? 0)
        productNameLabel.text = data.name ?? ""
        codeLabel.text = data.code ?? ""
        availibilityLabel.text = String(describing: data.availability ?? false).capitalized
        needToRepairLabel.text = String(describing: data.needing_repair ?? false).capitalized
        durabilityLabel.text = "\(data.durability ?? 0)/\(data.max_durability ?? 0)"
        mileageLabel.text = data.name ?? ""
    }
}

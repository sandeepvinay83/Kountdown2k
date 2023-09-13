//
//  ClassifyItemCell.swift
//  Kindergarten
//
//  Created by Sandeep Vinay on 12/09/23.
//

import UIKit

struct OptionDisplayModel {
    let optionModel: OptionModel?
    let isCheckmark: Bool
}

class ClassifyItemCell: UITableViewCell {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var checkmarkImageView: UIImageView!
    var optionDisplayModel: OptionDisplayModel? {
        didSet{
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: - Other
    
    private func updateUI() {
        self.itemImageView.image = UIImage(named: optionDisplayModel?.optionModel?.imageName ?? "")
        let imageName = (optionDisplayModel?.isCheckmark == true) ? "tick" : ""
        self.checkmarkImageView.image = UIImage(named: imageName)
    }
}

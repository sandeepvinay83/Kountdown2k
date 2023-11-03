//
//  NumberCountCell.swift
//  Kindergarten
//

import UIKit

struct NumberCountDisplayModel {
    let imageName: String?
    let title: String?
}

class NumberCountCell: UITableViewCell {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var displayModel: NumberCountDisplayModel? {
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
        self.itemImageView.image = UIImage(named: displayModel?.imageName ?? "")
        self.titleLabel.text = displayModel?.title
    }
}


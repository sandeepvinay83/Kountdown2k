//
//  MainCategoryTableHeaderView.swift
//  Kindergarten
//
//  Created by Sandeep Vinay on 06/09/23.
//

import UIKit

struct MainCategoryHeaderDisplayModel {
    var title: String?
    var dropdownImage: String?
}

final class MainCategoryHeaderView: UIView {
    let headerButton = UIButton()
    var dropdownImageView = UIImageView()
//    @IBOutlet weak var dropdownImageView: UIImageView!
//    @IBOutlet weak var headerButton: UIButton!
    
    var headerModel: MainCategoryHeaderDisplayModel? {
        didSet {
            updateUI()
        }
    }
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        addHeaderButton()
        addDropdownImageView()
    }

    required init?(coder: NSCoder) {
        fatalError("MainCategoryHeaderView init(coder:) has not been implemented")
    }

    // MARK: - Others
    func updateUI() {
        headerButton.setTitle(headerModel?.title, for: .normal)
        dropdownImageView.image = UIImage(named: headerModel?.dropdownImage ?? "")
    }

    // MARK: - Add Controls

    private func addHeaderButton() {
        headerButton.translatesAutoresizingMaskIntoConstraints = false
//        headerButton.setImage(UIImage(named: Constants.kImages.eGreyClose.rawValue), for: .normal)
        headerButton.contentVerticalAlignment = .center
        headerButton.contentHorizontalAlignment = .left
        headerButton.clipsToBounds = true
        headerButton.backgroundColor = UIColor.brown
        headerButton.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
        headerButton.titleLabel?.adjustsFontSizeToFitWidth = true
        addSubview(headerButton)
        addCloseButtonConstraints()
    }
    
    private func addDropdownImageView() {
        dropdownImageView.contentMode = .scaleAspectFit
        dropdownImageView.translatesAutoresizingMaskIntoConstraints = false
        dropdownImageView.clipsToBounds = true
        addSubview(dropdownImageView)
        addDropdownImageViewConstraints()
    }

//    private func addGuestEmailLabel() {
//        addSubview(guestEmailLabel)
//        addGuestEmailLabelConstraints()
//        guestEmailLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
//        guestEmailLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
//    }
//
//    private func addCanViewLabel() {
//        canViewLabel.text = "Can view:"
//        addSubview(canViewLabel)
//        addCanViewLabelConstraints()
//        canViewLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
//        canViewLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
//    }
//
//    private func addViewResidentsLabel() {
//        viewResidentsLabel.text = "Resident name"
//        addSubview(viewResidentsLabel)
//        addViewResidentsLabelConstraints()
//    }

    // MARK: - Add Constraints

    private func addCloseButtonConstraints() {
        NSLayoutConstraint.activate([
            headerButton.safeAreaLayoutGuide.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 1.0),
            headerButton.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 1.0),
            safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: headerButton.safeAreaLayoutGuide.trailingAnchor, constant: 1.0),
            safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: headerButton.safeAreaLayoutGuide.bottomAnchor),
//            headerButton.safeAreaLayoutGuide.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
//            headerButton.safeAreaLayoutGuide.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 1.0/8.0)
        ])
    }
    
    private func addDropdownImageViewConstraints() {
        NSLayoutConstraint.activate([
            safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: dropdownImageView.safeAreaLayoutGuide.trailingAnchor, constant: 10.0),
            dropdownImageView.safeAreaLayoutGuide.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            dropdownImageView.safeAreaLayoutGuide.heightAnchor.constraint(equalToConstant: 20.0),
            dropdownImageView.safeAreaLayoutGuide.widthAnchor.constraint(equalTo: dropdownImageView.safeAreaLayoutGuide.widthAnchor, multiplier: 1.0/1.0)
        ])
    }

//    private func addGuestEmailLabelConstraints() {
//        NSLayoutConstraint.activate([
//            guestEmailLabel.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10.0),
//            guestEmailLabel.safeAreaLayoutGuide.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20.0),
//            closeButton.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: guestEmailLabel.safeAreaLayoutGuide.trailingAnchor, constant: 10.0)
//        ])
//    }
//
//    private func addCanViewLabelConstraints() {
//        NSLayoutConstraint.activate([
//            canViewLabel.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10.0),
//            canViewLabel.safeAreaLayoutGuide.topAnchor.constraint(equalTo: guestEmailLabel.safeAreaLayoutGuide.bottomAnchor, constant: 5.0),
//            safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: canViewLabel.safeAreaLayoutGuide.bottomAnchor, constant: 10.0)
//        ])
//    }
//
//    private func addViewResidentsLabelConstraints() {
//        NSLayoutConstraint.activate([
//            safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: viewResidentsLabel.safeAreaLayoutGuide.trailingAnchor, constant: 10.0),
//            viewResidentsLabel.safeAreaLayoutGuide.topAnchor.constraint(equalTo: guestEmailLabel.safeAreaLayoutGuide.bottomAnchor, constant: 10.0),
//            safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: viewResidentsLabel.safeAreaLayoutGuide.bottomAnchor, constant: 10.0),
//            viewResidentsLabel.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: canViewLabel.safeAreaLayoutGuide.trailingAnchor, constant: 10.0)
//        ])
//    }
}

//
//  DifferenceItemViewController.swift
//  Kindergarten
//
//  Created by Sandeep Vinay on 14/09/23.
//

import UIKit

enum kDifferenceItemTexts: String {
    case eCellId = "DifferenceItemCell"
}

final class DifferenceItemViewController: UIViewController {
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var differenceItemTableView: UITableView!
    var differenceModel: ClassifyModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    /// Initialising the view
    private func initializeView() {
        self.headerLabel.text = differenceModel?.header
    }
    
    // MARK: - Action methods
    
    // MARK: - Other
}

// MARK: - UITableViewDataSource

extension DifferenceItemViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return differenceModel?.options.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kDifferenceItemTexts.eCellId.rawValue, for: indexPath) as? ClassifyItemCell else {
            fatalError("Difference Item Cell not exists")
        }
        cell.optionDisplayModel = OptionDisplayModel(optionModel: self.differenceModel?.options[indexPath.row], isCheckmark: false)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
}

// MARK: - UITableViewDelegate

extension DifferenceItemViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.differenceModel?.options[indexPath.row].answer == "0" {
            AlertView().showAlertView(controller: self, title: "", message: "You selected wrong answer. Try again!")
        } else {
            AlertView().showAlertView(controller: self, title: "", message: "Awesome! You did it. Do you want to play again?", okButtonTitle: "Yes", cancelButtonTitle: "No", handler: { (action) in
                if action.title == "No" {
                    self.navigationController?.popViewController(animated: true)
                } else if action.title == "Yes" {
                    self.differenceItemTableView.reloadData()
                }
            })
        }
    }
}

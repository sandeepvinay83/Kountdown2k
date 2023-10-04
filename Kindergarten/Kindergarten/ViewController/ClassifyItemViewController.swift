//
//  ClassifyItemViewController.swift
//  Kindergarten
//
//  Created by Sandeep Vinay on 11/09/23.
//

import UIKit

enum kClassifyItemTexts: String {
    case eCellId = "ClassifyItemCell"
}

final class ClassifyItemViewController: UIViewController {
    @IBOutlet weak var classifyItemTableView: UITableView!
    var classifyModel: ClassifyModel?
    var selectedRows = [Int]()
    var totalCorrectAnswers : Int?
    var successMessage: String?
    var failMessage: String?
    var alertButtonYesTitle: String?
    var alertButtonNoTitle: String?
    var alertButtonOkTitle: String?

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
        self.totalCorrectAnswers = self.classifyModel?.options.filter{$0.answer == "1"}.count
        navigationItem.title = classifyModel?.header
    }
    
    // MARK: - Action methods
    
    @objc func segmentedValueChanged(_ sender:UISegmentedControl!) {
        print("Selected Segment Index is : \(sender.selectedSegmentIndex)")
        LocalStorageManager.shared.selectedLanguage = sender.titleForSegment(at: sender.selectedSegmentIndex)
        self.classifyItemTableView.reloadData()
    }
    
    // MARK: - Other
    
    private func isValueInSelectedRows(value: Int) -> Bool {
        if self.selectedRows.contains(where: { (item) in
            if item == value {
                return true
            }
            return false
        }) {
            return true
        } else {
            return false
        }
    }
}

// MARK: - UITableViewDataSource

extension ClassifyItemViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classifyModel?.options.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kClassifyItemTexts.eCellId.rawValue, for: indexPath) as? ClassifyItemCell else {
            fatalError("Classify Item Cell not exists")
        }
        cell.optionDisplayModel = OptionDisplayModel(optionModel: self.classifyModel?.options[indexPath.row], isCheckmark: self.isValueInSelectedRows(value: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250.0
    }
}

// MARK: - UITableViewDelegate

extension ClassifyItemViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.classifyModel?.options[indexPath.row].answer == "0" {
            AlertView().showAlertView(controller: self, title: "", message: self.failMessage ?? "", okButtonTitle: self.alertButtonOkTitle)
        } else {
            if let index = self.selectedRows.firstIndex(where: { (item) in
                if item == indexPath.row {
                    return true
                }
                return false
            }) {
                self.selectedRows.remove(at: index)
            } else {
                self.selectedRows.append(indexPath.row)
            }
            self.classifyItemTableView.reloadData()
            
            if self.selectedRows.count == self.totalCorrectAnswers {
                AlertView().showAlertView(controller: self, title: "", message: self.successMessage ?? "", okButtonTitle: self.alertButtonYesTitle, cancelButtonTitle: self.alertButtonNoTitle, handler: { (action) in
                    if action.title == self.alertButtonNoTitle {
                        self.navigationController?.popViewController(animated: true)
                    } else if action.title == self.alertButtonYesTitle {
                        self.selectedRows.removeAll()
                        self.classifyItemTableView.reloadData()
                    }
                })
            }
        }
    }
}

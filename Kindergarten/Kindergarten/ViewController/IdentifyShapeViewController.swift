//
//  IdentifyShapeViewController.swift
//  Kindergarten
//
//  Created by Sandeep Vinay on 16/09/23.
//

import UIKit

enum kIdentifyShapeTexts: String {
    case eCellId = "IdentifyShapeCell"
}

final class IdentifyShapeViewController: UIViewController {
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var identifyShapeTableView: UITableView!
    var identifyShapeArray: [ClassifyModel]?
    private var currentArrayIndex: Int = 0

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
        updateUI()
    }
    
    // MARK: - Action methods
    @IBAction func onPreviousButtonClick(_ sender: Any) {
        self.currentArrayIndex = self.currentArrayIndex - 1
        self.updateUI()
    }
    
    @IBAction func onNextButtonClick(_ sender: Any) {
        self.currentArrayIndex = self.currentArrayIndex + 1
        self.updateUI()
    }
    
    // MARK: - Other
    
    private func updateUI() {
        self.headerLabel.text = self.identifyShapeArray?[self.currentArrayIndex].header
        if let identifyShapeArray = self.identifyShapeArray {
            if self.currentArrayIndex == 0 {
                self.previousButton.isUserInteractionEnabled = false
            } else if self.currentArrayIndex == (identifyShapeArray.count - 1) {
                self.nextButton.isUserInteractionEnabled = false
                self.nextButton.setTitle("Finish", for: .normal)
            } else {
                self.previousButton.isUserInteractionEnabled = true
                self.nextButton.isUserInteractionEnabled = true
                self.nextButton.setTitle("Next", for: .normal)
            }
        }
        self.identifyShapeTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension IdentifyShapeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return basicColorsModel?.options.count ?? 0
        return self.identifyShapeArray?[self.currentArrayIndex].options.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kIdentifyShapeTexts.eCellId.rawValue, for: indexPath) as? ClassifyItemCell else {
            fatalError("Identify Shape Cell not exists")
        }
//        cell.optionDisplayModel = OptionDisplayModel(optionModel: self.basicColorsModel?.options[indexPath.row], isCheckmark: false)
        cell.optionDisplayModel = OptionDisplayModel(optionModel: self.identifyShapeArray?[self.currentArrayIndex].options[indexPath.row], isCheckmark: false)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
}

// MARK: - UITableViewDelegate

extension IdentifyShapeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if self.basicColorsModel?.options[indexPath.row].answer == "0" {
        if self.identifyShapeArray?[self.currentArrayIndex].options[indexPath.row].answer == "0" {
            AlertView().showAlertView(controller: self, title: "", message: "You selected wrong answer. Try again!")
        } else {
            AlertView().showAlertView(controller: self, title: "", message: "Awesome! You did it. Do you want to play again?", okButtonTitle: "Yes", cancelButtonTitle: "No", handler: { (action) in
                if action.title == "No" {
//                    self.navigationController?.popViewController(animated: true)
                } else if action.title == "Yes" {
                    self.identifyShapeTableView.reloadData()
                }
            })
        }
    }
}

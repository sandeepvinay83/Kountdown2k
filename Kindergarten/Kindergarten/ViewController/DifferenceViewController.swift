//
//  DifferenceViewController.swift
//  Kindergarten
//
//  Created by Sandeep Vinay on 14/09/23.
//

import UIKit

enum kDifferenceTexts: String {
    case eCellId = "DifferenceCell"
}

final class DifferenceViewController: UIViewController {
    @IBOutlet weak var differenceTableView: UITableView!
    private var differenceArray: [ClassifyModel]?

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
        self.loadDifferenceData()
        print(differenceArray ?? "")
        navigationItem.title = "Similarity & Difference"
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationViewController = segue.destination as? DifferenceItemViewController else {
            return
        }
        destinationViewController.differenceModel = sender as? ClassifyModel
    }
    
    // MARK: - Action methods
    
    // MARK: - Other
    
    private func loadDifferenceData() {
        let kindergartenWebservice = KindergartenWebservice()
        if LocalStorageManager.shared.selectedLanguage == Constants.kLanguageKey.eEnglish.rawValue {
            kindergartenWebservice.differenceApi_English()
            guard let differenceModel: DifferenceResponseModel = LocalStorageManager.shared.readFromLocalStorage(fileName: .DifferenceJson_English) else {
                return
            }
            differenceArray = differenceModel.differenceArray
        } else {
            kindergartenWebservice.differenceApi_Spanish()
            guard let differenceModel: DifferenceResponseModel = LocalStorageManager.shared.readFromLocalStorage(fileName: .DifferenceJson_Spanish) else {
                return
            }
            differenceArray = differenceModel.differenceArray
        }
    }
}

// MARK: - UITableViewDataSource

extension DifferenceViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return differenceArray?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kDifferenceTexts.eCellId.rawValue, for: indexPath)
        cell.textLabel?.text = differenceArray?[indexPath.row].title
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14.0)
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}

// MARK: - UITableViewDelegate

extension DifferenceViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: Constants.kSegueKey.eShowDifferenceItem.rawValue, sender: differenceArray?[indexPath.row])
    }
}

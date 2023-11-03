//
//  NumberCountViewController.swift
//  Kindergarten
//

import UIKit

enum kNumberCountTexts: String {
    case eCellId = "NumberCountCell"
}

final class NumberCountViewController: UIViewController {
    @IBOutlet weak var numberCountTableView: UITableView!
    private var header: String?
    private var countArray = ["1fish", "2slides", "3elephants", "4houses", "5cars", "6flowers", "7ducks", "8turtles", "9suns", "10trees", "11clouds", "12ladybugs", "13birds", "14triangles", "15pencils", "16hearts"]

    override func viewDidLoad() {
        super.viewDidLoad()
        loadLanguageContent()
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
        navigationItem.title = header
    }
    
    // MARK: - Other
    
    private func loadLanguageContent() {
        if LocalStorageManager.shared.selectedLanguage == Constants.kLanguageKey.eEnglish.rawValue {
            header = "Learn Counting"
        } else {
            header = "aprender a contar"
        }
    }
}

// MARK: - UITableViewDataSource

extension NumberCountViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kNumberCountTexts.eCellId.rawValue, for: indexPath) as? NumberCountCell else {
            fatalError("Number Count Cell not exists")
        }
        cell.displayModel = NumberCountDisplayModel(imageName: self.countArray[indexPath.row], title: "\(indexPath.row + 1)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250.0
    }
}


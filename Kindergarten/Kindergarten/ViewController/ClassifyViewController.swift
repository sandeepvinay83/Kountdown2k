//
//  ClassificationViewController.swift
//  Kindergarten
//

import UIKit

enum kClassifyTexts: String {
    case eCellId = "ClassifyCell"
}

final class ClassifyViewController: UIViewController {
    @IBOutlet weak var classifyTableView: UITableView!
    private var classifyArray: [ClassifyModel]?
    private var messageModel: MessageModel?
    private var alertButtonTitleModel: AlertButtonModel?

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
        self.loadClassifyData()
        print(classifyArray ?? "")
        navigationItem.title = "Sort & Classify"
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationViewController = segue.destination as? ClassifyItemViewController else {
            return
        }
        destinationViewController.classifyModel = sender as? ClassifyModel
        destinationViewController.messageModel = self.messageModel
        destinationViewController.alertButtonTitleModel = self.alertButtonTitleModel
    }
    
    // MARK: - Action methods
    
    @objc func segmentedValueChanged(_ sender:UISegmentedControl!)
    {
        print("Selected Segment Index is : \(sender.selectedSegmentIndex)")
        LocalStorageManager.shared.selectedLanguage = sender.titleForSegment(at: sender.selectedSegmentIndex)
        self.loadClassifyData()
        self.classifyTableView.reloadData()
    }
    
    // MARK: - Other
    
    private func loadClassifyData() {
        let kindergartenWebservice = KindergartenWebservice()
        if LocalStorageManager.shared.selectedLanguage == Constants.kLanguageKey.eEnglish.rawValue {
            kindergartenWebservice.classifyApi_English()
            guard let classifyModel: ClassifyResponseModel = LocalStorageManager.shared.readFromLocalStorage(fileName: .ClassifyJson_English) else {
                return
            }
            classifyArray = classifyModel.classifyArray
            messageModel = MessageModel()
            messageModel?.success = classifyModel.message?.success
            messageModel?.fail = classifyModel.message?.fail
            alertButtonTitleModel = AlertButtonModel()
            alertButtonTitleModel?.yes = Constants.kAlertButtonTitleKey_English.eYes.rawValue
            alertButtonTitleModel?.no = Constants.kAlertButtonTitleKey_English.eNo.rawValue
            alertButtonTitleModel?.ok = Constants.kAlertButtonTitleKey_English.eOk.rawValue
        } else {
            kindergartenWebservice.classifyApi_Spanish()
            guard let classifyModel: ClassifyResponseModel = LocalStorageManager.shared.readFromLocalStorage(fileName: .ClassifyJson_Spanish) else {
                return
            }
            classifyArray = classifyModel.classifyArray
            messageModel = MessageModel()
            messageModel?.success = classifyModel.message?.success
            messageModel?.fail = classifyModel.message?.fail
            alertButtonTitleModel = AlertButtonModel()
            alertButtonTitleModel?.yes = Constants.kAlertButtonTitleKey_Spanish.eYes.rawValue
            alertButtonTitleModel?.no = Constants.kAlertButtonTitleKey_Spanish.eNo.rawValue
            alertButtonTitleModel?.ok = Constants.kAlertButtonTitleKey_Spanish.eOk.rawValue
        }
    }
}

// MARK: - UITableViewDataSource

extension ClassifyViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classifyArray?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kClassifyTexts.eCellId.rawValue, for: indexPath)
        cell.textLabel?.text = classifyArray?[indexPath.row].title
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

extension ClassifyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: Constants.kSegueKey.eShowClassifyItem.rawValue, sender: classifyArray?[indexPath.row])
    }
}

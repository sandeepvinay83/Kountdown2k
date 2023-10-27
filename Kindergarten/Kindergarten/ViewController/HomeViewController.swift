//
//  HomeViewController.swift
//  Kindergarten
//

import UIKit

enum kHomeTexts: String {
    case eCellId = "HomeItemCell"
    case eHeaderId = "HomeHeaderCell"
}

final class HomeViewController: UIViewController {
    @IBOutlet weak var mainCategoryTableView: UITableView!
    private var clickedSectionIndex = 0
    private var mainCategoryArray: [MainCategoryModel]?

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
        LocalStorageManager.shared.selectedLanguage = Constants.kLanguageKey.eEnglish.rawValue
        self.loadMaincategoryData()
        self.mainCategoryTableView.sectionFooterHeight = 0.0
        print(mainCategoryArray ?? "")
//        navigationItem.title = "KOUNTDOWN2K"
        navigationItem.addLogo()
        navigationItem.addLanguageSegmentedControl(target: self, selector: #selector(self.segmentedValueChanged(_:)))
        navigationItem.addProfileButton(target: self, selector: #selector(self.profileClicked(_:)))
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.kSegueKey.eShowBasicColors.rawValue {
            guard let destinationViewController = segue.destination as? BasicColorsViewController else {
                return
            }
            var messageModel: MessageModel?
            var alertButtonTitleModel: AlertButtonModel?
            destinationViewController.basicColorsArray = self.loadBasicColorsData(messageModel: &messageModel, alertButtonTitleModel: &alertButtonTitleModel)
            destinationViewController.messageModel = messageModel
            destinationViewController.alertButtonTitleModel = alertButtonTitleModel
        } else if segue.identifier == Constants.kSegueKey.eShowIdentifyShape.rawValue {
            guard let destinationViewController = segue.destination as? IdentifyShapeViewController else {
                return
            }
            var messageModel: MessageModel?
            var alertButtonTitleModel: AlertButtonModel?
            destinationViewController.identifyShapeArray = self.loadIdentifyShapeData(messageModel: &messageModel, alertButtonTitleModel: &alertButtonTitleModel)
            destinationViewController.messageModel = messageModel
            destinationViewController.alertButtonTitleModel = alertButtonTitleModel
        } else if segue.identifier == Constants.kSegueKey.eShowCountSets.rawValue {
            guard let destinationViewController = segue.destination as? CountSetsViewController else {
                return
            }
//            destinationViewController.countSetsArray = self.loadCountSetsData()
            var messageModel: MessageModel?
            var alertButtonTitleModel: AlertButtonModel?
            destinationViewController.countSetsArray = self.loadCountSetsData(messageModel: &messageModel, alertButtonTitleModel: &alertButtonTitleModel)
            destinationViewController.messageModel = messageModel
            destinationViewController.alertButtonTitleModel = alertButtonTitleModel
        } else if segue.identifier == Constants.kSegueKey.eShowAddition.rawValue {
            guard let destinationViewController = segue.destination as? AdditionViewController else {
                return
            }
//            destinationViewController.additionArray = self.loadAdditionData()
            var messageModel: MessageModel?
            var alertButtonTitleModel: AlertButtonModel?
            destinationViewController.additionArray = self.loadAdditionData(messageModel: &messageModel, alertButtonTitleModel: &alertButtonTitleModel)
            destinationViewController.messageModel = messageModel
            destinationViewController.alertButtonTitleModel = alertButtonTitleModel
        }
    }
    
    // MARK: - Action methods
    
    @objc func segmentedValueChanged(_ sender:UISegmentedControl!) {
        print("Selected Segment Index is : \(sender.selectedSegmentIndex)")
        LocalStorageManager.shared.selectedLanguage = sender.titleForSegment(at: sender.selectedSegmentIndex)
        self.loadMaincategoryData()
        self.mainCategoryTableView.reloadData()
    }
    
    @objc func profileClicked(_ sender:UIBarButtonItem!) {
        self.performSegue(withIdentifier: Constants.kSegueKey.eShowProfile.rawValue, sender: nil)
    }
    
    /// header button click
    ///
    /// - Parameter sender: button
    @objc func onClickHeaderButton(sender: UIButton) {
        print("\(sender.titleLabel?.text) clicked")
        clickedSectionIndex = sender.tag
        self.mainCategoryTableView.reloadData()
    }
    
    // MARK: - Other
    
    private func loadMaincategoryData() {
        let kindergartenWebservice = KindergartenWebservice()
        if LocalStorageManager.shared.selectedLanguage == Constants.kLanguageKey.eEnglish.rawValue {
            kindergartenWebservice.mainCategoryApi_English()
            guard let kindergartenModel: MainCategoryResponseModel = LocalStorageManager.shared.readFromLocalStorage(fileName: .MainCategoryJson_English) else {
                return
            }
            mainCategoryArray = kindergartenModel.mainCategoryArray
        } else {
            kindergartenWebservice.mainCategoryApi_Spanish()
            guard let kindergartenModel: MainCategoryResponseModel = LocalStorageManager.shared.readFromLocalStorage(fileName: .MainCategoryJson_Spanish) else {
                return
            }
            mainCategoryArray = kindergartenModel.mainCategoryArray
        }
    }
    
    private func loadBasicColorsData(messageModel: inout MessageModel?, alertButtonTitleModel: inout AlertButtonModel?) -> [ClassifyModel]? {
        let kindergartenWebservice = KindergartenWebservice()
        if LocalStorageManager.shared.selectedLanguage == Constants.kLanguageKey.eEnglish.rawValue {
            kindergartenWebservice.basicColorsApi_English()
            guard let basicColorsModel: BasicColorsResponseModel = LocalStorageManager.shared.readFromLocalStorage(fileName: .BasicColorsJson_English) else {
                return nil
            }
            messageModel = MessageModel()
            messageModel?.success = basicColorsModel.message?.success
            messageModel?.fail = basicColorsModel.message?.fail
            alertButtonTitleModel = AlertButtonModel()
            alertButtonTitleModel?.yes = Constants.kAlertButtonTitleKey_English.eYes.rawValue
            alertButtonTitleModel?.no = Constants.kAlertButtonTitleKey_English.eNo.rawValue
            alertButtonTitleModel?.ok = Constants.kAlertButtonTitleKey_English.eOk.rawValue
            alertButtonTitleModel?.next = Constants.kAlertButtonTitleKey_English.eNext.rawValue
            alertButtonTitleModel?.finish = Constants.kAlertButtonTitleKey_English.eFinish.rawValue
            alertButtonTitleModel?.previous = Constants.kAlertButtonTitleKey_English.ePrevious.rawValue
            return basicColorsModel.basicColorsArray
        } else {
            kindergartenWebservice.basicColorsApi_Spanish()
            guard let basicColorsModel: BasicColorsResponseModel = LocalStorageManager.shared.readFromLocalStorage(fileName: .BasicColorsJson_Spanish) else {
                return nil
            }
            messageModel = MessageModel()
            messageModel?.success = basicColorsModel.message?.success
            messageModel?.fail = basicColorsModel.message?.fail
            alertButtonTitleModel = AlertButtonModel()
            alertButtonTitleModel?.yes = Constants.kAlertButtonTitleKey_Spanish.eYes.rawValue
            alertButtonTitleModel?.no = Constants.kAlertButtonTitleKey_Spanish.eNo.rawValue
            alertButtonTitleModel?.ok = Constants.kAlertButtonTitleKey_Spanish.eOk.rawValue
            alertButtonTitleModel?.next = Constants.kAlertButtonTitleKey_Spanish.eNext.rawValue
            alertButtonTitleModel?.finish = Constants.kAlertButtonTitleKey_Spanish.eFinish.rawValue
            alertButtonTitleModel?.previous = Constants.kAlertButtonTitleKey_Spanish.ePrevious.rawValue
            return basicColorsModel.basicColorsArray
        }
    }
    
    private func loadIdentifyShapeData(messageModel: inout MessageModel?, alertButtonTitleModel: inout AlertButtonModel?) -> [ClassifyModel]? {
        let kindergartenWebservice = KindergartenWebservice()
        if LocalStorageManager.shared.selectedLanguage == Constants.kLanguageKey.eEnglish.rawValue {
            kindergartenWebservice.identifyShapeApi_English()
            guard let identifyShapeModel: IdentifyShapeResponseModel = LocalStorageManager.shared.readFromLocalStorage(fileName: .IdentifyShapeJson_English) else {
                return nil
            }
            messageModel = MessageModel()
            messageModel?.success = identifyShapeModel.message?.success
            messageModel?.fail = identifyShapeModel.message?.fail
            alertButtonTitleModel = AlertButtonModel()
            alertButtonTitleModel?.yes = Constants.kAlertButtonTitleKey_English.eYes.rawValue
            alertButtonTitleModel?.no = Constants.kAlertButtonTitleKey_English.eNo.rawValue
            alertButtonTitleModel?.ok = Constants.kAlertButtonTitleKey_English.eOk.rawValue
            alertButtonTitleModel?.next = Constants.kAlertButtonTitleKey_English.eNext.rawValue
            alertButtonTitleModel?.finish = Constants.kAlertButtonTitleKey_English.eFinish.rawValue
            alertButtonTitleModel?.previous = Constants.kAlertButtonTitleKey_English.ePrevious.rawValue
            return identifyShapeModel.identifyShapeArray
        } else {
            kindergartenWebservice.identifyShapeApi_Spanish()
            guard let identifyShapeModel: IdentifyShapeResponseModel = LocalStorageManager.shared.readFromLocalStorage(fileName: .IdentifyShapeJson_Spanish) else {
                return nil
            }
            messageModel = MessageModel()
            messageModel?.success = identifyShapeModel.message?.success
            messageModel?.fail = identifyShapeModel.message?.fail
            alertButtonTitleModel = AlertButtonModel()
            alertButtonTitleModel?.yes = Constants.kAlertButtonTitleKey_Spanish.eYes.rawValue
            alertButtonTitleModel?.no = Constants.kAlertButtonTitleKey_Spanish.eNo.rawValue
            alertButtonTitleModel?.ok = Constants.kAlertButtonTitleKey_Spanish.eOk.rawValue
            alertButtonTitleModel?.next = Constants.kAlertButtonTitleKey_Spanish.eNext.rawValue
            alertButtonTitleModel?.finish = Constants.kAlertButtonTitleKey_Spanish.eFinish.rawValue
            alertButtonTitleModel?.previous = Constants.kAlertButtonTitleKey_Spanish.ePrevious.rawValue
            return identifyShapeModel.identifyShapeArray
        }
    }
    
    private func loadCountSetsData(messageModel: inout MessageModel?, alertButtonTitleModel: inout AlertButtonModel?) -> [ClassifyModel]? {
        let kindergartenWebservice = KindergartenWebservice()
        if LocalStorageManager.shared.selectedLanguage == Constants.kLanguageKey.eEnglish.rawValue {
            kindergartenWebservice.countSetsApi_English()
            guard let countSetsModel: CountSetsResponseModel = LocalStorageManager.shared.readFromLocalStorage(fileName: .CountSetsJson_English) else {
                return nil
            }
            messageModel = MessageModel()
            messageModel?.success = countSetsModel.message?.success
            messageModel?.fail = countSetsModel.message?.fail
            alertButtonTitleModel = AlertButtonModel()
            alertButtonTitleModel?.yes = Constants.kAlertButtonTitleKey_English.eYes.rawValue
            alertButtonTitleModel?.no = Constants.kAlertButtonTitleKey_English.eNo.rawValue
            alertButtonTitleModel?.ok = Constants.kAlertButtonTitleKey_English.eOk.rawValue
            alertButtonTitleModel?.next = Constants.kAlertButtonTitleKey_English.eNext.rawValue
            alertButtonTitleModel?.finish = Constants.kAlertButtonTitleKey_English.eFinish.rawValue
            alertButtonTitleModel?.previous = Constants.kAlertButtonTitleKey_English.ePrevious.rawValue
            return countSetsModel.countSetsArray
        } else {
            kindergartenWebservice.countSetsApi_Spanish()
            guard let countSetsModel: CountSetsResponseModel = LocalStorageManager.shared.readFromLocalStorage(fileName: .CountSetsJson_Spanish) else {
                return nil
            }
            messageModel = MessageModel()
            messageModel?.success = countSetsModel.message?.success
            messageModel?.fail = countSetsModel.message?.fail
            alertButtonTitleModel = AlertButtonModel()
            alertButtonTitleModel?.yes = Constants.kAlertButtonTitleKey_Spanish.eYes.rawValue
            alertButtonTitleModel?.no = Constants.kAlertButtonTitleKey_Spanish.eNo.rawValue
            alertButtonTitleModel?.ok = Constants.kAlertButtonTitleKey_Spanish.eOk.rawValue
            alertButtonTitleModel?.next = Constants.kAlertButtonTitleKey_Spanish.eNext.rawValue
            alertButtonTitleModel?.finish = Constants.kAlertButtonTitleKey_Spanish.eFinish.rawValue
            alertButtonTitleModel?.previous = Constants.kAlertButtonTitleKey_Spanish.ePrevious.rawValue
            return countSetsModel.countSetsArray
        }
    }
    
    private func loadAdditionData(messageModel: inout MessageModel?, alertButtonTitleModel: inout AlertButtonModel?) -> [ClassifyModel]? {
        let kindergartenWebservice = KindergartenWebservice()
        if LocalStorageManager.shared.selectedLanguage == Constants.kLanguageKey.eEnglish.rawValue {
            kindergartenWebservice.additionApi_English()
            guard let additionModel: AdditionResponseModel = LocalStorageManager.shared.readFromLocalStorage(fileName: .AdditionJson_English) else {
                return nil
            }
            messageModel = MessageModel()
            messageModel?.success = additionModel.message?.success
            messageModel?.fail = additionModel.message?.fail
            alertButtonTitleModel = AlertButtonModel()
            alertButtonTitleModel?.yes = Constants.kAlertButtonTitleKey_English.eYes.rawValue
            alertButtonTitleModel?.no = Constants.kAlertButtonTitleKey_English.eNo.rawValue
            alertButtonTitleModel?.ok = Constants.kAlertButtonTitleKey_English.eOk.rawValue
            alertButtonTitleModel?.next = Constants.kAlertButtonTitleKey_English.eNext.rawValue
            alertButtonTitleModel?.finish = Constants.kAlertButtonTitleKey_English.eFinish.rawValue
            alertButtonTitleModel?.previous = Constants.kAlertButtonTitleKey_English.ePrevious.rawValue
            return additionModel.additionArray
        } else {
            kindergartenWebservice.additionApi_Spanish()
            guard let additionModel: AdditionResponseModel = LocalStorageManager.shared.readFromLocalStorage(fileName: .AdditionJson_Spanish) else {
                return nil
            }
            messageModel = MessageModel()
            messageModel?.success = additionModel.message?.success
            messageModel?.fail = additionModel.message?.fail
            alertButtonTitleModel = AlertButtonModel()
            alertButtonTitleModel?.yes = Constants.kAlertButtonTitleKey_Spanish.eYes.rawValue
            alertButtonTitleModel?.no = Constants.kAlertButtonTitleKey_Spanish.eNo.rawValue
            alertButtonTitleModel?.ok = Constants.kAlertButtonTitleKey_Spanish.eOk.rawValue
            alertButtonTitleModel?.next = Constants.kAlertButtonTitleKey_Spanish.eNext.rawValue
            alertButtonTitleModel?.finish = Constants.kAlertButtonTitleKey_Spanish.eFinish.rawValue
            alertButtonTitleModel?.previous = Constants.kAlertButtonTitleKey_Spanish.ePrevious.rawValue
            return additionModel.additionArray
        }
    }
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return mainCategoryArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainCategoryArray?[section].values.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kHomeTexts.eCellId.rawValue, for: indexPath)
        cell.textLabel?.text = mainCategoryArray?[indexPath.section].values[indexPath.row]
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14.0)
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = 0.0
        if indexPath.section == clickedSectionIndex {
            height = 50.0
        }
        return height
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                self.performSegue(withIdentifier: Constants.kSegueKey.eShowClassify.rawValue, sender: nil)
            case 1:
                self.performSegue(withIdentifier: Constants.kSegueKey.eShowDifference.rawValue, sender: nil)
            case 2:
                self.performSegue(withIdentifier: Constants.kSegueKey.eShowBasicColors.rawValue, sender: nil)
            case 3:
                self.performSegue(withIdentifier: Constants.kSegueKey.eShowIdentifyShape.rawValue, sender: nil)
            case 5:
                self.performSegue(withIdentifier: Constants.kSegueKey.eShowCountSets.rawValue, sender: nil)
            case 6:
                self.performSegue(withIdentifier: Constants.kSegueKey.eShowAddition.rawValue, sender: nil)
            default:
                print("Cell not defined")
            }
        } else if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                self.performSegue(withIdentifier: "showSpeak", sender: nil)
            default:
                print("Cell not defined")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = MainCategoryHeaderView()
        headerView.headerModel = MainCategoryHeaderDisplayModel(title: mainCategoryArray?[section].name, dropdownImage: (section == clickedSectionIndex) ? "collapse" : "expand")
        headerView.headerButton.tag = section
        headerView.headerButton.addTarget(self, action: #selector(onClickHeaderButton), for: .touchUpInside)
        return headerView
    }
}

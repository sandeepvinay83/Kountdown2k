//
//  HomeViewController.swift
//  Kindergarten
//
//  Created by Sandeep Vinay on 05/09/23.
//

import UIKit

enum kHomeTexts: String {
    case eCellId = "HomeItemCell"
    case eHeaderId = "HomeHeaderCell"
}

final class HomeViewController: UIViewController {
    @IBOutlet weak var mainCategoryTableView: UITableView!
//    private let homeView = HomeView()
    private var clickedSectionIndex = 0
    private var mainCategoryArray: [MainCategoryModel]?
//    lazy private var loginViewModel: LoginViewModel = {
//        return LoginViewModel()
//    }()
//    private let log = Log()

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        navigationController?.navigationBar.isHidden = false
    }

    /// Initialising the view
    private func initializeView() {
//        view = homeView
        LocalStorageManager.shared.selectedLanguage = Constants.kLanguageKey.eEnglish.rawValue
        self.loadMaincategoryData()
        self.mainCategoryTableView.sectionFooterHeight = 0.0
        print(mainCategoryArray ?? "")
        navigationItem.title = "KOUNTDOWNN2K"
        navigationItem.addLanguageSegmentedControl(target: self, selector: #selector(self.segmentedValueChanged(_:)))
//        view.addSubview(homeView)
//        homeView.mainCategoryTableView.dataSource = self
//        homeView.mainCategoryTableView.delegate = self
    }
    
    // MARK: - Action methods
    
    @objc func segmentedValueChanged(_ sender:UISegmentedControl!)
    {
        print("Selected Segment Index is : \(sender.selectedSegmentIndex)")
        LocalStorageManager.shared.selectedLanguage = sender.titleForSegment(at: sender.selectedSegmentIndex)
        self.loadMaincategoryData()
        self.mainCategoryTableView.reloadData()
    }
    
    /// header button click
    ///
    /// - Parameter sender: button
    @objc func onClickHeaderButton(sender: UIButton) {
        print("\(sender.titleLabel?.text) clicked")
        clickedSectionIndex = sender.tag
//        homeView.mainCategoryTableView.reloadData()
        self.mainCategoryTableView.reloadData()
        
        
        
        
//        let section = sender.tag
//        AlertView().showAlertView(controller: self, title: "", message: "Are You Sure Want To Remove Access?", cancelButtonTitle: "Cancel", handler: { _ in
//            self.log.DLog(message: "OK pressed section-\(section)")
//            DispatchQueue.main.async {
//                self.manageGuestViewModel.removeGuestInLoop(progressDelegate: self, at: section, onCompletion: { (message) in
//                    AlertView().showAlertView(controller: self, title: "", message: message)
//                    self.manageGuestViewModel.loadData()
//                    self.manageGuestView.manageGuestTableView.reloadData()
//                })
//            }
//        })
    }
    
    // MARK: - Other
    
    private func loadMaincategoryData() {
        let kindergartenWebservice = KindergartenWebservice()
        if LocalStorageManager.shared.selectedLanguage == Constants.kLanguageKey.eEnglish.rawValue {
            kindergartenWebservice.kindergartenApi_English()
            guard let kindergartenModel: KindergartenModel = LocalStorageManager.shared.readFromLocalStorage(fileName: .KindergartenJson_English) else {
                return
            }
            mainCategoryArray = kindergartenModel.mainCategory
        } else {
            kindergartenWebservice.kindergartenApi_Spanish()
            guard let kindergartenModel: KindergartenModel = LocalStorageManager.shared.readFromLocalStorage(fileName: .KindergartenJson_Spanish) else {
                return
            }
            mainCategoryArray = kindergartenModel.mainCategory
        }
    }
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
//        return 3
        return mainCategoryArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return messageViewModel.messageArray?.count ?? 0
        return mainCategoryArray?[section].values.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: messageView.cellId, for: indexPath) as? MessageCell else {
//            fatalError("Message Cell not exists")
//        }
//        cell.messageDisplayModel = messageViewModel.displayMessage(notificationModel: messageViewModel.messageArray?[indexPath.row])
        let cell = tableView.dequeueReusableCell(withIdentifier: kHomeTexts.eCellId.rawValue, for: indexPath)
        cell.textLabel?.text = mainCategoryArray?[indexPath.section].values[indexPath.row]
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14.0)
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Section \(section+1)"
//    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 0.1
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = 0.0
        if indexPath.section == clickedSectionIndex {
            height = 40.0
        }
        return height
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let messageDetailView = MessageDetailViewController()
//        messageDetailView.messageDisplayModel = messageViewModel.displayMessage(notificationModel: messageViewModel.messageArray?[indexPath.row])
//        navigationController?.pushViewController(messageDetailView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = MainCategoryHeaderView()
//        headerView.headerModel = MainCategoryHeaderDisplayModel(title: "Section \(section+1)", dropdownImage: (section == clickedSectionIndex) ? "collapse" : "expand")
        headerView.headerModel = MainCategoryHeaderDisplayModel(title: mainCategoryArray?[section].name, dropdownImage: (section == clickedSectionIndex) ? "collapse" : "expand")
        headerView.headerButton.tag = section
        headerView.headerButton.addTarget(self, action: #selector(onClickHeaderButton), for: .touchUpInside)
        return headerView
    }
}

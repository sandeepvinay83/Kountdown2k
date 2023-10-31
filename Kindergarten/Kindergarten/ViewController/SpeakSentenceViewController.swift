//
//  SpeakSentenceViewController.swift
//  Kindergarten
//

import UIKit

class SpeakSentenceViewController: UIViewController {
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pictureImageView: UIImageView!
    private var imageArray = ["kidsSchool", "kidsPlaying", "kidsHelping", "kidsFriends", "trafficVehicles"]
    private var currentArrayIndex: Int = 0
    private var alertButtonTitleModel: AlertButtonModel?
    private var header: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initializeView()
    }
    
    // Initialising the view
    private func initializeView() {
        loadLanguageContent()
        initialiseButton()
        updateUI()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - Action methods
    @IBAction func onPreviousButtonClick(_ sender: Any) {
        self.currentArrayIndex = self.currentArrayIndex - 1
        self.updateUI()
    }
    
    @IBAction func onNextButtonClick(_ sender: Any) {
        if (self.imageArray.count - 1) > self.currentArrayIndex {
            self.currentArrayIndex = self.currentArrayIndex + 1
        }
        self.updateUI()
    }
    
    // MARK: - Other
    
    private func loadLanguageContent() {
        if LocalStorageManager.shared.selectedLanguage == Constants.kLanguageKey.eEnglish.rawValue {
            header = "Speak about this picture"
            alertButtonTitleModel = AlertButtonModel()
            alertButtonTitleModel?.next = Constants.kAlertButtonTitleKey_English.eNext.rawValue
            alertButtonTitleModel?.finish = Constants.kAlertButtonTitleKey_English.eFinish.rawValue
            alertButtonTitleModel?.previous = Constants.kAlertButtonTitleKey_English.ePrevious.rawValue
        } else {
            header = "Habla de esta imagen"
            alertButtonTitleModel = AlertButtonModel()
            alertButtonTitleModel?.next = Constants.kAlertButtonTitleKey_Spanish.eNext.rawValue
            alertButtonTitleModel?.finish = Constants.kAlertButtonTitleKey_Spanish.eFinish.rawValue
            alertButtonTitleModel?.previous = Constants.kAlertButtonTitleKey_Spanish.ePrevious.rawValue
        }
    }
    
    private func initialiseButton() {
        self.previousButton.setTitle(self.alertButtonTitleModel?.previous, for: .normal)
        self.nextButton.setTitle(self.alertButtonTitleModel?.next, for: .normal)
    }
    
    private func updateUI() {
        self.headerLabel.text = self.header
        if self.currentArrayIndex == 0 {
            self.previousButton.isUserInteractionEnabled = false
        } else if self.currentArrayIndex == (imageArray.count - 1) {
            self.nextButton.isUserInteractionEnabled = false
            self.nextButton.setTitle(self.alertButtonTitleModel?.finish, for: .normal)
        } else {
            self.previousButton.isUserInteractionEnabled = true
            self.nextButton.isUserInteractionEnabled = true
            self.nextButton.setTitle(self.alertButtonTitleModel?.next, for: .normal)
        }
        self.pictureImageView.image = UIImage(named: self.imageArray[self.currentArrayIndex])
    }
}

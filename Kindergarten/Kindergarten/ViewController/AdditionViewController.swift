//
//  AdditionViewController.swift
//  Kindergarten
//

import UIKit

class AdditionViewController: UIViewController {
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    var additionArray: [ClassifyModel]?
    private var currentArrayIndex: Int = 0
    var messageModel: MessageModel?
    var alertButtonTitleModel: AlertButtonModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initializeView()
    }
    
    /// Initialising the view
    private func initializeView() {
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
        if ((self.additionArray?.count ?? 0) - 1) > self.currentArrayIndex {
            self.currentArrayIndex = self.currentArrayIndex + 1
        }
        self.updateUI()
    }
    
    @IBAction func onFirstButtonClick(_ sender: Any) {
        self.checkAnswer(answer: self.additionArray?[self.currentArrayIndex].options[0].answer ?? "")
    }
    
    @IBAction func onSecondButtonClick(_ sender: Any) {
        self.checkAnswer(answer: self.additionArray?[self.currentArrayIndex].options[1].answer ?? "")
    }
    
    @IBAction func onThirdButtonClick(_ sender: Any) {
        self.checkAnswer(answer: self.additionArray?[self.currentArrayIndex].options[2].answer ?? "")
    }

    // MARK: - Other
    
    private func initialiseButton() {
        self.previousButton.setTitle(self.alertButtonTitleModel?.previous, for: .normal)
        self.nextButton.setTitle(self.alertButtonTitleModel?.next, for: .normal)
    }
    
    private func updateUI() {
        self.headerLabel.text = self.additionArray?[self.currentArrayIndex].header
        if let additionArray = self.additionArray {
            if self.currentArrayIndex == 0 {
                self.previousButton.isUserInteractionEnabled = false
            } else if self.currentArrayIndex == (additionArray.count - 1) {
                self.nextButton.isUserInteractionEnabled = false
                self.nextButton.setTitle(self.alertButtonTitleModel?.finish, for: .normal)
            } else {
                self.previousButton.isUserInteractionEnabled = true
                self.nextButton.isUserInteractionEnabled = true
                self.nextButton.setTitle(self.alertButtonTitleModel?.next, for: .normal)
            }
            self.questionLabel.text = self.additionArray?[self.currentArrayIndex].title
            
            let firstButtonTitle = self.additionArray?[self.currentArrayIndex].options[0].title
            self.firstButton.setTitle(firstButtonTitle, for: .normal)
            
            let secondButtonTitle = self.additionArray?[self.currentArrayIndex].options[1].title
            self.secondButton.setTitle(secondButtonTitle, for: .normal)
            
            let thirdButtonTitle = self.additionArray?[self.currentArrayIndex].options[2].title
            self.thirdButton.setTitle(thirdButtonTitle, for: .normal)
        }
    }
    
    private func checkAnswer(answer: String) {
        if answer == "1" {
            AlertView().showAlertView(controller: self, title: "", message: self.messageModel?.success ?? "", okButtonTitle: self.alertButtonTitleModel?.yes, cancelButtonTitle: self.alertButtonTitleModel?.next, handler: { (action) in
                if action.title == self.alertButtonTitleModel?.next {
                    self.onNextButtonClick(self.nextButton)
                } else if action.title == self.alertButtonTitleModel?.yes {
                }
            })
        } else {
            AlertView().showAlertView(controller: self, title: "", message: self.messageModel?.fail ?? "", okButtonTitle: self.alertButtonTitleModel?.ok)
        }
    }
}

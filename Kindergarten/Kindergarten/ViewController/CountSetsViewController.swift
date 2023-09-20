//
//  CountSetsViewController.swift
//  Kindergarten
//
//  Created by Sandeep Vinay on 19/09/23.
//

import UIKit

class CountSetsViewController: UIViewController {
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var countSetImageView: UIImageView!
    var countSetsArray: [ClassifyModel]?
    private var currentArrayIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.updateUI()
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
        if ((self.countSetsArray?.count ?? 0) - 1) > self.currentArrayIndex {
            self.currentArrayIndex = self.currentArrayIndex + 1
        }
        self.updateUI()
    }
    
    @IBAction func onFirstButtonClick(_ sender: Any) {
        self.checkAnswer(answer: self.countSetsArray?[self.currentArrayIndex].options[0].answer ?? "")
    }
    
    @IBAction func onSecondButtonClick(_ sender: Any) {
        self.checkAnswer(answer: self.countSetsArray?[self.currentArrayIndex].options[1].answer ?? "")
    }
    
    @IBAction func onThirdButtonClick(_ sender: Any) {
        self.checkAnswer(answer: self.countSetsArray?[self.currentArrayIndex].options[2].answer ?? "")
    }

    // MARK: - Other
    
    private func updateUI() {
        self.headerLabel.text = self.countSetsArray?[self.currentArrayIndex].header
        if let countSetsArray = self.countSetsArray {
            if self.currentArrayIndex == 0 {
                self.previousButton.isUserInteractionEnabled = false
            } else if self.currentArrayIndex == (countSetsArray.count - 1) {
                self.nextButton.isUserInteractionEnabled = false
                self.nextButton.setTitle("Finish", for: .normal)
            } else {
                self.previousButton.isUserInteractionEnabled = true
                self.nextButton.isUserInteractionEnabled = true
                self.nextButton.setTitle("Next", for: .normal)
            }
            self.countSetImageView.image = UIImage(named: self.countSetsArray?[self.currentArrayIndex].imageName ?? "")
            
            let firstButtonTitle = self.countSetsArray?[self.currentArrayIndex].options[0].title
            self.firstButton.setTitle(firstButtonTitle, for: .normal)
            
            let secondButtonTitle = self.countSetsArray?[self.currentArrayIndex].options[1].title
            self.secondButton.setTitle(secondButtonTitle, for: .normal)
            
            let thirdButtonTitle = self.countSetsArray?[self.currentArrayIndex].options[2].title
            self.thirdButton.setTitle(thirdButtonTitle, for: .normal)
        }
    }
    
    private func checkAnswer(answer: String) {
        if answer == "1" {
            AlertView().showAlertView(controller: self, title: "", message: "Awesome! You did it. Do you want to play again?", okButtonTitle: "Yes", cancelButtonTitle: "Next", handler: { (action) in
                if action.title == "Next" {
                    self.onNextButtonClick(self.nextButton)
                } else if action.title == "Yes" {
                }
            })
        } else {
            AlertView().showAlertView(controller: self, title: "", message: "You selected wrong answer. Try again!")
        }
    }
}

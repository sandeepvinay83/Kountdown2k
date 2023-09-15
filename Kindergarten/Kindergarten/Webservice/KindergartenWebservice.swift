//
//  KindergartenWebservice.swift
//  Kindergarten
//
//  Created by Sandeep Vinay on 08/09/23.
//

import Foundation

final class KindergartenWebservice {
    
    // MARK: - Main Category
    
    /// main category json response will be in english language
    func mainCategoryApi_English() {
        let networkService = Networking()
        guard let mainCategoryModel: MainCategoryResponseModel = networkService.loadJson(filename: FileName.MainCategoryJson_English.rawValue) else {
            print("Could not read MainCategoryJson_English json")
            return
        }
        LocalStorageManager.shared.saveToLocalStorage(fileName: .MainCategoryJson_English, responseObject: mainCategoryModel)
    }
    
    /// main category json response will be in spanish language
    func mainCategoryApi_Spanish() {
        let networkService = Networking()
        guard let mainCategoryModel: MainCategoryResponseModel = networkService.loadJson(filename: FileName.MainCategoryJson_Spanish.rawValue) else {
            print("Could not read MainCategoryJson_Spanish json")
            return
        }
        LocalStorageManager.shared.saveToLocalStorage(fileName: .MainCategoryJson_Spanish, responseObject: mainCategoryModel)
    }
    
    // MARK: - Classify
    
    /// classify json response will be in english language
    func classifyApi_English() {
        let networkService = Networking()
        guard let classifyModel: ClassifyResponseModel = networkService.loadJson(filename: FileName.ClassifyJson_English.rawValue) else {
            print("Could not read ClassifyJson_English json")
            return
        }
        LocalStorageManager.shared.saveToLocalStorage(fileName: .ClassifyJson_English, responseObject: classifyModel)
    }
    
    /// classify json response will be in spanish language
    func classifyApi_Spanish() {
        let networkService = Networking()
        guard let classifyModel: ClassifyResponseModel = networkService.loadJson(filename: FileName.ClassifyJson_Spanish.rawValue) else {
            print("Could not read ClassifyJson_Spanish json")
            return
        }
        LocalStorageManager.shared.saveToLocalStorage(fileName: .ClassifyJson_Spanish, responseObject: classifyModel)
    }
    
    // MARK: - Difference
    
    /// difference json response will be in english language
    func differenceApi_English() {
        let networkService = Networking()
        guard let differenceModel: DifferenceResponseModel = networkService.loadJson(filename: FileName.DifferenceJson_English.rawValue) else {
            print("Could not read DifferenceJson_English json")
            return
        }
        LocalStorageManager.shared.saveToLocalStorage(fileName: .DifferenceJson_English, responseObject: differenceModel)
    }
    
    /// difference json response will be in spanish language
    func differenceApi_Spanish() {
        let networkService = Networking()
        guard let differenceModel: DifferenceResponseModel = networkService.loadJson(filename: FileName.DifferenceJson_Spanish.rawValue) else {
            print("Could not read DifferenceJson_Spanish json")
            return
        }
        LocalStorageManager.shared.saveToLocalStorage(fileName: .DifferenceJson_Spanish, responseObject: differenceModel)
    }
    
    // MARK: - Basic Colors
    
    /// basic colors json response will be in english language
    func basicColorsApi_English() {
        let networkService = Networking()
        guard let basicColorsModel: BasicColorsResponseModel = networkService.loadJson(filename: FileName.BasicColorsJson_English.rawValue) else {
            print("Could not read BasicColorsJson_English json")
            return
        }
        LocalStorageManager.shared.saveToLocalStorage(fileName: .BasicColorsJson_English, responseObject: basicColorsModel)
    }
    
    /// basic colors json response will be in spanish language
    func basicColorsApi_Spanish() {
        let networkService = Networking()
        guard let basicColorsModel: BasicColorsResponseModel = networkService.loadJson(filename: FileName.BasicColorsJson_Spanish.rawValue) else {
            print("Could not read BasicColorsJson_Spanish json")
            return
        }
        LocalStorageManager.shared.saveToLocalStorage(fileName: .BasicColorsJson_Spanish, responseObject: basicColorsModel)
    }
    
    // MARK: - Identify Shape
    
    /// identifyShape json response will be in english language
    func identifyShapeApi_English() {
        let networkService = Networking()
        guard let identifyShapeModel: IdentifyShapeResponseModel = networkService.loadJson(filename: FileName.IdentifyShapeJson_English.rawValue) else {
            print("Could not read IdentifyShapeJson_English json")
            return
        }
        LocalStorageManager.shared.saveToLocalStorage(fileName: .IdentifyShapeJson_English, responseObject: identifyShapeModel)
    }
    
    /// identifyShape json response will be in spanish language
    func identifyShapeApi_Spanish() {
        let networkService = Networking()
        guard let identifyShapeModel: IdentifyShapeResponseModel = networkService.loadJson(filename: FileName.IdentifyShapeJson_Spanish.rawValue) else {
            print("Could not read IdentifyShapeJson_Spanish json")
            return
        }
        LocalStorageManager.shared.saveToLocalStorage(fileName: .IdentifyShapeJson_Spanish, responseObject: identifyShapeModel)
    }
}

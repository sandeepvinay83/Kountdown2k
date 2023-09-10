//
//  KindergartenWebservice.swift
//  Kindergarten
//
//  Created by Sandeep Vinay on 08/09/23.
//

import Foundation

final class KindergartenWebservice {
    /// kindergarten json response will be in english language
    func kindergartenApi_English() {
        let networkService = Networking()
        guard let kindergartenModel: KindergartenModel = networkService.loadJson(filename: FileName.KindergartenJson_English.rawValue) else {
            print("Could not read KindergartenJson json")
            return
        }
        LocalStorageManager.shared.saveToLocalStorage(fileName: .KindergartenJson_English, responseObject: kindergartenModel)
    }
    
    /// kindergarten json response will be in spanish language
    func kindergartenApi_Spanish() {
        let networkService = Networking()
        guard let kindergartenModel: KindergartenModel = networkService.loadJson(filename: FileName.KindergartenJson_Spanish.rawValue) else {
            print("Could not read KindergartenJson json")
            return
        }
        LocalStorageManager.shared.saveToLocalStorage(fileName: .KindergartenJson_Spanish, responseObject: kindergartenModel)
    }
}

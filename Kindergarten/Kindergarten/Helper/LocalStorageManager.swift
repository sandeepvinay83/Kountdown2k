//
//  LocalStorageManager.swift
//  Kindergarten
//

import Foundation

// files name used to save model data
enum FileName: String {
    case MainCategoryJson_English = "mainCategoryJson_English"
    case MainCategoryJson_Spanish = "mainCategoryJson_Spanish"
    case ClassifyJson_English = "classifyJson_English"
    case ClassifyJson_Spanish = "classifyJson_Spanish"
    case DifferenceJson_English = "differencesJson_English"
    case DifferenceJson_Spanish = "differencesJson_Spanish"
    case BasicColorsJson_English = "basicColorsJson_English"
    case BasicColorsJson_Spanish = "basicColorsJson_Spanish"
    case IdentifyShapeJson_English = "identifyShapeJson_English"
    case IdentifyShapeJson_Spanish = "identifyShapeJson_Spanish"
    case CountSetsJson_English = "countSetsJson_English"
    case CountSetsJson_Spanish = "countSetsJson_Spanish"
    case AdditionJson_English = "additionJson_English"
    case AdditionJson_Spanish = "additionJson_Spanish"
    case WordImageJson_English = "wordImageJson_English"
    case WordImageJson_Spanish = "wordImageJson_Spanish"
    case UserJson_English = "userJson_English"
    
}

final class LocalStorageManager {
    static let shared = LocalStorageManager()
    /// save user get model to local storage
    /// - Parameters:
    ///   - fileName: file name
    ///   - responseObject: model type
    func saveToLocalStorage<T: Codable>(fileName: FileName, responseObject: T) {
        do {
            let fileManger = FileManager.default
            let fileURL = try fileManger
                .url(for: .applicationSupportDirectory,
                     in: .userDomainMask,
                     appropriateFor: nil,
                     create: true)
                .appendingPathComponent(fileName.rawValue)
            //            if fileManger.fileExists(atPath: fileURL.path) {
            //                try fileManger.removeItem(atPath: fileURL.path)
            //            }
            let encoder = try JSONEncoder().encode(responseObject)
            try encoder.write(to: fileURL, options: .atomic)
        } catch {
            print("JSONSave error of \(error)")
        }
    }
    
    /// reads locally saved model data
    /// - Parameter fileName: file name
    func readFromLocalStorage<T: Codable>(fileName: FileName) -> T? {
        do {
            let fileManger = FileManager.default
            let fileURL = try fileManger
                .url(for: .applicationSupportDirectory,
                     in: .userDomainMask,
                     appropriateFor: nil,
                     create: true)
                .appendingPathComponent(fileName.rawValue)
            let data = try Data(contentsOf: fileURL)
            let object = try JSONDecoder().decode(T.self, from: data)
            return object
        } catch {
            return nil
        }
    }
    
    func removeFromLocalStorage(fileName: FileName) {
        do {
            let fileManger = FileManager.default
            let fileURL = try fileManger
                .url(for: .applicationSupportDirectory,
                     in: .userDomainMask,
                     appropriateFor: nil,
                     create: true)
                .appendingPathComponent(fileName.rawValue)
            try fileManger.removeItem(at: fileURL)
        } catch {
            return
        }
    }
    
    /// Set / Get for selected language
    var selectedLanguage: String? {
        get {
            return UserDefaults.standard.string(forKey: Constants.kUserDefaultsKey.eLanguageSelection.rawValue)
        }
        set (value) {
            UserDefaults.standard.set(value, forKey: Constants.kUserDefaultsKey.eLanguageSelection.rawValue)
        }
    }
    
    /// Set / Get for selected username
    var selectedUsername: String? {
        get {
            return UserDefaults.standard.string(forKey: Constants.kUserDefaultsKey.eUsername.rawValue)
        }
        set (value) {
            UserDefaults.standard.set(value, forKey: Constants.kUserDefaultsKey.eUsername.rawValue)
        }
    }
}

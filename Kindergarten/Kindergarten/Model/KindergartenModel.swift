//
//  KindergartenModel.swift
//  Kindergarten
//

import Foundation

// MARK: - MainCategory Model

struct MainCategoryResponseModel: Codable {
    var mainCategoryArray: [MainCategoryModel]
    private enum CodingKeys: String, CodingKey {
        case mainCategoryArray = "MainCategory"
    }
}

struct MainCategoryModel: Codable {
    var name: String
    var values: [String]
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case values = "values"
    }
}

// MARK: - Classify Model

struct ClassifyResponseModel: Codable {
    var classifyArray: [ClassifyModel]
    var message: MessageModel?
    private enum CodingKeys: String, CodingKey {
        case classifyArray = "Classify"
        case message = "Message"
    }
}

struct ClassifyModel: Codable {
    var title: String
    var header: String
    var imageName: String?
    var options: [OptionModel]
    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case header = "header"
        case imageName = "imageName"
        case options = "options"
    }
}

struct OptionModel: Codable {
    var imageName: String?
    var answer: String
    var title: String?
    private enum CodingKeys: String, CodingKey {
        case imageName = "imageName"
        case answer = "answer"
        case title = "title"
    }
}

// MARK: - Difference Model

struct DifferenceResponseModel: Codable {
    var differenceArray: [ClassifyModel]
    var message: MessageModel?
    private enum CodingKeys: String, CodingKey {
        case differenceArray = "Difference"
        case message = "Message"
    }
}

// MARK: - Basic Colors Model

struct BasicColorsResponseModel: Codable {
    var basicColorsArray: [ClassifyModel]
    var message: MessageModel?
    private enum CodingKeys: String, CodingKey {
        case basicColorsArray = "BasicColors"
        case message = "Message"
    }
}

// MARK: - Identify Shape Model

struct IdentifyShapeResponseModel: Codable {
    var identifyShapeArray: [ClassifyModel]
    var message: MessageModel?
    private enum CodingKeys: String, CodingKey {
        case identifyShapeArray = "IdentifyShape"
        case message = "Message"
    }
}

// MARK: - Count Sets Model

struct CountSetsResponseModel: Codable {
    var countSetsArray: [ClassifyModel]
    var message: MessageModel?
    private enum CodingKeys: String, CodingKey {
        case countSetsArray = "CountSets"
        case message = "Message"
    }
}

// MARK: - Addition Model

struct AdditionResponseModel: Codable {
    var additionArray: [ClassifyModel]
    var message: MessageModel?
    private enum CodingKeys: String, CodingKey {
        case additionArray = "Addition"
        case message = "Message"
    }
}

// MARK: - Word Image Model

struct WordImageResponseModel: Codable {
    var wordImageArray: [ClassifyModel]
    var message: MessageModel?
    private enum CodingKeys: String, CodingKey {
        case wordImageArray = "WordImage"
        case message = "Message"
    }
}

// MARK: - User Model

struct UserResponseModel: Codable {
    var users: [UserModel]?
    private enum CodingKeys: String, CodingKey {
        case users = "Users"
    }
}

struct UserModel: Codable {
    var username: String?
    var password: String?
    var fullName: String?
    var email: String?
    private enum CodingKeys: String, CodingKey {
        case username = "username"
        case password = "password"
        case fullName = "fullName"
        case email = "email"
    }
}

// MARK: - Message Model

struct MessageModel: Codable {
    var success: String?
    var fail: String?
    private enum CodingKeys: String, CodingKey {
        case success = "success"
        case fail = "fail"
    }
}

// MARK: - Alert Button Model

struct AlertButtonModel {
    var ok: String?
    var yes: String?
    var no: String?
    var next: String?
    var finish: String?
    var previous: String?
}

//struct AlertButtonModel: Codable {
//    var ok: String?
//    var yes: String?
//    var no: String?
//    private enum CodingKeys: String, CodingKey {
//        case ok = "ok"
//        case yes = "yes"
//        case no = "no"
//    }
//}

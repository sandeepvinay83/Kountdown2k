//
//  KindergartenModel.swift
//  Kindergarten
//
//  Created by Sandeep Vinay on 08/09/23.
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
    private enum CodingKeys: String, CodingKey {
        case classifyArray = "Classify"
    }
}

struct ClassifyModel: Codable {
    var title: String
    var header: String
    var options: [OptionModel]
    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case header = "header"
        case options = "options"
    }
}

struct OptionModel: Codable {
    var imageName: String
    var answer: String
    private enum CodingKeys: String, CodingKey {
        case imageName = "imageName"
        case answer = "answer"
    }
}

// MARK: - Difference Model

struct DifferenceResponseModel: Codable {
    var differenceArray: [ClassifyModel]
    private enum CodingKeys: String, CodingKey {
        case differenceArray = "Difference"
    }
}

// MARK: - Basic Colors Model

struct BasicColorsResponseModel: Codable {
    var basicColorsArray: [ClassifyModel]
    private enum CodingKeys: String, CodingKey {
        case basicColorsArray = "BasicColors"
    }
}

// MARK: - Identify Shape Model

struct IdentifyShapeResponseModel: Codable {
    var identifyShapeArray: [ClassifyModel]
    private enum CodingKeys: String, CodingKey {
        case identifyShapeArray = "IdentifyShape"
    }
}

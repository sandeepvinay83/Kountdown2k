//
//  KindergartenModel.swift
//  Kindergarten
//
//  Created by Sandeep Vinay on 08/09/23.
//

import Foundation

struct KindergartenModel: Codable {
    var mainCategory: [MainCategoryModel]
    private enum CodingKeys: String, CodingKey {
        case mainCategory = "MainCategory"
    }
}

struct MainCategoryModel: Codable {
    var name: String
    var values: [String]
    private enum CodingKeys: String, CodingKey {
        case name = "Name"
        case values = "Values"
    }
}

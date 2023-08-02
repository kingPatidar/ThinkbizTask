//
//  Category.swift
//  TestiTuneDemo
//
//  Created by Apple on 02/08/23.
//

import Foundation

struct CategoryBaseModel : Codable {
    let categoryName : String?
    let categoryId : String?
    let data : [Data]?

    enum CodingKeys: String, CodingKey {

        case categoryName = "category-name"
        case categoryId = "category-id"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categoryName = try values.decodeIfPresent(String.self, forKey: .categoryName)
        categoryId = try values.decodeIfPresent(String.self, forKey: .categoryId)
        data = try values.decodeIfPresent([Data].self, forKey: .data)
    }

}

struct Data : Codable {
    let subcategoryId : String?
    let subcategoryName : String?
    let url : String?

    enum CodingKeys: String, CodingKey {

        case subcategoryId = "subcategory-id"
        case subcategoryName = "subcategory-name"
        case url = "url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        subcategoryId = try values.decodeIfPresent(String.self, forKey: .subcategoryId)
        subcategoryName = try values.decodeIfPresent(String.self, forKey: .subcategoryName)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }

}

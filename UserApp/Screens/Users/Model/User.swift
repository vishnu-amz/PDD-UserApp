//
//  User.swift
//  UserApp
//
//  Created by Vishnu - iOS on 10/10/23.
//

import Foundation

// MARK: - User
struct User: Codable {
    var page, perPage, total, totalPages: Int?
    var data: [UserData]
    let support: Support?
    
    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data, support
    }
}

// MARK: - UserData
struct UserData: Codable {
    let id: Int?
    var email, firstName, lastName: String?
    let avatar: String?
    
    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}

// MARK: - Support
struct Support: Codable {
    let url: String?
    let text: String?
}

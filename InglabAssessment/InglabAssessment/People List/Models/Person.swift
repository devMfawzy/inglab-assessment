//
//  Person.swift
//  InglabAssessment
//
//  Created by Mohamed Fawzy on 09/10/2022.
//

import Foundation

struct Person: Decodable {
    let avatar: String
    let name: String
    let phone: String
    let isActive: Bool
    let index: Int
}

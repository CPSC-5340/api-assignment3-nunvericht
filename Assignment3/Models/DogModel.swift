//
//  DogModel.swift
//  Assignment3
//
//  Created by Nicholl Unvericht on 3/28/24.
//

import Foundation

struct DogResults : Codable {
    let breeds: [DogModel]
    let url: String
    let id: String
}

struct DogModel : Codable, Identifiable {
    let id: Int
    let name: String
    let weight: DogWeight
    let height: DogHeight
    let bred_for: String
    let breed_group: String?
    let life_span: String
    let temperament: String
}

struct DogWeight : Codable {
    let imperial: String
    let metric: String
}

struct DogHeight : Codable {
    let imperial: String
    let metric: String
}

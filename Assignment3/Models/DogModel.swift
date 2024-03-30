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

// utilizes UUID since ID may be duplicated
struct DogModel : Codable, Identifiable {
    var id : UUID {
        return UUID()
    }
    let name: String
    let weight: DogWeight
    let height: DogHeight
    let breed_group: String?
    let bred_for: String
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

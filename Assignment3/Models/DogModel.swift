//
//  DogModel.swift
//  Assignment3
//
//  Created by Nicholl Unvericht on 3/28/24.
//

import Foundation

struct DogResults : Codable {
    let breeds: [DogModel]  
    let id: String
    let url: String
    let width: Int
    let height: Int
}

struct DogModel : Codable, Identifiable {
    let id: String
    let name: String
    let weight: DogWeight
    let height: DogHeight
    //let country_code: String?
    let bred_for: String
    let breed_group: String
    let life_span: String
    let temperament: String
    let origin: String?
    let reference_image_id: String
}

struct DogWeight : Codable {
    let imperial: String
    let metric: String
}

struct DogHeight : Codable {
    let imperial: String
    let metric: String
}

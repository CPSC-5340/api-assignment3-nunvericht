//
//  DogsViewModel.swift
//  Assignment3
//
//  Created by Nicholl Unvericht on 3/28/24.
//

import Foundation


class DogsViewModel : ObservableObject {
    @Published private(set) var dogBreeds = [DogModel]()
    //@Published private(set) var jsonData = [[String: Any]]()
    @Published private(set) var dogImage: String = "https://cdn2.thedogapi.com/images/Sy57xx9EX_1280.jpg"
    
    @Published var hasError = false
    
    @Published var error : DogModelError?
    
    private let url = "https://api.thedogapi.com/v1/images/search?limit=10&has_breeds=1&ASC&api_key=live_dol1qAd0D537Mg7sAefdiNUO7YdHErkkyac39Io7mVnqvQCda3makEkQ9mI56GRS"
    //private let url = "https://api.thedogapi.com/v1/images/ROvy59azW"
    
    @MainActor
    func fetchData() async {
        if let url = URL(string: url) {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                //guard let results = try JSONDecoder().decode(DogResults?.self, from: data) else {
                //guard let results = try JSONSerialization.jsonObject(with: data) as? [[String: Any]] else {
                guard let results = try JSONDecoder().decode([DogResults]?.self, from: data) else {
                    self.hasError.toggle()
                    self.error = DogModelError.decodeError
                    return
                }
                /*self.dogBreeds = results.breeds
                self.dogImage = results.url
                print(self.dogImage)
                print(results)*/
                /*self.jsonData = results
                print(results)
                if let firstBreed = jsonData.first?["breeds"] as? [[String: Any]],
                    let breedName = firstBreed.first?["name"] as? String {
                        print("Breed name: \(breedName)")
                    }
                 else {
                    self.hasError.toggle()
                    self.error = DogModelError.invalidData
                 }*/
                for result in results {
                    self.dogBreeds.append(contentsOf: result.breeds)
                }
                print(dogBreeds)
            }
            catch {
                self.hasError.toggle()
                self.error = DogModelError.customError(error: error)
            }
        }
    }
}

extension DogsViewModel {
    enum DogModelError : LocalizedError {
        
        case decodeError
        case invalidData
        case customError(error: Error)
        
        var errorDescription: String? {
            switch self {
            case .decodeError:
                return "Decoding Error"
            case .invalidData:
                return "Invalid Data"
            case .customError(let error):
                return error.localizedDescription
            }
        }
    }
}


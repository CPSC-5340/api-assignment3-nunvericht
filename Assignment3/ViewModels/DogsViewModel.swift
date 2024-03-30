//
//  DogsViewModel.swift
//  Assignment3
//
//  Created by Nicholl Unvericht on 3/28/24.
//

import Foundation


class DogsViewModel : ObservableObject {
    
    @Published private(set) var dogBreeds = [DogModel]()
    
    // array to store image urls
    @Published private(set) var imageArray = [String]()
    
    @Published var hasError = false
    
    @Published var error : DogModelError?
    
    // Boolean to stop after 10, since api returns random results
    private var hasFetchedData = false
    
    private let url = "https://api.thedogapi.com/v1/images/search?limit=10&has_breeds=1&page=0&api_key=live_dol1qAd0D537Mg7sAefdiNUO7YdHErkkyac39Io7mVnqvQCda3makEkQ9mI56GRS"
    
    @MainActor
    func fetchData() async {

        guard !hasFetchedData else { return }
        
        if let apiUrl = URL(string: url) {
            do {
                let (data, _) = try await URLSession.shared.data(from: apiUrl)
                guard let results = try JSONDecoder().decode([DogResults]?.self, from: data) else {
                    self.hasError.toggle()
                    self.error = DogModelError.decodeError
                    return
                }
                for result in results {
                    self.imageArray.append(result.url)
                    self.dogBreeds.append(contentsOf: result.breeds)
                }
                hasFetchedData = true
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
        case customError(error: Error)
        
        var errorDescription: String? {
            switch self {
            case .decodeError:
                return "Decoding Error"
            case .customError(let error):
                return error.localizedDescription
            }
        }
    }
}


/* test code for one item only
private let url = "https://api.thedogapi.com/v1/images/ROvy59azW"
guard let results = try JSONDecoder().decode(DogResults?.self, from: data) else {

self.dogBreeds = results.breeds
self.dogImage = results.url
print(self.dogImage)
print(results)
self.jsonData = results
print(results)*/


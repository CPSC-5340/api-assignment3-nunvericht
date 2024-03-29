//
//  DogsViewModel.swift
//  Assignment3
//
//  Created by Nicholl Unvericht on 3/28/24.
//

import Foundation

class DogsViewModel : ObservableObject {
    @Published private(set) var dogBreed = [DogModel]()
    
    @Published private(set) var jsonData = []
    
    @Published var hasError = false
    
    @Published var error : DogModelError?
    
    private let url = "https://api.thedogapi.com/v1/images/search?limit=2&has_breeds=1&api_key=live_dol1qAd0D537Mg7sAefdiNUO7YdHErkkyac39Io7mVnqvQCda3makEkQ9mI56GRS"

    @MainActor
    func fetchData() async {
        if let url = URL(string: url) {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let json = try JSONDecoder().decode([DogResults].self, from: data)
                self.jsonData = json
            } catch {
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


//@MainActor
/*func fetchData() async {
    if let url = URL(string: url) {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let results = try JSONDecoder().decode(DogResults?.self, from: data) else {
                self.hasError.toggle()
                self.error = DogModelError.decodeError
                return
            }
            self.dogData = results.breeds
        }
        catch {
            self.hasError.toggle()
            self.error = DogModelError.customError(error: error)
        }
    }
}
}
func fetchData() {
    if let url = URL(string: url) {
        URLSession
            .shared
            .dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print(error)
                }
                else {
                    if let data = data {
                        do {
                            let results = try JSONDecoder().decode(DogResults.self, from: data)
                            self.dogData = results.breeds
                        }
                        catch {
                            print(error)
                        }
                    }
                }
            }
        .resume()
    }
}*/

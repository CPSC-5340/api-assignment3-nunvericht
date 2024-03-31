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
    
    // Boolean to stop after 14, since api returns random results
    private var hasFetchedData = false
    
    // Track unique IDs using a set as data contains duplicate IDs(dog breeds with different pictures)
    private var uniqueIds = Set<Int>()
    
    private let url = "https://api.thedogapi.com/v1/images/search?limit=15&has_breeds=1&api_key=live_dol1qAd0D537Mg7sAefdiNUO7YdHErkkyac39Io7mVnqvQCda3makEkQ9mI56GRS"
    
    @MainActor
    func fetchData() async {
        
        guard !hasFetchedData else {
            return
        }
        
        // variables for network delays
        var retries = 0
        let initialDelay = 1
        let maxDelay = 8

        var retryDelay = initialDelay

        while retries < 3 && !hasFetchedData{
            if let apiUrl = URL(string: url) {
                do {
                    let (data, _) = try await URLSession.shared.data(from: apiUrl)
                    guard let results = try JSONDecoder().decode([DogResults]?.self, from: data) else {
                        handleError(DogModelError.decodeError)
                        return
                    }
                    for result in results {
                        let id = result.breeds.first?.id ?? 0
                        if !uniqueIds.contains(id) && dogBreeds.count < 15 {
                            imageArray.append(result.url)
                            dogBreeds.append(contentsOf: result.breeds)
                            uniqueIds.insert(id)
                        }
                    }
                    hasFetchedData = true
                    hasError = false
                    return
                }
                catch {
                    handleError(DogModelError.customError(error: error))
                }
            }
            do {
                try await Task.sleep(nanoseconds: UInt64(retryDelay) * 1_000_000_000)
                retryDelay = min(retryDelay * 2, maxDelay)
                retries += 1
            }
            catch {
                handleError(DogModelError.timedOut)
            }
         }
        handleError(DogModelError.timedOut)
    }
    private func handleError(_ error: DogModelError) {
        hasError = true
        self.error = error
    }
}


extension DogsViewModel {
    enum DogModelError : LocalizedError {
        
        case decodeError
        case customError(error: Error)
        case timedOut
        
        var errorDescription: String? {
            switch self {
            case .decodeError:
                return "Decoding Error"
            case .customError(let error):
                return error.localizedDescription
            case .timedOut:
                return "Network Timed Out"
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


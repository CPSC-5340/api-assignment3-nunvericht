//
// Dog.swift : Assignment3
//
// Created by Nicholl Unvericht on 3/27/24.


import SwiftUI


struct Dogs: View {
    
    @ObservedObject var dogsvm = DogsViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(dogsvm.dogBreeds) {
                    dog in
                    NavigationLink {
                        DogDetail(dogModel: dog, dogImage: dogsvm.dogImage)
                    }
                    label: {
                    Text(dog.name)
                    }
                }
            }
            .task {
                    await dogsvm.fetchData()
            }
            .listStyle(.grouped)
            .navigationTitle("Dogs")
            .alert(isPresented: $dogsvm.hasError, error: dogsvm.error) {
                Text("")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Dogs()
    }
}

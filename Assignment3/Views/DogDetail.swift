//
//  DogDetail.swift
//  Assignment3
//
//  Created by Nicholl Unvericht on 3/28/24.
//

import SwiftUI

struct DogDetail: View {
    
    var dog : DogModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(dog.name)
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .center)
                DogImageView(url: "https://cdn2.thedogapi.com/images/Sy57xx9EX_1280.jpg")
                    .frame(maxWidth: .infinity, alignment: .center)
                Text("Bred For: \(dog.bred_for)")
                    .font(.system(size:20))
                    .padding(.horizontal)
                Text("Life Span: \(dog.life_span)")
                    .font(.system(size:20))
                    .padding(.horizontal)
                Text("Temperament: \(dog.temperament)")
                    .padding(.horizontal)
            }
        }
    }
}

struct DogDetail_Previews: PreviewProvider {
    static var previews: some View {
        DogDetail(dog: DogModel(
                id: "unique_id",
                name: "Basset Hound",
                weight: DogWeight(imperial: "50 - 65", metric: "23 - 29"),
                height: DogHeight(imperial: "14", metric: "36"),
                bred_for: "Hunting by scent",
                breed_group: "Hound",
                life_span: "12 - 15 years",
                temperament: "Tenacious, Friendly, Affectionate, Devoted, Sweet-Tempered, Gentle",
                origin: nil,
                reference_image_id: "Sy57xx9EX"
        ))
    }
}

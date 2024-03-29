//
//  DogDetail.swift
//  Assignment3
//
//  Created by Nicholl Unvericht on 3/28/24.
//

import SwiftUI


struct DogDetail: View {
    
    var dogModel : DogModel
    
    var dogImage : String = "https://cdn2.thedogapi.com/images/Sy57xx9EX_1280.jpg"

    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(dogModel.name)
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .center)
                DogImageView(url: dogImage)
                    .frame(maxWidth: .infinity, alignment: .center)
                Text("Bred For: \(dogModel.bred_for)")
                    .font(.system(size:20))
                    .padding(.horizontal)
                Text("Life Span: \(dogModel.life_span)")
                    .font(.system(size:20))
                    .padding(.horizontal)
                Text("Temperament: \(dogModel.temperament)")
                    .padding(.horizontal)
            }
        }
    }
}

struct DogDetail_Previews: PreviewProvider {
    static var previews: some View {
        DogDetail(dogModel: DogModel(id: 15345345,
                name: "Basset Hound",
                weight: DogWeight(imperial: "50 - 65", metric: "23 - 29"),
                height: DogHeight(imperial: "14", metric: "36"),
                bred_for: "Hunting by scent",
                breed_group: "Hound",
                life_span: "12 - 15 years",
                temperament: "Tenacious, Friendly, Affectionate, Devoted, Sweet-Tempered, Gentle"
        ))
    }
}

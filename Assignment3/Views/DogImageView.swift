//
//  DogImage.swift
//  Assignment3
//
//  Created by Nicholl Unvericht on 3/28/24.
//

import SwiftUI

struct DogImageView: View {
    
    var url: String
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { image in image.resizable()
            .scaledToFit()
            .cornerRadius(10)
            .frame(width: 300, height: 300)
        }
        placeholder: {
            ProgressView()
        }
    }
}

struct DogImageView_Previews: PreviewProvider {
    static var previews: some View {
        DogImageView(url: "https://cdn2.thedogapi.com/images/quiHq2FiB.jpg")
    }
}

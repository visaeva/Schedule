//
//  StoriesView.swift
//  Schedule
//
//  Created by Victoria Isaeva on 07.04.2024.
//

import SwiftUI

struct StoriesCellView: View {
    
    let imageHeight: Double = 140
    let imageWidth: Double = 92
    let images = ["1", "2", "3", "4"]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(images, id: \.self) { imageName in
                    ZStack(alignment: .bottomLeading) {
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: imageWidth, height: imageHeight)
                            .cornerRadius(16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color("blueUniversal"), lineWidth: 4)
                            )
                        Text("Text Text\nText Text\nText Text Text")
                            .font(.system(size: 12, weight: .regular))
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.white)
                            .lineLimit(3)
                            .padding(8)
                    }
                }
            }
            
        }
    }
}

#Preview {
    StoriesCellView()
}

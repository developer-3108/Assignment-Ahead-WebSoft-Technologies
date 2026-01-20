//
//  ContentBoxView.swift
//  Assignment
//
//  Created by Akshat Srivastava on 20/01/26.
//

import SwiftUI

struct ContentBoxView: View {
    let imageURL: String
    let title: String
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            if let url = URL(string: imageURL) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: 25, maxHeight: 25)
                } placeholder: {
                    ProgressView()
                }
            }
            
            Text(title)
                .foregroundStyle(.black)
                .font(.subheadline)
                .fontWeight(.bold)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 80)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.2), radius: 1)
        )
    }
}

//#Preview {
//    ContentBoxView()
//}

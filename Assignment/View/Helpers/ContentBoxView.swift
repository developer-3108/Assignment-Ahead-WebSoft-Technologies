//
//  ContentBoxView.swift
//  Assignment
//
//  Created by Akshat Srivastava on 20/01/26.
//

import SwiftUI

struct ContentBoxView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Image(systemName: "globe.fill")
                .foregroundStyle(.indigo)
            
            Text("Message")
                .foregroundStyle(.black)
                .font(.subheadline)
                .fontWeight(.bold)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 70)
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

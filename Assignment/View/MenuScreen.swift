//
//  MenuScreen.swift
//  Assignment
//
//  Created by Akshat Srivastava on 20/01/26.
//

import SwiftUI

struct MenuScreen: View {
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            headerBar
            
            UserProfile()
            
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(0..<10, id: \.self) { _ in
                    ContentBoxView()
                }
            }
            .padding(.horizontal)
        }
        .showBackgroundView()
    }
    
    var headerBar: some View {
        HStack {
            Text("Menu")
                .foregroundStyle(.primary)
                .font(.title)
                .fontWeight(.bold)
            
            Spacer()
            
            languageSelector
            
            searchIcon
        }
        .padding(.horizontal)
    }
    
    var languageSelector: some View {
        HStack {
            Image(systemName: "globe.fill")
                
            Text("IND-INR-EN")
            
            Image(systemName: "chevron.down")
        }
        .font(.callout)
        .foregroundStyle(.black)
        .padding(10)
        .background(Capsule().fill(Color(.systemGray4)))
    }
    
    var searchIcon: some View {
        Image(systemName: "magnifyingglass")
            .padding(10)
            .background(Circle().fill(Color(.systemGray4)))
            .font(.callout)
            .foregroundStyle(.black)
    }
}

//#Preview {
//    MenuScreen()
//}

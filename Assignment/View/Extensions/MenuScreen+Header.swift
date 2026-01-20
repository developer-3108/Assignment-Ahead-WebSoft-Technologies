//
//  MenuScreen+Header.swift
//  Assignment
//
//  Created by Akshat Srivastava on 21/01/26.
//

import SwiftUI

extension MenuScreen {
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
        .background(Capsule().fill(Color(.systemGray5)))
    }
    
    var searchIcon: some View {
        Image(systemName: "magnifyingglass")
            .padding(10)
            .background(Circle().fill(Color(.systemGray5)))
            .font(.callout)
            .fontWeight(.bold)
            .foregroundStyle(.black)
    }
}

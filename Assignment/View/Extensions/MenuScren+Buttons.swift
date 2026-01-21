//
//  MenuScren+Buttons.swift
//  Assignment
//
//  Created by Akshat Srivastava on 21/01/26.
//

import Foundation
import SwiftUI

extension MenuScreen {
    var SeeMoreButton: some View {
        Text("See More")
            .foregroundStyle(.black)
            .font(.subheadline)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity)
            .padding(5)
            .background(RoundedRectangle(cornerRadius: 5).fill(Color(.systemGray5)))
    }
    
    @ViewBuilder
    func ActionButtonView(menu: Menu) -> some View {
        if menu.class == "core_main_sesapi_rate" {
            
            HStack {
                if let url = URL(string: menu.icon) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 25, height: 25)
                    } placeholder: {
                        ProgressView()
                    }
                }
                
                Text(menu.label)
                    .foregroundStyle(.black)
                    .font(.subheadline)
                    .fontWeight(.bold)
            }
            .frame(maxWidth: .infinity)
            .padding(7)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color(.white))
                    .shadow(color: .black.opacity(0.2), radius: 1)
            )
            
        } else if menu.class == "core_mini_auth" {
            
            Text(menu.label)
                .foregroundStyle(.red)
                .font(.subheadline)
                .frame(maxWidth: .infinity)
                .padding(7)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.red, lineWidth: 1)
                )
        }
    }
}

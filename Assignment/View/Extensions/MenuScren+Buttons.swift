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
    
    var SignOutButton: some View {
        Text("Sign Out")
            .foregroundStyle(.red)
            .font(.subheadline)
            .frame(maxWidth: .infinity)
            .padding(5)
            .background(RoundedRectangle(cornerRadius: 5).stroke(.red, lineWidth: 1))
    }
}

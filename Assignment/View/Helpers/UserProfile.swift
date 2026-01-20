//
//  UserProfile.swift
//  Assignment
//
//  Created by Akshat Srivastava on 20/01/26.
//

import SwiftUI

struct UserProfile: View {
    var body: some View {
        HStack {
            Image("profile")
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 50, height: 50)
            
            Text("Louis Gonzales")
                .font(.callout)
                .foregroundStyle(.black)
            
            Spacer()
            
            Button {
                
            } label: {
                Text("Edit Profile")
                    .font(.subheadline)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 70)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.2), radius: 1)
        )
        .padding(.horizontal)
    }
}

//#Preview {
//    UserProfile()
//}

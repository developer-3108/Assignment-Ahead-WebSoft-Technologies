//
//  UserProfile.swift
//  Assignment
//
//  Created by Akshat Srivastava on 20/01/26.
//

import SwiftUI

/// User profile display component
/// Shows profile image, user name, and edit profile button
/// Note: Since loggedin_user_id was 0 in API response, a custom placeholder image is used
struct UserProfile: View {
    var body: some View {
        HStack {
            // Profile image - circular shape
            // Uses local asset since loggedin_user_id was 0 in API
            Image("profile")
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 50, height: 50)
            
            // User name display
            Text("Louis Gonzales")
                .font(.callout)
                .foregroundStyle(.black)
            
            Spacer()
            
            // Edit Profile button
            // Action handler can be added here for edit functionality
            Button {
                // TODO: Implement edit profile action
            } label: {
                Text("Edit Profile")
                    .font(.subheadline)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 70)
        // White card background with shadow matching ContentBoxView style
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

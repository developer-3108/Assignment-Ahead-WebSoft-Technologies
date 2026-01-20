//
//  LoadingView.swift
//  Assignment
//
//  Created by Akshat Srivastava on 21/01/26.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .primary))
                .scaleEffect(1.5)
        }
    }
}

extension View {
    func showLoadingView(_ isLoading: Bool) -> some View {
        ZStack {
            self
                .disabled(isLoading)
            
            if isLoading {
                LoadingView()
            }
        }
    }
}

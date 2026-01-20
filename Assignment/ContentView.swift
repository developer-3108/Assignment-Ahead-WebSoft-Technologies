//
//  ContentView.swift
//  Assignment
//
//  Created by Akshat Srivastava on 20/01/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var showLoadingAnimation = LoadingAnimationHelper.shared
    var body: some View {
        VStack {
            MenuScreen()
        }
        .showLoadingView(showLoadingAnimation.isLoading)
    }
}


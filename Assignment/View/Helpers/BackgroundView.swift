//
//  BackgroundView.swift
//  Assignment
//
//  Created by Akshat Srivastava on 20/01/26.
//

import SwiftUI
import UIKit

struct BackgroundView: View {
    var body: some View {
        Color.init(red: 242/255, green: 243/255, blue: 247/255)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
    }
}

extension View {
    func showBackgroundView() -> some View {
        ZStack {
            BackgroundView()
            
            self
        }
    }
}

//#Preview {
//    BackgroundView()
//}

//
//  BackgroundView.swift
//  Cat-alogue
//
//  Created by Kazim Ahmad on 15/10/2025.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        ZStack {
            Image(Constants.imageBackground)
                .resizable()
            LinearGradient(colors: [.clear,
                                    .accentColor.opacity(0.3)],
                           startPoint: .leading,
                           endPoint: .trailing)
        }
        .opacity(0.3)
        .edgesIgnoringSafeArea(.vertical)
    }
}

#Preview {
    BackgroundView()
}

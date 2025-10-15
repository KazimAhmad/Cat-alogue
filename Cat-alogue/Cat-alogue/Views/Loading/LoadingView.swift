//
//  LoadingView.swift
//  Cat-alogue
//
//  Created by Kazim Ahmad on 15/10/2025.
//

import SwiftUI

struct LoadingView: View {
    var text: String = ""
    
    init(text: String = "Purrring...") {
        self.text = text
    }
    
    var body: some View {
        VStack {
            ProgressView()
                .progressViewStyle(.circular)
                .tint(.accentColor)
            Text(text)
                .font(.subheadline)
                .fontWeight(.heavy)
        }
    }
}

#Preview {
    LoadingView()
}

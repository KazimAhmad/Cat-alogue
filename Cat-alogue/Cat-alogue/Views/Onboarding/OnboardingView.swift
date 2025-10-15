//
//  OnboardingView.swift
//  Cat-alogue
//
//  Created by Kazim Ahmad on 15/10/2025.
//

import SwiftUI

struct OnboardingView<ViewModel: OnboardingViewModelProrocol>: View {
    @StateObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
        ZStack {
            Image(Constants.imageBackground)
                .resizable()
                .ignoresSafeArea(.all,
                                 edges: .bottom)
            VStack {
                catsHeader()
                    .padding(.bottom, -60)
                bodyContent()
                Spacer()
            }
        }
        .foregroundStyle(.primary)
    }
    
    private func catsHeader() -> some View {
        VStack {
            ZStack {
                HStack {
                    Spacer()
                    catbar()
                    catbar(color: .accentColor.opacity(0.6),
                           offsetMultiplier: 2)
                    catbar(color: .accentColor.opacity(0.4),
                           offsetMultiplier: 3)
                }
                .padding(.trailing, 40)
            }
            .rotationEffect(Angle(degrees: -20))
            .ignoresSafeArea(edges: .top)
        }
    }
    
    private func catbar(color: Color = .accentColor,
                        offsetMultiplier: CGFloat = 1) -> some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(color)
            .frame(width: 60,
                   height: 400)
            .overlay {
                VStack {
                    Spacer()
                    Image(Constants.imageAppLogo)
                        .resizable()
                        .frame(width: 40, height: 40)
                        .padding(.bottom)
                }
            }
            .offset(y: -(50 * offsetMultiplier))
    }
    
    private func bodyContent() -> some View {
        VStack {
            Text("Welcome to \n Cat-alogue")
                .font(.title)
                .fontWeight(.black)
            Button {
                //go to login; not required here
            } label: {
                Text("Login")
                    .foregroundStyle(Color.white)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .frame(width: 240, height: 40)
            }
            .buttonStyle(.borderedProminent)
            .tint(.accentColor)
            .buttonBorderShape(.capsule)
            
            Button {
                viewModel.skipAuth()
            } label: {
                Text("Skip Login")
                    .foregroundStyle(.primary)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding()
            }
        }
    }
}

#Preview {
    OnboardingView(viewModel: OnboardingViewModel())
}

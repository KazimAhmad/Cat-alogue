//
//  OnboardingViewModel.swift
//  Cat-alogue
//
//  Created by Kazim Ahmad on 15/10/2025.
//

import Foundation

protocol OnboardingViewModelProrocol: ObservableObject {
    func skipAuth()
}

class OnboardingViewModel: OnboardingViewModelProrocol {
    func skipAuth() {
        Services.shared.skipAuth()
    }
}

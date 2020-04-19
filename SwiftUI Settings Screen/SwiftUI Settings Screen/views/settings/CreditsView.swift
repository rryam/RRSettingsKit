//
//  CreditsView.swift
//  SwiftUI Settings Screen
//
//  Created by Rudrank Riyam on 19/04/20.
//  Copyright © 2020 Rudrank Riyam. All rights reserved.
//

import SwiftUI

struct CreditsView: View {
    var appURL: URL = URL(string: "https://apps.apple.com/us/app/neon-color-and-gradient-maker/id1480273650")!
    var body: some View {
        NavigationView {
            ScrollView {
                Text("The first version of the settings screen was inspired by my close friend's app. \n\nI included it in my app Gradient Game with his permission. \n\nYou can download his lovely app from the link below.")
                    .kerning(0.2)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .settingsBackground()

                SettingsRow(imageName: "eyedropper.halffull", title: "Neon by Swapnanil Dhol") {
                    UIApplication.shared.open(self.appURL)
                }
                .padding()
                .settingsBackground()
            }
            .navigationBarTitle("Credits")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
    }
}

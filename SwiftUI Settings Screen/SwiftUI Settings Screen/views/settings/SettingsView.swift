//
//  SettingsView.swift
//  SwiftUI Settings Screen
//
//  Created by Rudrank Riyam on 18/04/20.
//  Copyright © 2020 Rudrank Riyam. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var settingsViewModel = SettingsViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                AboutView(title: "💜 the game? share!", accessibilityTitle: "Love the game? share!")

                VStack(alignment: .leading) {
                    // MARK: - SHARE
                    SettingsRow(imageName: "square.and.arrow.up", title: "Share") {
                        self.settingsViewModel.showShareSheet = true
                    }
                    .sheet(isPresented: $settingsViewModel.showShareSheet) {
                        ShareSheetView(activityItems: ["Can you beat me in Gradient Game? \n\(Settings.appURL)", self.settingsViewModel.shareScreen()!])
                            .edgesIgnoringSafeArea(.bottom)
                    }
                    // MARK: - WRITE REVIEW
                    SettingsRow(imageName: "pencil.and.outline", title: "Write a review") {
                        self.settingsViewModel.writeReview()
                    }

                    // MARK: - TWEET ABOUT IT
                    SettingsRow(imageName: "textbox", title: "Tweet about it") {
                        self.settingsViewModel.openTwitter(twitterURLApp: Settings.gameTwitterApp, twitterURLWeb: Settings.gameTwitterWeb)
                    }
                }
                .settingsBackground()

            }
            .navigationBarTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

//
//  ContentView.swift
//  RRSettingsKitExample
//
//  Created by Rudrank Riyam on 12/10/20.
//

import SwiftUI
import RRSettingsKit

struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                AboutRow(title: "💜 the game? share!", accessibilityTitle: "Love the game? share!")
              
                SettingsRow(imageName: "square.and.arrow.up", title: "Share")

                SettingsActionRow(imageName: "square.and.arrow.up", title: "Share") {
                    // Add share action here
                }

                SettingsNavigationRow(imageName: "square.and.arrow.up", title: "Share", destination: ContentView())

                WriteReviewRow(appURL: "https://apps.apple.com/us/app/gradient-game/id1479784361")

                TwitterRow(imageName: "textbox", title: "Tweet about it", twitterAppURL: "twitter://user?screen_name=gradientsgame", twitterWebURL: "https://www.twitter.com/gradientsgame")

                AppVersionRow(version: "0.1.0")
            }
            .accentColor(.red)
            .navigationTitle("Settings")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

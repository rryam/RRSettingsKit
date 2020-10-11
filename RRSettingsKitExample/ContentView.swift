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
                RRSettingsKit.AboutRow(title: "💜 the game? share!", accessibilityTitle: "Love the game? share!")
                RRSettingsKit.SettingsRow(imageName: "square.and.arrow.up", title: "Share") {
                    // Add share action here
                }.settingsBackground()

                RRSettingsKit.AppVersionRow(version: "0.1.0").settingsBackground()
            }
            .navigationTitle("Settings")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  SettingsView.swift
//  SwiftUI Settings Screen
//
//  Created by Rudrank Riyam on 18/04/20.
//  Copyright © 2020 Rudrank Riyam. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                AboutView(title: "💜 the game? share!", accessibilityTitle: "Love the game? share!")
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

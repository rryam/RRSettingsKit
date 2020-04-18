//
//  ContentView.swift
//  SwiftUI Settings Screen
//
//  Created by Rudrank Riyam on 18/04/20.
//  Copyright © 2020 Rudrank Riyam. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                Text("Hello, World!")
                    .navigationBarTitle("Example Screen")
            }
            .navigationViewStyle(StackNavigationViewStyle())

            .tabItem {
                Image(systemName: "house")
                    .font(.system(size: 20))
                Text("Home")
            }
            .tag(1)
            SettingsView()

                .tabItem {
                    Image(systemName: "gear")
                        .font(.system(size: 20))
                    Text("Settings")
            }
            .tag(2)
        }
        .accentColor(.purple)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

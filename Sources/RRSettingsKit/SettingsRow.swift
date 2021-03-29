//
//  SettingsRow.swift
//  RRSettingsKit
//
//  Created by Rudrank Riyam on 29/03/21.
//

import SwiftUI
import RRComponentsKit

public struct SettingsNavigationRow<Destination: View>: View {
    private var imageName: String
    private var title: String
    private var destination: Destination

    /// A generic settings row which can be customised according to your needs.
    /// - Parameters:
    ///   - imageName: The icon for the settings row.
    ///   - title: The title of the settings row.
    ///   - destination: The view to navigate to, after tapping the row.
    public init(imageName: String, title: String, destination: Destination) {
        self.imageName = imageName
        self.title = title
        self.destination = destination
    }

    public var body: some View {
        NavigationLink(destination: destination) {
            SettingsRow(imageName: imageName, title: title)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

public struct SettingsActionRow: View {
    private var imageName: String
    private var title: String
    private var action: () -> ()

    /// A generic settings row which can be customised according to your needs.
    /// - Parameters:
    ///   - imageName: The icon for the settings row.
    ///   - title: The title of the settings row.
    ///   - action: The custom action that you want to perform on tapping the row.
    public init(imageName: String, title: String, action: @escaping () -> ()) {
        self.imageName = imageName
        self.title = title
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            SettingsRow(imageName: imageName, title: title)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

public struct SettingsRow: View {
    private var imageName: String
    private var title: String

    /// A generic settings row which can be customised according to your needs.
    /// - Parameters:
    ///   - imageName: The icon for the settings row.
    ///   - title: The title of the settings row.
    public init(imageName: String, title: String) {
        self.imageName = imageName
        self.title = title
    }

    public var body: some View {
        HStack(spacing: 8) {
            Image(systemName: imageName)
                .customIconImage()
            Text(title).font()
            Spacer()
            Image(systemName: "chevron.right")
        }
        .padding(.vertical, 12)
        .foregroundColor(.primary)
    }
}

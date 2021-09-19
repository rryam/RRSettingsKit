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
    private var addOverlay: Bool
    
    /// A generic settings row which can be customised according to your needs.
    /// - Parameters:
    ///   - imageName: The icon for the settings row.
    ///   - title: The title of the settings row.
    ///   - destination: The view to navigate to, after tapping the row.
    ///   - addOverlay: Add overlay to the border of the row.
    public init(imageName: String, title: String, addOverlay: Bool = true, destination: Destination) {
        self.imageName = imageName
        self.title = title
        self.destination = destination
        self.addOverlay = addOverlay
    }
    
    public var body: some View {
        NavigationLink(destination: destination) {
            SettingsRow(imageName: imageName, title: title, addOverlay: addOverlay)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

public struct SettingsActionRow: View {
    private var imageName: String
    private var title: String
    private var action: () -> ()
    private var addOverlay: Bool

    /// A generic settings row which can be customised according to your needs.
    /// - Parameters:
    ///   - imageName: The icon for the settings row.
    ///   - title: The title of the settings row.
    ///   - action: The custom action that you want to perform on tapping the row.
    ///   - addOverlay: Add overlay to the border of the row.
    public init(imageName: String, title: String, addOverlay: Bool = true, action: @escaping () -> ()) {
        self.imageName = imageName
        self.title = title
        self.action = action
        self.addOverlay = addOverlay
    }
    
    public var body: some View {
        Button(action: action) {
            SettingsRow(imageName: imageName, title: title, addOverlay: addOverlay)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

public struct SettingsRow: View {
    private var imageName: String
    private var title: String
    private var showDisclosure: Bool
    private var addOverlay: Bool

    /// A generic settings row which can be customised according to your needs.
    /// - Parameters:
    ///   - imageName: The icon for the settings row.
    ///   - title: The title of the settings row.
    ///   - showDisclosure: Show disclosure icon for action or navigation.
    public init(imageName: String, title: String, addOverlay: Bool = true, showDisclosure: Bool = true) {
        self.imageName = imageName
        self.title = title
        self.showDisclosure = showDisclosure
        self.addOverlay = addOverlay
    }
    
    public var body: some View {
        HStack(spacing: 8) {
            Image(systemName: imageName)
                .customIconImage()
            
            Text(title)
                .font(type: .poppins, weight: .regular, style: .body)
            
            Spacer()
            
            if showDisclosure {
                Image(systemName: "chevron.right")
            }
        }
        .padding(.vertical, 12)
        .settingsBackground(addOverlay: addOverlay)
    }
}

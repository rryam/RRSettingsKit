//
//  SettingsRow.swift
//  SwiftUI Settings Screen
//
//  Created by Rudrank Riyam on 18/04/20.
//  Copyright © 2020 Rudrank Riyam. All rights reserved.
//

import SwiftUI

struct SettingsRow: View {
    var imageName: String
    var title: String
    var action: (()->()) = {}

    var body: some View {
        Button(action: {
            self.action()
            FeedbackManager.mediumFeedback()
        }) {
            HStack(spacing: 8) {
                Image(systemName: imageName)
                    .font(.headline)
                    .foregroundColor(.purple)
                    .frame(minWidth: 25, alignment: .leading)
                    .accessibility(hidden: true)
                Text(title)
                    .kerning(1)
                Spacer()
                Image(systemName: "chevron.right")
            }
            .padding(.vertical, 10)
            .foregroundColor(.primary)
        }
        .customHoverEffect()
    }
}

struct SettingsRow_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRow(imageName: "wand.and.stars", title: "Feature request")
    }
}

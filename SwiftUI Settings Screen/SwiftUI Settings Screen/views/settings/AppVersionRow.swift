//
//  AppVersionRow.swift
//  SwiftUI Settings Screen
//
//  Created by Rudrank Riyam on 18/04/20.
//  Copyright © 2020 Rudrank Riyam. All rights reserved.
//

import SwiftUI

struct AppVersionRow: View {
    var imageName: String
    var title: String
    var version: String
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: imageName)
                .font(.headline)
                .foregroundColor(.purple)
                .frame(minWidth: 25, alignment: .leading)
                .accessibility(hidden: true)

            Text(title)
            Spacer()
            Text(version)
                .bold()
        }
        .accessibilityElement(children: .combine)
        .padding(.vertical, 10)
        .foregroundColor(.primary)
    }
}

struct AppVersionRow_Previews: PreviewProvider {
    static var previews: some View {
        AppVersionRow(imageName: "info.circle", title: "App version", version: "2.0")
    }
}

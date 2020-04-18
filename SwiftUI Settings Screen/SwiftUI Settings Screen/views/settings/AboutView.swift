//
//  AboutView.swift
//  SwiftUI Settings Screen
//
//  Created by Rudrank Riyam on 18/04/20.
//  Copyright © 2020 Rudrank Riyam. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    var title: String
    var accessibilityTitle: String

    var body: some View {
        Text(title.uppercased())
            .foregroundColor(.secondary)
            .font(.caption)
            .kerning(1)
            .frame(minWidth: 100, maxWidth: .infinity, alignment: .center)
            .accessibility(label: Text(accessibilityTitle))
            .padding(.top)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView(title: "💜 the game? share!", accessibilityTitle: "Love the game? share!")
    }
}

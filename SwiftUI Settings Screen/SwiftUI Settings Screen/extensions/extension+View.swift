//
//  extension+View.swift
//  SwiftUI Settings Screen
//
//  Created by Rudrank Riyam on 18/04/20.
//  Copyright © 2020 Rudrank Riyam. All rights reserved.
//

import SwiftUI

extension View {
    func settingsBackground() -> some View {
        self
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(.secondarySystemBackground)))
            .padding(.bottom, 6)
            .padding(.horizontal)
    }

    func customHoverEffect() -> some View {
        if #available(macCatalyst 13.4, *), #available(iOS 13.4, *) {
            return AnyView(self.hoverEffect())
        } else {
            return AnyView(self)
        }
    }
}

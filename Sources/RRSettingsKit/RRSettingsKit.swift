import SwiftUI

public struct RRSettingsKit {
    public struct AboutRow: View {
        var title: String
        var accessibilityTitle: String

        /// A view for about description.
        /// - Parameters:
        ///   - title: The title of the row. For example, the title can be "Made with ❤️ by Rudrank Riyam".
        ///   - accessibilityTitle: The accessibility label for the row. For example, the label can be "Made with love by Rudrank Riyam".
        public init(title: String, accessibilityTitle: String) {
            self.title = title
            self.accessibilityTitle = accessibilityTitle
        }

        public var body: some View {
            Text(title.uppercased())
                .font(.caption)
                .kerning(1)
                .frame(minWidth: 100, maxWidth: .infinity, alignment: .center)
                .accessibility(label: Text(accessibilityTitle))
                .padding(.top)
        }
    }

    public struct AppVersionRow: View {
        var imageName: String = "info.circle"
        var title: String = "App version"
        var version: String

        /// The row which tells the user the app version of your application
        /// - Parameters:
        ///   - imageName: The icon for the app version row. The default is `info.circle`.
        ///   - title: The tile for the app version row. The default is `App version`.
        ///   - version: The version of your app.
        public init(imageName: String = "info.circle", title: String = "App version", version: String) {
            self.imageName = imageName
            self.title = title
            self.version = version
        }

        public var body: some View {
            HStack(spacing: 8) {
                Image(systemName: imageName).customIconImage()
                Text(title)
                Spacer()
                Text(version).bold()
            }
            .accessibilityElement(children: .combine)
            .padding(.vertical, 10)
        }
    }

    public struct SettingsRow: View {
        var imageName: String
        var title: String
        var action: (()->Void)

        /// A generic settings row which can be customised according to your needs.
        /// - Parameters:
        ///   - imageName: The icon for the settings row.
        ///   - title: The title of the settings row.
        ///   - action: The custom action that you want to perform on tapping the row.
        public init(imageName: String, title: String, action: @escaping (() -> Void)) {
            self.imageName = imageName
            self.title = title
            self.action = action
        }

        public var body: some View {
            Button(action: action) {
                HStack(spacing: 8) {
                    Image(systemName: imageName).customIconImage()
                    Text(title).kerning(1)
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .padding(.vertical, 10)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

extension View {
    public func customIconImage() -> ModifiedContent<Self, CustomImageModifier> {
        return modifier(CustomImageModifier())
    }

    public func settingsBackground() -> some View {
        self
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(RoundedRectangle(cornerRadius: 16, style: .continuous).fill(Color(.secondarySystemBackground)))
            .padding(.bottom, 6)
            .padding(.horizontal)
    }
}

public struct CustomImageModifier: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .font(.headline)
            .frame(minWidth: 25, alignment: .leading)
            .accessibility(hidden: true)
    }
}

import SwiftUI

public struct AboutRow: View {
    private var title: String
    private var accessibilityTitle: String
    private var style: UIFont.TextStyle
    
    /// A view for about description.
    /// - Parameters:
    ///   - title: The title of the row. For example, the title can be "Made with ❤️ by Rudrank Riyam".
    ///   - accessibilityTitle: The accessibility label for the row.
    ///   - style: The font text style. The default value is caption1.
    ///   For example, the label can be "Made with love by Rudrank Riyam".
    public init(title: String, accessibilityTitle: String, style: UIFont.TextStyle = .caption1) {
        self.title = title
        self.accessibilityTitle = accessibilityTitle
        self.style = style
    }
    
    public var body: some View {
        Text(title.uppercased())
            .font(type: .poppins, weight: .regular, style: style)
            .kerning(1)
            .multilineTextAlignment(.center)
            .frame(minWidth: 100, maxWidth: .infinity, alignment: .center)
            .accessibility(label: Text(accessibilityTitle))
            .padding(.top)
    }
}

public struct TwitterRow: View {
    var imageName: String
    var title: String
    var twitterAppURL: String
    var twitterWebURL: String
    var addOverlay: Bool

    /// A view for making the user write a review of the app on the store.
    /// - Parameters:
    ///   - imageName: The icon for the settings row.
    ///   - title: The title of the settings row.
    ///   - twitterAppURL: The deeplink to directly open in the Twitter app.
    ///   - twitterWebURL: The link to open in the browser if the app is not available.
    public init(imageName: String = "textbox", title: String, twitterAppURL: String, twitterWebURL: String, addOverlay: Bool = true) {
        self.title = title
        self.imageName = imageName
        self.twitterAppURL = twitterAppURL
        self.twitterWebURL = twitterWebURL
        self.addOverlay = addOverlay
    }
    
    public var body: some View {
        SettingsActionRow(imageName: imageName, title: title, addOverlay: addOverlay, action: {
            openTwitter(appURL: twitterAppURL, webURL: twitterWebURL)
        })
    }
    
    private func openTwitter(appURL: String, webURL: String) {
        if let appURL = URL(string: appURL), UIApplication.shared.canOpenURL(appURL) {
            UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
        } else {
            guard let webURL = URL(string: webURL) else { return }
            UIApplication.shared.open(webURL, options: [:], completionHandler: nil)
        }
    }
}

public struct WriteReviewRow: View {
    var imageName: String
    var title: String
    var appURL: String
    var addOverlay: Bool

    /// A view for making the user write a review of the app on the store.
    /// - Parameters:
    ///   - imageName: The icon for the settings row.
    ///   - title: The title of the settings row.
    ///   - appURL: The URL of the app.
    public init(imageName: String = "pencil.and.outline", title: String = "Write a review", appURL: String, addOverlay: Bool = true) {
        self.title = title
        self.imageName = imageName
        self.appURL = appURL
        self.addOverlay = addOverlay
    }
    
    public var body: some View {
        SettingsActionRow(imageName: imageName, title: title, addOverlay: addOverlay, action: {
            writeReview(appURL: appURL)
        })
    }
    
    private func writeReview(appURL: String) {
        guard let url = URL(string: appURL) else { return }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = [URLQueryItem(name: "action", value: "write-review")]
        guard let writeReviewURL = components?.url else { return }
        UIApplication.shared.open(writeReviewURL)
    }
}

public struct AppVersionRow: View {
    var imageName: String = "info.circle"
    var title: String = "App version"
    var version: String
    var addOverlay: Bool
    
    /// The row which tells the user the app version of your application
    /// - Parameters:
    ///   - imageName: The icon for the app version row. The default is `info.circle`.
    ///   - title: The tile for the app version row. The default is `App version`.
    ///   - version: The version of your app.
    public init(imageName: String = "info.circle", title: String = "App version", version: String, addOverlay: Bool = true) {
        self.imageName = imageName
        self.title = title
        self.version = version
        self.addOverlay = addOverlay
    }
    
    public var body: some View {
        HStack(spacing: 8) {
            Image(systemName: imageName)
                .customIconImage()
            
            Text(title)
                .font(type: .poppins, weight: .regular, style: .body)
            
            Spacer()
            
            Text(version)
                .font(type: .poppins, weight: .bold, style: .body)
        }
        .accessibilityElement(children: .combine)
        .padding(.vertical, 12)
        .settingsBackground(addOverlay: addOverlay)
    }
}


extension View {
    func customIconImage() -> some View {
        self
            .font(.headline)
            .frame(minWidth: 25, alignment: .leading)
            .accessibility(hidden: true)
    }
    
    func settingsBackground(cornerRadius: CGFloat = 16, innerPadding: CGFloat = 8, outerBottomPadding: CGFloat = 6, addOverlay: Bool = true) -> some View {
        let gradient = Gradient(colors: [.accentColor, .accentColor.opacity(0.5)])
        
        return self
            .foregroundColor(.accentColor)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.horizontal)
            .padding(.vertical, innerPadding)
            .contentShape(Rectangle())
            .overlay(addOverlay ? RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom), lineWidth: 1) : nil)
            .padding(.bottom, outerBottomPadding)
            .padding(.horizontal)
    }
}

struct CustomImageModifier: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .font(.headline)
            .frame(minWidth: 25, alignment: .leading)
            .accessibility(hidden: true)
    }
}

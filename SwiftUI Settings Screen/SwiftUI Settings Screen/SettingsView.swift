//
//  SettingsView.swift
//  SwiftUI Settings Screen
//
//  Created by Rudrank Riyam on 18/04/20.
//  Copyright © 2020 Rudrank Riyam. All rights reserved.
//

import SwiftUI
import MessageUI

struct SettingsView: View {
    @ObservedObject var settingsViewModel = SettingsViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                AboutView(title: "💜 the game? share!", accessibilityTitle: "Love the game? share!")

                VStack {
                    // MARK: - SHARE
                    SettingsRow(imageName: "square.and.arrow.up", title: "Share") {
                        settingsViewModel.showShareSheet = true
                    }
                    .sheet(isPresented: $settingsViewModel.showShareSheet) {
                        ShareSheetView(activityItems: ["Can you beat me in Gradient Game? \n\(Settings.appURL)"])
                            .edgesIgnoringSafeArea(.bottom)
                    }
                    // MARK: - WRITE REVIEW
                    SettingsRow(imageName: "pencil.and.outline", title: "Write a review") {
                        settingsViewModel.writeReview()
                    }

                    // MARK: - TWEET ABOUT IT
                    SettingsRow(imageName: "textbox", title: "Tweet about it") {
                        settingsViewModel.openTwitter(twitterURLApp: Settings.gameTwitterApp, twitterURLWeb: Settings.gameTwitterWeb)
                    }
                }
                .settingsBackground()

                VStack {
                    // MARK: - FEATURE REQUEST
                    SettingsRow(imageName: "wand.and.stars", title: "Feature request") {
                        if MFMailComposeViewController.canSendMail() {
                            settingsViewModel.showingFeatureEmail.toggle()
                        } else if let emailUrl = settingsViewModel.createEmailUrl(to: Settings.email, subject: "Feature request!", body: "Hello, I have this idea ") {
                            UIApplication.shared.open(emailUrl)
                        } else {
                            settingsViewModel.showMailFeatureAlert = true
                        }
                    }
                    .alert(isPresented: $settingsViewModel.showMailFeatureAlert) {
                        Alert(title: Text("No Mail Accounts"), message: Text("Please set up a Mail account in order to send email"), dismissButton: .default(Text("OK")))
                    }
                    .sheet(isPresented: $settingsViewModel.showingFeatureEmail) {
                        MailView(isShowing: $settingsViewModel.showingFeatureEmail, result: $settingsViewModel.featureResult, subject: "Feature request! [Gradient Game]", message: "Hello, I have this idea ")
                    }

                    // MARK: - REPORT A BUG
                    SettingsRow(imageName: "tornado", title: "Report a bug") {
                        if MFMailComposeViewController.canSendMail() {
                            settingsViewModel.showingBugEmail.toggle()
                        } else if let emailUrl = settingsViewModel.createEmailUrl(to: Settings.email, subject: "BUG! [Gradient Game]", body: "Oh no, there's a bug ") {
                            UIApplication.shared.open(emailUrl)
                        } else {
                            settingsViewModel.showMailBugAlert = true
                        }
                    }
                    .alert(isPresented: $settingsViewModel.showMailBugAlert) {
                        Alert(title: Text("No Mail Accounts"), message: Text("Please set up a Mail account in order to send email"), dismissButton: .default(Text("OK")))
                    }
                    .sheet(isPresented: $settingsViewModel.showingBugEmail) {
                        MailView(isShowing: $settingsViewModel.showingBugEmail, result: $settingsViewModel.bugResult, subject: "BUG!", message: "Oh no, there's a bug ")
                    }

                    // MARK: - APP VERSION
                    AppVersionRow(imageName: "info.circle", title: "App version", version: settingsViewModel.appVersion)
                }
                .settingsBackground()

                VStack {
                    // MARK: - PERSONAL TWITTER ACCOUNT
                    SettingsRow(imageName: "textbox", title: "Creator") {
                        settingsViewModel.openTwitter(twitterURLApp: Settings.personalTwitterApp, twitterURLWeb: Settings.personalTwitterWeb)
                    }

                    // MARK: - CREDITS
                    SettingsRow(imageName: "hand.thumbsup", title: "Credits", action: {
                        settingsViewModel.showCreditsView = true
                    })
                    .sheet(isPresented: $settingsViewModel.showCreditsView) {
                        CreditsView()
                    }
                }
                .settingsBackground()
                AboutView(title: "MADE WITH ❤️ BY RUDRANK RIYAM", accessibilityTitle: "MADE WITH LOVE BY RUDRANK RIYAM")
            }
            .navigationBarTitle("Settings")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

struct SettingsRow: View {
    var imageName: String
    var title: String
    var action: (()->Void)

    var body: some View {
        Button(action: {
            action()
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
        SettingsRow(imageName: "wand.and.stars", title: "Feature request", action: {})
    }
}

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

struct MailView: UIViewControllerRepresentable {
    @Binding var isShowing: Bool
    @Binding var result: Result<MFMailComposeResult, Error>?
    let subject: String
    let message: String
    let recipientEmail: String = Settings.email

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var isShowing: Bool
        @Binding var result: Result<MFMailComposeResult, Error>?

        init(isShowing: Binding<Bool>, result: Binding<Result<MFMailComposeResult, Error>?>) {
            _isShowing = isShowing
            _result = result
        }

        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            defer { isShowing = false }
            guard error == nil else {
                self.result = .failure(error!)
                return
            }
            self.result = .success(result)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(isShowing: $isShowing, result: $result)
    }

    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let mailViewController = MFMailComposeViewController()
        mailViewController.setToRecipients([recipientEmail])
        mailViewController.setSubject(subject)
        mailViewController.setMessageBody(message, isHTML: false)
        mailViewController.mailComposeDelegate = context.coordinator
        return mailViewController
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {
    }
}

struct CreditsView: View {
    var appURL: URL = URL(string: "https://apps.apple.com/us/app/neon-color-and-gradient-maker/id1480273650")!
    var body: some View {
        NavigationView {
            ScrollView {
                Text("The first version of the settings screen was inspired by my close friend's app. \n\nI included it in my app Gradient Game with his permission. \n\nYou can download his lovely app from the link below.")
                    .kerning(0.2)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .settingsBackground()

                SettingsRow(imageName: "eyedropper.halffull", title: "Neon by Swapnanil Dhol") {
                    UIApplication.shared.open(appURL)
                }
                .padding()
                .settingsBackground()
            }
            .navigationBarTitle("Credits")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
    }
}

struct ShareSheetView: UIViewControllerRepresentable {
    typealias Callback = (_ activityType: UIActivity.ActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ error: Error?) -> Void

    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil

    let callback: Callback? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        let excludedActivityTypes: [UIActivity.ActivityType]? = [.assignToContact, .addToReadingList, .openInIBooks, .print, .saveToCameraRoll]

        controller.excludedActivityTypes = excludedActivityTypes
        controller.completionWithItemsHandler = callback
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // nothing to do here
    }
}

struct Settings {
    static var appURL = URL(string: "https://apps.apple.com/app/id1479784361")!
    static var personalTwitterApp = "twitter://user?screen_name=rudrankriyam"
    static var personalTwitterWeb = "https://www.twitter.com/rudrankriyam"
    static var gameTwitterApp = "twitter://user?screen_name=gradientsgame"
    static var gameTwitterWeb = "https://www.twitter.com/gradientsgame"
    static let email = "rudrankriyam@gmail.com"
}

class SettingsViewModel: ObservableObject {
    @Published var bugResult: Result<MFMailComposeResult, Error>? = nil
    @Published var featureResult: Result<MFMailComposeResult, Error>? = nil
    @Published var showingBugEmail = false
    @Published var showingFeatureEmail = false
    @Published var showMailBugAlert = false
    @Published var showMailFeatureAlert = false
    @Published var showShareSheet = false
    @Published var showCreditsView = false
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String

    func createEmailUrl(to: String, subject: String, body: String) -> URL? {
        let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!

        let gmailUrl = URL(string: "googlegmail://co?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let outlookUrl = URL(string: "ms-outlook://compose?to=\(to)&subject=\(subjectEncoded)")
        let yahooMail = URL(string: "ymail://mail/compose?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let sparkUrl = URL(string: "readdle-spark://compose?recipient=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")

        if let gmailUrl = gmailUrl, UIApplication.shared.canOpenURL(gmailUrl) { return gmailUrl }
        else if let outlookUrl = outlookUrl, UIApplication.shared.canOpenURL(outlookUrl) { return outlookUrl }
        else if let yahooMail = yahooMail, UIApplication.shared.canOpenURL(yahooMail){ return yahooMail }
        else if let sparkUrl = sparkUrl, UIApplication.shared.canOpenURL(sparkUrl) { return sparkUrl }
        return nil
    }

    func openTwitter(twitterURLApp: String, twitterURLWeb: String) {
        let twUrl = URL(string: twitterURLApp)!
        let twUrlWeb = URL(string: twitterURLWeb)!
        if UIApplication.shared.canOpenURL(twUrl) {
            UIApplication.shared.open(twUrl, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.open(twUrlWeb, options: [:], completionHandler: nil)
        }
    }

    func writeReview() {
        var components = URLComponents(url: Settings.appURL, resolvingAgainstBaseURL: false)
        components?.queryItems = [URLQueryItem(name: "action", value: "write-review")]
        guard let writeReviewURL = components?.url else { return }
        UIApplication.shared.open(writeReviewURL)
    }
}

enum FeedbackManager {
    static func mediumFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
    }
}

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
            return AnyView(hoverEffect())
        } else {
            return AnyView(self)
        }
    }
}

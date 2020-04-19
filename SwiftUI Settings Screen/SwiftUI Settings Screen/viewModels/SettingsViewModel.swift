//
//  SettingsViewModel.swift
//  SwiftUI Settings Screen
//
//  Created by Rudrank Riyam on 18/04/20.
//  Copyright © 2020 Rudrank Riyam. All rights reserved.
//

import SwiftUI
import MessageUI

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

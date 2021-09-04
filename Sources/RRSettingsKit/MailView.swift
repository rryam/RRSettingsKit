//
//  MailView.swift
//  MailView
//
//  Created by Rudrank Riyam on 04/09/21.
//

import SwiftUI
import MessageUI

public struct MailRowObject {
    public var receiver: String
    public var subject: String
    public var body: String
    
    public init(receiver: String, subject: String, body: String) {
        self.receiver = receiver
        self.subject = subject
        self.body = body
    }
}

public struct MailRow: View {
    private var imageName: String
    private var title: String
    private var object: MailRowObject
    
    @State private var showMailView = false
    @State private var showFailureAlert = false
    @State private var result: Result<MFMailComposeResult, Error>? = nil
    
    public init(image: String, title: String, object: MailRowObject) {
        self.imageName = image
        self.title = title
        self.object = object
    }
    
    public var body: some View {
        SettingsActionRow(imageName: imageName, title: title) {
            if MFMailComposeViewController.canSendMail() {
                showMailView.toggle()
            }  else if let emailURL = createEmailURL(to: object.receiver, subject: object.subject, body: object.body) {
                UIApplication.shared.open(emailURL)
            } else {
                showFailureAlert = true
            }
        }
        .alert(isPresented: $showFailureAlert) {
            Alert(title: Text("No Mail Accounts"), message: Text("Please set up a Mail account in order to send email"), dismissButton: .default(Text("OK")))
        }
        .sheet(isPresented: $showMailView) {
            MailView(isShowing: $showMailView, result: $result, subject: object.subject, message: object.body, recipientEmail: object.receiver)
        }
    }
    
    private func createEmailURL(to: String, subject: String, body: String) -> URL? {
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
}


struct MailView: UIViewControllerRepresentable {
    @Binding var isShowing: Bool
    @Binding var result: Result<MFMailComposeResult, Error>?
    let subject: String
    let message: String
    let recipientEmail: String
    
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
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let mailViewController = MFMailComposeViewController()
        mailViewController.setToRecipients([recipientEmail])
        mailViewController.setSubject(subject)
        mailViewController.setMessageBody(message, isHTML: false)
        mailViewController.mailComposeDelegate = context.coordinator
        return mailViewController
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: UIViewControllerRepresentableContext<MailView>) {
    }
}

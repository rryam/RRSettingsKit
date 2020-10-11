import XCTest
import SwiftUI
@testable import RRSettingsKit

final class RRSettingsKitTests: XCTestCase {
    func testExample() {
        var body: some View {
            ScrollView {
                RRSettingsKit.AboutRow(title: "Made with ❤️ by Rudrank Riyam", accessibilityTitle: "Made with love by Rudrank Riyam")
            }
        }
    }
    static var allTests = [
        ("testExample", testExample),
    ]
}

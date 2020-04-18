# SwiftUI Settings Screen

A beautiful settings screen created in SwiftUI

## Features
- \[x]  Customizable
- \[x]  iOS compatibility
- \[x]  Landscape compatibility
- \[x] iPad compatibility
- \[x] Dark mode
- \[ ] Mac compatibility

## Support
- iOS 13.0+ / macOS 10.15+

##  Documentation

Individual rows is the SettingsRow View which takes the image, title and action as the parameter. You can customise it to your liking.  

For example, this row is for writing a review, with a function in the closure.

```Swift
SettingsRow(imageName: "pencil.and.outline", title: "Write a review") {
    self.settingsViewModel.writeReview()
}
```

Each section is embedded in a VStack, with a custom background modifier. 

For example, this section is for showing a personal Twitter account.

```Swift  VStack(alignment: .leading) {
    SettingsRow(imageName: "textbox", title: "Creator") {
        self.settingsViewModel.openTwitter(twitterURLApp: Settings.personalTwitterApp, twitterURLWeb: Settings.personalTwitterWeb)
    }
}
.settingsBackground()
```
##  Contribution

You are free to add more features to it, or refactor the code! I will be more than happy to accept PRs. 

Contact - [Rudrank Riyam](https://twitter.com/rudrankriyam)

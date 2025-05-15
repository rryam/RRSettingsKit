![RRSettingsKit Logo](./RRSettingsKit.png?style=centerme)

A beautiful settings screen created in SwiftUI. It is based on my [Gradient Game!](https://apps.apple.com/app/id1479784361)

## Support

Love this project? Check out my books to explore more of AI and iOS development:
- [Exploring AI for iOS Development](https://academy.rudrank.com/product/ai)
- [Exploring AI-Assisted Coding for iOS Development](https://academy.rudrank.com/product/ai-assisted-coding)

Your support helps to keep this project growing!

## Features
- \[x] Customisable
- \[x] iOS compatibility
- \[x] Landscape compatibility
- \[x] iPad compatibility
- \[x] Dark mode
- \[ ] Hover Effect for iPad
- \[ ] Mac compatibility

## Requirements
- iOS 15.0+ / macOS 10.15+ [soon]

## Usage

### SettingsRow

It takes the image, title and action as the parameter. You can customise it to your liking.  

For example, this row is for writing a review, with a function in the closure.

```Swift
RRSettingsKit.SettingsRow(imageName: "pencil.and.outline", title: "Write a review") {
    self.settingsViewModel.writeReview()
}
```

More documentation coming soon with Version 0.1.0

## Contribution

You are free to add more features to it, or refactor the code! I will be more than happy to accept PRs. 

Contact - [Rudrank Riyam](https://twitter.com/rudrankriyam)

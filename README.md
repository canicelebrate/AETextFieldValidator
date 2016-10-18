AETextFieldValidator
==================
Inspired by the project TextFieldValidator and most of logic code comes from there
AETetFieldValidator is a lightweight, customizable subclass of UITextField that supports multiple regex validations and provides a simple UI to provide validation feedback.

See the original blog post of TextFieldValidator for details: https://dhawaldawar.wordpress.com/2014/06/11/uitextfield-validation-ios/



# AETextFieldValidator
A lightweight, customizable subclass of UITextField that supports multiple regex validations and provides a simple UI to provide validation feedback. And rewrite to support appearance

![AETextFieldValidator](https://github.com/canicelebrate/AETextFieldValidator/blob/master/Screenshot.png?raw=true)

## Setup
### Using [CocoaPods](http://cocoapods.org)
1. Add the pod `AETextFieldValidator` to your [Podfile](http://guides.cocoapods.org/using/the-podfile.html).

```ruby
pod 'AETextFieldValidator'
```

1. Run `pod install` from Terminal, then open your app's `.xcworkspace` file to launch Xcode.
2. Import the `AETextFieldValidator.h` umbrella header.
* Objective-C: `#import "AETextFieldValidator.h"`

## customizable
```objective-c
     [[TextFieldValidator appearance] setPopUpColor:[UIColor orangeColor]];
     UIImage* img = [UIImage imageNamed:@"customError"];
     [[TextFieldValidator appearance] setErrorImg:img];
     
     [[TextFieldValidator appearance] setPopUpShadowColor:[UIColor darkGrayColor]];
     [[TextFieldValidator appearance] setPopUpShadowRadius:3.0f];
     
     [[TextFieldValidator appearance] setPopUpFont:[UIFont fontWithName:kFontName size:25]];
     [[TextFieldValidator appearance] setMandatoryInvalidMsg:@"This field is required"];
     [[TextFieldValidator appearance] setPopUpCornerRadius:5.0f];
```

That's it - now go to design a form with AETextFieldValidator!

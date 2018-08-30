
![Language](https://img.shields.io/badge/objective--c-2.0-blue.svg) [![License](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/fastlane/produce/blob/master/LICENSE)
# SearchablePicker
###### Display Apple system-like picker view. It is well suited for showing a long list of items with a search bar in iOS-like way. It looks very similar to the views shown in Apple System Setting.
![Animation](demo-screens/demo-iphone.gif)    ![Animation](demo-screens/demo-ipad.gif)
* Native-like behavior. 
* Two options to present:
  * Titles only.
  * Titles with descriptions.
* Available for iPhone and iPad.
* Support for iOS 9 and above.
* Objective-c 
* Xcode 9 and above 
  * (due to safe area in autolayout)

### Basic Usage ##
**Title only**

*Objective-c*
```obj-c
#import "SearchStringPickerViewController.h"

NSArray *aryCountries = [NSArray arrayWithObjects:@"Afghanistan", @"Georgia", @"Haiti", @"India", nil];

[SearchStringPickerViewController showPickerWithTitle:@"Countries"
                                                     rows:aryCountries
                                         initialSelection:[colors indexOfObject:@"India"]
                                               sourceView:sender
                                                doneBlock:^(NSInteger selectedIndex, NSString *selectedValue) {
                                                    NSLog(@"Index: %@, value: %@", selectedIndex, selectedValue);
                                                }
                                              cancelBlock:nil 
                                presentFromViewController:self];                                
```
**Title with description**

*Objective-c*
```obj-c
#import "SearchStringPickerViewController.h"

NSDictionary *dicCountries = @{@"Afghanistan" : @"Islamic Republic of Afghanistan", @"Georgia" : @"", @"Haiti" : @"Republic of Haiti", @"India" : @"Republic of India"};

[SearchStringPickerViewController showPickerWithTitle:@"Countries"
                                          rowsWithDetails:dicCountries
                                         initialSelection:self.lblPickerWithTitleAndDesc.text
                                 pickerTableViewCellStyle:UITableViewCellStyleSubtitle
                                               sourceView:sender
                                                doneBlock:^(NSString *selectedTitle, NSString *selectedDetail) {
                                                    NSLog(@"Title: %@, Detail: %@", selectedTitle, selectedDetail);
                                                }
                                              cancelBlock:nil
                                presentFromViewController:self];
```
**For detailed examples, please download and try out this repo.**

## Installation ##
### Cocoapod
`pod 'SearchablePicker'`

### Carthage
######  coming soon!

### Manually
Download the project and add [SearchablePicker](SearchablePicker/SearchablePicker) folder to your project.

## Motivation ##
Coming soon!

## Todo ##
- [ ] Insert motivation
- [ ] Add customizable bar color
- [ ] Implement alphabets indexing at the scroll bar
- [x] Cocoapod support
- [ ] Carthage support



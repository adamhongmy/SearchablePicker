
![Language](https://img.shields.io/badge/language-objective--c-blue.svg) [![License](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/fastlane/produce/blob/master/LICENSE)
# SearchablePicker
###### A simple picker view with a search bar.
![Animation](demo-screens/demo-iphone.gif)    ![Animation](demo-screens/demo-ipad.gif)
* Native-like behavior. 
* Two options to present:
  * Titles only.
  * Titles with descriptions.
* Available for iPhone and iPad.
* Support for iOS 9 and above.
* Objective-c


### Basic Usage ##
**For detailed examples, please download and try out this repo.**

**Title only**

*Objective-c*
```obj-c
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
NSDictionary *dicCountries = @{@"Afghanistan" : @"Islamic Republic of Afghanistan", @"Georgia" : @"", @"Haiti" : @"Republic of Haiti", @"India" : @"Republic of India"};

 [SearchStringPickerViewController showPickerWithTitle:sender.currentTitle
                                          rowsWithDetails:self.dicTitlesAndDescs
                                         initialSelection:self.lblPickerWithTitleAndDesc.text
                                 pickerTableViewCellStyle:UITableViewCellStyleSubtitle
                                               sourceView:sender
                                                doneBlock:^(NSString *selectedTitle, NSString *selectedDetail) {
                                                    [self.lblPickerWithTitleAndDesc setText:selectedTitle];
                                                }
                                              cancelBlock:nil
                                presentFromViewController:self];
```
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



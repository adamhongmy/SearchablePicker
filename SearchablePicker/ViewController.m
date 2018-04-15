//
//  ViewController.m
//  SearchablePicker
//
//  Created by Adam Hong on 15/04/2018.
//  Copyright © 2018 adamhongmy. All rights reserved.
//

#import "ViewController.h"
#import "SearchStringPickerViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIButton *btnPickerWithTitle;
@property (strong, nonatomic) IBOutlet UIButton *btnPickerWithTitleAndDesc;

@property (strong, nonatomic) IBOutlet UILabel *lblPickerWithTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblPickerWithTitleAndDesc;

@property (nonatomic, strong) NSArray *aryTitles;
@property (nonatomic, strong) NSArray *aryDescs;
@property (nonatomic, strong) NSDictionary *dicTitlesAndDescs;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


-(NSArray *)aryTitles{
    return @[@"Afghanistan", @"Albania", @"Algeria", @"Bahrain", @"Bangladesh", @"Belarus", @"Belgium", @"Cape Verde", @"Central African Republic", @"Chad ", @"Chile", @"China", @"Colombia", @"Denmark", @"Djibouti", @"Dominica", @"Dominican Republic", @"East Timor", @"Ecuador", @"Egypt", @"El Salvador", @"Fiji", @"Finland", @"France", @"Gabon", @"Georgia", @"Germany", @"Ghana", @"Greece", @"Haiti", @"Honduras", @"India", @"Indonesia", @"Iran", @"Japan", @"Malaysia", @"Maldives", @"Mali", @"Malta"];
}

-(NSArray *)aryDescs{
    return @[@"Islamic Republic of Afghanistan",@"Republic of Albania", @"People's Democratic Republic of Algeria", @"Kingdom of Bahrain", @"People's Republic of Bangladesh", @"Republic of Belarus", @"Kingdom of Belgium", @"Republic of Cabo Verde", @"", @"Republic of Chad", @"Republic of Chile", @"People's Republic of China", @"Republic of Colombia", @"Kingdom of Denmark", @"Republic of Djibouti", @"Commonwealth of Dominica", @"", @"Democratic Republic of Timor-Leste", @"Republic of Ecuador", @"Arab Republic of Egypt", @"Republic of El Salvador", @"Republic of Fiji", @"Republic of Finland", @"French Republic", @"Gabonese Republic", @"", @"Federal Republic of Germany", @"Republic of Ghana", @"Hellenic Republic", @"Republic of Haiti", @"Republic of Honduras", @"Republic of India", @"Republic of Indonesia", @"Islamic Republic of Iran", @"Land of Anime", @"", @"Republic of Maldives", @"Republic of Mali", @"Republic of Malta"];
}

-(NSDictionary *)dicTitlesAndDescs{
    NSMutableDictionary *dic = [NSMutableDictionary new];
    for(NSInteger index = 0 ; index < self.aryTitles.count; index ++){
        [dic setObject:self.aryDescs[index] forKey:self.aryTitles[index]];
    }
    return dic;
}

- (IBAction)onBtnPickerWithTitlePressed:(UIButton *)sender {
    [SearchStringPickerViewController showPickerWithTitle:sender.currentTitle
                                                     rows:self.aryTitles
                                         initialSelection:[self.aryTitles indexOfObject:self.lblPickerWithTitle.text]
                                               sourceView:sender
                                                doneBlock:^(NSInteger selectedIndex, NSString *selectedValue) {
                                                    [self.lblPickerWithTitle setText:selectedValue];
                                                }
                                              cancelBlock:nil
                                presentFromViewController:self];
}

- (IBAction)onBtnPickerWithTitleAndDescPressed:(UIButton *)sender {
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
}

@end

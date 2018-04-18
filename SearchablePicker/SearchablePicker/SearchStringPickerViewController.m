//
//  SearchStringPickerViewController.m
//  mservice
//
//  Created by Adam Hong on 28/03/2018.
//  Copyright © 2018 FCS Computer System. All rights reserved.
//

#import "SearchStringPickerViewController.h"
#import "NSString+SearchablePicker.h"

#define UIColorFromHEX(hexValue) [self colorFromHexString:hexValue alpha:1]
#define CELL_PICKER_ID @"CELL_PICKER_ID"

typedef void(^doneBlock)(NSString *selectedTitle, NSString *selectedDetail);
typedef void(^selectBlock)(NSString *selectedTitle, NSString *selectedDetail);
typedef void(^cancelBlock)(void);


@interface SearchStringPickerViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (nonatomic, copy) doneBlock doneBlock;
@property (nonatomic, copy) cancelBlock cancelBlock;
@property (nonatomic, copy) selectBlock selectBlock;

@property (nonatomic, strong) NSString *pickerTitle;

@property (nonatomic, assign) BOOL isSearching;


@property (nonatomic, strong) NSArray <NSString *> *aryInitialRows;
@property (nonatomic, strong) NSArray <NSString *> *aryTitleRows;
@property (nonatomic, strong) NSArray <NSString *> *arySearchResultTitleRows;

@property (nonatomic, strong) NSDictionary<NSString *, NSString *> *dicRows;

@property (nonatomic, assign) NSInteger checkMarkedIndex;

@property (nonatomic, strong) NSString *selectedTitle;
@property (nonatomic, strong) NSString *selectedDetail;

@property (strong, nonatomic) IBOutlet UISearchBar *searchBarPicker;
@property (strong, nonatomic) IBOutlet UITableView *tblVwPicker;

@property (nonatomic, assign) UITableViewCellStyle pickerTableViewCellStyle;

@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;
@end

@implementation SearchStringPickerViewController

+(void)showPickerWithTitle:(NSString *)title
                      rows:(NSArray <NSString *> *)rows
          initialSelection:(NSInteger)initialSelection
                sourceView:(UIView *)sourceView
                 doneBlock:(void (^)(NSInteger selectedIndex, NSString * selectedValue))doneBlock
               cancelBlock:(void (^)(void))cancelBlock
 presentFromViewController:(UIViewController *)presentFromViewController{

    SearchStringPickerViewController *searchStringPickerViewController =  [[SearchStringPickerViewController alloc] initPickerWithTitle:title
                                                                                                                                   rows:rows
                                                                                                                       initialSelection:initialSelection
                                                                                                                             sourceView:sourceView
                                                                                                                              doneBlock:doneBlock
                                                                                                                            cancelBlock:cancelBlock];

    [presentFromViewController presentViewController:searchStringPickerViewController animated:YES completion:nil];
}

+(void)showPickerWithTitle:(NSString *)title
           rowsWithDetails:(NSDictionary<NSString *, NSString *> *)rowsWithDetails
          initialSelection:(NSString *)initialSelection
  pickerTableViewCellStyle:(UITableViewCellStyle)pickerTableViewCellStyle
                sourceView:(UIView *)sourceView
                 doneBlock:(void (^)(NSString *selectedTitle, NSString *selectedDetail))doneBlock
               cancelBlock:(void (^)(void))cancelBlock
 presentFromViewController:(UIViewController *)presentFromViewController{

    SearchStringPickerViewController *searchStringPickerViewController =  [[SearchStringPickerViewController alloc] initPickerWithTitle:title
                                                                                                                        rowsWithDetails:rowsWithDetails
                                                                                                                       initialSelection:initialSelection
                                                                                                               pickerTableViewCellStyle:pickerTableViewCellStyle
                                                                                                                             sourceView:sourceView
                                                                                                                              doneBlock:doneBlock
                                                                                                                            cancelBlock:cancelBlock];

    [presentFromViewController presentViewController:searchStringPickerViewController animated:YES completion:nil];

}


-(instancetype)initPickerWithTitle:(NSString *)title
                              rows:(NSArray <NSString *> *)rows
                  initialSelection:(NSInteger)initialSelection
                        sourceView:(UIView *)sourceView
                         doneBlock:(void (^)(NSInteger selectedIndex, NSString * selectedValue))doneBlock
                       cancelBlock:(void (^)(void))cancelBlock
{

    NSMutableDictionary<NSString *, NSString *> *rowsWithDetails = [NSMutableDictionary new];
    for (NSString *titleRow in rows){
        [rowsWithDetails setObject:@"" forKey:titleRow];
    }

    return [self initPickerWithTitle:title
                     rowsWithDetails:rowsWithDetails
                    initialSelection:initialSelection == NSNotFound? @"" :[rows objectAtIndex:initialSelection]
            pickerTableViewCellStyle:UITableViewCellStyleDefault
                          sourceView:sourceView
                           doneBlock:^(NSString *selectedTitle, NSString *selectedDetail) {
                               doneBlock([rows indexOfObject:selectedTitle], selectedTitle);
                           } cancelBlock:cancelBlock];
}

-(instancetype)initPickerWithTitle:(NSString *)title
                rowsWithDetails:(NSDictionary<NSString *, NSString *> *)rowsWithDetails
                  initialSelection:(NSString *)initialSelection
          pickerTableViewCellStyle:(UITableViewCellStyle)pickerTableViewCellStyle
                        sourceView:(UIView *)sourceView
                         doneBlock:(void (^)(NSString *selectedTitle, NSString *selectedDetail))doneBlock
                       cancelBlock:(void (^)(void))cancelBlock{

    self = [self init];
    self.modalPresentationStyle = UIModalPresentationFormSheet;
    self.popoverPresentationController.sourceView = sourceView;


    self.pickerTitle = title;
    self.dicRows = rowsWithDetails;
    self.aryTitleRows = [[rowsWithDetails allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    self.doneBlock = doneBlock;
    self.cancelBlock = cancelBlock;
    self.checkMarkedIndex = [self.aryTitleRows indexOfObject:initialSelection];
    self.selectedTitle = initialSelection;
    self.pickerTableViewCellStyle = pickerTableViewCellStyle;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];

    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    self.navBar.topItem.title = self.pickerTitle ? self.pickerTitle : @"";
}

-(void)viewDidAppear:(BOOL)animated{
    [self scrollToRowAtCheckMarkedIndexPath];
}

#pragma mark -  tableView Delagate Methods

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *pickerTableViewCell  = [tableView dequeueReusableCellWithIdentifier:CELL_PICKER_ID];

    if (!pickerTableViewCell)
    {
        pickerTableViewCell = [[UITableViewCell alloc] initWithStyle:self.pickerTableViewCellStyle reuseIdentifier:CELL_PICKER_ID];;
    }
    return pickerTableViewCell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.textLabel.text = self.isSearching ? [self.arySearchResultTitleRows objectAtIndex:indexPath.row] : [self.aryTitleRows objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self.dicRows objectForKey:cell.textLabel.text];
    cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
    cell.accessoryType = [cell.textLabel.text isEqualToIgnoreCaseString:self.selectedTitle] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSInteger checkMarkedIndex = self.isSearching ? [self.arySearchResultTitleRows indexOfObject:self.selectedTitle] : [self.aryTitleRows indexOfObject:self.selectedTitle];

    // Uncheck the previous checked row
    if(self.selectedTitle){
        UITableViewCell *previousSelectedPickerTableViewCell = [tableView
                                    cellForRowAtIndexPath:[NSIndexPath indexPathForRow:checkMarkedIndex inSection:0]];
        previousSelectedPickerTableViewCell.accessoryType = UITableViewCellAccessoryNone;
    }

    UITableViewCell* currentSelectedPickerTableViewCell = [tableView cellForRowAtIndexPath:indexPath];

    if([self.selectedTitle isEqualToIgnoreCaseString:currentSelectedPickerTableViewCell.textLabel.text]){
        self.selectedTitle = nil;
        self.selectedDetail = nil;
        self.checkMarkedIndex = NSNotFound;
    }else{
        currentSelectedPickerTableViewCell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.selectedTitle = currentSelectedPickerTableViewCell.textLabel.text;
        self.selectedDetail = [self.dicRows objectForKey:self.selectedTitle];
        self.checkMarkedIndex = [self.aryTitleRows indexOfObject:self.selectedTitle];
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.isSearching ? self.arySearchResultTitleRows.count : self.aryTitleRows.count;
}

#pragma mark - Search delegate methods
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.isSearching = searchBar.text.length > 0;
    if (self.isSearching) {
        [self filterSearchResultRowsArrayUsingSearchText:searchBar.text];
        [self reloadData];
    }else{
        [self reloadData];
        [self scrollToRowAtCheckMarkedIndexPath];
    }
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    searchBar.text = @"";
    [searchBar resignFirstResponder];
}

#pragma mark button action methods
- (IBAction)onBarBtnItemCancelPressed:(UIBarButtonItem *)sender {
    if(self.cancelBlock){
        self.cancelBlock();
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onBarBtnItemDonePressed:(UIBarButtonItem *)sender {
    self.doneBlock(self.selectedTitle, self.selectedDetail);
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark private methods
- (void)filterSearchResultRowsArrayUsingSearchText:(NSString*)searchText
{
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF CONTAINS[c] %@",
                                    [searchText lowercaseString]];
    self.arySearchResultTitleRows = [self.aryTitleRows filteredArrayUsingPredicate:resultPredicate];
}

-(void)reloadData{
    [self.tblVwPicker reloadData];
    [self.tblVwPicker layoutIfNeeded];
}

-(void)scrollToRowAtCheckMarkedIndexPath{
 [self.tblVwPicker scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.checkMarkedIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (UIColor *)colorFromHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    // Convert hex string to an integer
    unsigned int hexint = [self intFromHexString:hexString];

    // Create color object, specifying alpha as well
    return [self colorFromRgb:hexint alpha:alpha];
}

- (unsigned int)intFromHexString:(NSString *)hexStr
{
    unsigned int hexInt = 0;

    // Create scanner
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];

    // Tell scanner to skip the # character
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];

    // Scan hex value
    [scanner scanHexInt:&hexInt];

    return hexInt;
}

- (UIColor *)colorFromRgb:(int)rgbInt alpha:(CGFloat)alpha{
    return  [UIColor colorWithRed:((CGFloat) ((rgbInt & 0xFF0000) >> 16))/255
                            green:((CGFloat) ((rgbInt & 0xFF00) >> 8))/255
                             blue:((CGFloat) (rgbInt & 0xFF))/255
                            alpha:alpha];;
}


#pragma mark Keyboard Notifications
-(void)onKeyboardDidHide:(NSNotification*)aNotification{
    self.isSearching = NO;
    [self reloadData];
    [self scrollToRowAtCheckMarkedIndexPath];
}

@end

//
//  SearchStringPickerViewController.h
//  mservice
//
//  Created by Adam Hong on 28/03/2018.
//  Copyright © 2018 FCS Computer System. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchStringPickerViewController : UIViewController

+(void)showPickerWithTitle:(NSString *)title
                      rows:(NSArray <NSString *> *)rows
          initialSelection:(NSInteger)initialSelection
                sourceView:(UIView *)sourceView
                 doneBlock:(void (^)(NSInteger selectedIndex, NSString * selectedValue))doneBlock
               cancelBlock:(void (^)(void))cancelBlock
 presentFromViewController:(UIViewController *)presentFromViewController;

+(void)showPickerWithTitle:(NSString *)title
           rowsWithDetails:(NSDictionary<NSString *, NSString *> *)rowsWithDetails
          initialSelection:(NSString *)initialSelection
  pickerTableViewCellStyle:(UITableViewCellStyle)pickerTableViewCellStyle
                sourceView:(UIView *)sourceView
                 doneBlock:(void (^)(NSString *selectedTitle, NSString *selectedDetail))doneBlock
               cancelBlock:(void (^)(void))cancelBlock
 presentFromViewController:(UIViewController *)presentFromViewController;


-(instancetype)initPickerWithTitle:(NSString *)title
                              rows:(NSArray <NSString *> *)rows
                  initialSelection:(NSInteger)initialSelection
                        sourceView:(UIView *)sourceView
                         doneBlock:(void (^)(NSInteger selectedIndex, NSString * selectedValue))doneBlock
                       cancelBlock:(void (^)(void))cancelBlock;

-(instancetype)initPickerWithTitle:(NSString *)title
                   rowsWithDetails:(NSDictionary<NSString *, NSString *> *)rowsWithDetails
                  initialSelection:(NSString *)initialSelection
          pickerTableViewCellStyle:(UITableViewCellStyle)pickerTableViewCellStyle
                        sourceView:(UIView *)sourceView
                         doneBlock:(void (^)(NSString *selectedTitle, NSString *selectedDetail))doneBlock
                       cancelBlock:(void (^)(void))cancelBlock;
@end

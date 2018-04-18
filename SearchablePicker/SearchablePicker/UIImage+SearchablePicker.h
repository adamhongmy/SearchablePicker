//
//  UIImage+Utilities.h
//  mservice
//
//  Created by Adam Hong on 29/11/2017.
//  Copyright © 2017 FCS Computer System. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SearchablePicker)
- (UIImage *)imageWithImage:(UIImage*)originalImage scaledToSize:(CGSize)newSize;
+ (UIImage *)imageFromColor:(UIColor *)color;
@end

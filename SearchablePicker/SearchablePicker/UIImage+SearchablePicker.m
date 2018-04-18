//
//  UIImage+Utilities.m
//  mservice
//
//  Created by Adam Hong on 29/11/2017.
//  Copyright © 2017 FCS Computer System. All rights reserved.
//

#import "UIImage+SearchablePicker.h"

@implementation UIImage (SearchablePicker)
//Ancillary method to scale an image based on a CGSize
- (UIImage *)imageWithImage:(UIImage*)originalImage scaledToSize:(CGSize)newSize;
{
    @synchronized(self)
    {
        UIGraphicsBeginImageContext(newSize);
        [originalImage drawInRect:CGRectMake(0,0,newSize.width, newSize.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
    }
    return nil;
}

+ (UIImage *)imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end


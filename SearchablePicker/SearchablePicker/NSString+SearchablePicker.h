//
//  NSString+Utilities.h
//  mservice
//
//  Created by Adam Hong on 02/11/2017.
//  Copyright © 2017 FCS Computer System. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface
NSString (SearchablePicker)
- (BOOL)isBlank;
- (BOOL)isNumeric;
- (NSString *)stringByStrippingWhitespace;
- (BOOL)contains:(NSString*)string;
- (NSString*)add:(NSString*)string;
- (NSDictionary*)firstAndLastName;
- (BOOL)isValidEmail;
- (BOOL)containsOnlyLetters;
- (BOOL)containsOnlyNumbers;
- (BOOL)containsOnlyNumbersAndLetters;
- (NSString*)safeSubstringToIndex:(NSUInteger)index;
- (NSString*)stringByRemovingPrefix:(NSString*)prefix;
- (NSString*)stringByRemovingPrefixes:(NSArray*)prefixes;
- (BOOL)hasPrefixes:(NSArray*)prefixes;
- (BOOL)isEqualToOneOf:(NSArray*)strings;
- (NSString *)dateStringFromFormat:(NSString *)fromFormat toFormat:(NSString *)toFormat;
- (BOOL) isEqualToIgnoreCaseString:(NSString *)aString;
- (NSString *)stringByPaddingTheLeftToLength:(NSUInteger)newLength withString:(NSString *)padString startingAtIndex:(NSUInteger)padIndex;
- (NSString *)filteredDigitsOnly;
+(NSString *)stringWithBoolean:(BOOL)boolean;
@end

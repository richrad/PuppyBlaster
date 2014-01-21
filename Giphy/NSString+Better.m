//
//  NSString+Better.m
//  Giphy
//
//  Created by Richard Allen on 1/20/14.
//  Copyright (c) 2014 lapdog. All rights reserved.
//

#import "NSString+Better.h"

@implementation NSString (Better)

-(NSString *)escapedStringForURL
{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)self, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8 ));
}

-(NSString *)justNumbers
{
    return [[self componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
}

@end

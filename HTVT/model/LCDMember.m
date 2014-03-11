//
//  CDHTMember.m
//  HTVT
//
//  Created by Matt Stauffer on 2/25/14.
//  Copyright (c) 2014 Matt Stauffer. All rights reserved.
//

#import "LCDMember.h"

static NSString *const MALE_STRING = @"MALE";
static NSString *const FEMALE_STRING = @"FEMALE";

@implementation LCDMember

+ (Gender)genderFromString:(NSString *)genderString {
    Gender gender = MALE;
    if( [genderString isEqualToString:FEMALE_STRING]) {
        gender = FEMALE;
    }
    
    return gender;
}

+ (NSDictionary *)genderNames
{
    return @{@(MALE) : MALE_STRING,
             @(FEMALE) : FEMALE_STRING};
}

+ (NSString *)stringFromGender:(Gender)gender
{
    return [[self class] genderNames][@(gender)];
}

@end

//
//  CDHTMember.h
//  HTVT
//
//  Created by Matt Stauffer on 2/25/14.
//  Copyright (c) 2014 Matt Stauffer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCDMember : NSObject

typedef NS_ENUM( NSInteger, Gender ) {
    MALE,
    FEMALE
};

@property (nonatomic) long individualId;
@property (strong, nonatomic) NSString *formattedName;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *phone;
@property (nonatomic)Gender gender;

+ (Gender)genderFromString:(NSString*)genderString;
+ (NSString*)stringFromGender:(Gender)gender;


@end

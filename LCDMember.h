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

@property (strong, nonatomic) NSString *formattedName;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *phone;
@property Gender *gender;


@end

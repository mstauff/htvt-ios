//
//  CDHTFamily.h
//  HTVT
//
//  Created by Matt Stauffer on 2/25/14.
//  Copyright (c) 2014 Matt Stauffer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCDMember.h"

@interface LCDFamily : NSObject

@property NSString *formattedCoupleName;
@property NSString *phone;
@property NSString *email;
@property LCDMember *headOfHouse;
@property LCDMember *spouse;
@property NSArray *children;
@property NSString *streetAddress;
@property NSString *city;
@property NSString *state;
@property NSString *postal;

- (NSNumber *)getFamilyId;

@end

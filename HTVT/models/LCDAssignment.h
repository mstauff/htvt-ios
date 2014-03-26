//
//  LCDAssignment.h
//  HTVT
//
//  Created by Matt Stauffer on 3/20/14.
//  Copyright (c) 2014 LDS Community Developers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCDCompanionshipMember.h"

@interface LCDAssignment : NSObject <LCDCompanionshipMember>

@property (nonatomic) long id;
@property (nonatomic) long individualId;
@property (nonatomic, strong) NSString *customName;
@property (nonatomic, strong) NSString *customContact;
@property (nonatomic, strong) NSArray *visits;

@end

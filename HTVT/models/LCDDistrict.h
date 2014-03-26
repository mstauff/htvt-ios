//
//  LCDDistrict.h
//  HTVT
//
//  Created by Matt Stauffer on 3/20/14.
//  Copyright (c) 2014 LDS Community Developers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCDMember.h"

@interface LCDDistrict : NSObject

@property (nonatomic) long id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic) long districtLeaderId;
@property (nonatomic, strong) LCDMember *districtLeader;
@property (nonatomic, strong) NSArray *companionships;

@end

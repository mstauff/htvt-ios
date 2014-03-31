//
//  LCDCompanionshipMember.h
//  HTVT
//
//  Created by Matt Stauffer on 3/28/14.
//  Copyright (c) 2014 LDS Community Developers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCDMember.h"

@interface LCDCompanionshipMember : NSObject

@property (readwrite, nonatomic) long id;
@property (readwrite, nonatomic, strong)NSString *customName;
@property (readwrite, nonatomic, strong)NSString *customContact;
@property (readwrite, nonatomic)long individualId;
@property (readwrite, nonatomic, weak)LCDMember *member;


@end

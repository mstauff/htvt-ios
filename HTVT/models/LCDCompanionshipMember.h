//
//  LCDCompanionshipMember.h
//  HTVT
//
//  Created by Matt Stauffer on 3/20/14.
//  Copyright (c) 2014 LDS Community Developers. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LCDCompanionshipMember <NSObject>

@property (readwrite, nonatomic)NSString *customName;
@property (readwrite, nonatomic)NSString *customContact;
@property (readwrite, nonatomic)long individualId;


@end

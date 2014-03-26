//
//  LCDCompanionship.h
//  HTVT
//
//  Created by Matt Stauffer on 3/20/14.
//  Copyright (c) 2014 LDS Community Developers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCDCompanionship : NSObject

@property (nonatomic) long id;
@property (nonatomic, strong) NSArray *teachers;
@property (nonatomic, strong) NSArray *assignments;

@end

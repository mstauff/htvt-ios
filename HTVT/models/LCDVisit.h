//
//  LCDVisit.h
//  HTVT
//
//  Created by Matt Stauffer on 3/20/14.
//  Copyright (c) 2014 LDS Community Developers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCDVisit : NSObject

@property (nonatomic) long id;
@property (nonatomic, strong) NSNumber *visited;
@property (nonatomic) int year;
@property (nonatomic) int month;

@end

//
//  LCDVisit.m
//  HTVT
//
//  Created by Matt Stauffer on 3/20/14.
//  Copyright (c) 2014 LDS Community Developers. All rights reserved.
//

#import "LCDVisit.h"

@implementation LCDVisit

- (NSDictionary *)objectDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys: self.id, @"id", self.visited, @"visited", [NSNumber numberWithInt:self.year], @"year", [NSNumber numberWithInt:self.month], @"month", nil];
}

@end

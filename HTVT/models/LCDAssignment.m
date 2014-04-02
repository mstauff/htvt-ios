//
//  LCDAssignment.m
//  HTVT
//
//  Created by Matt Stauffer on 3/20/14.
//  Copyright (c) 2014 LDS Community Developers. All rights reserved.
//

#import "LCDAssignment.h"
#import "LCDVisit.h"

@implementation LCDAssignment

- (NSNumber *)getVisitedForMonth:(int)monthNumber {
    NSNumber *visited = nil;
    for( LCDVisit *visit in self.visits ) {
        if( visit.month == monthNumber ) {
            visited = visit.visited;
            break;
        }
    }
    
    return visited;
}


@end



//
//  CDHTFamily.m
//  HTVT
//
//  Created by Matt Stauffer on 2/25/14.
//  Copyright (c) 2014 Matt Stauffer. All rights reserved.
//

#import "LCDFamily.h"
#import "LCDMember.h"

@implementation LCDFamily

-(NSNumber *)getFamilyId
{
    NSNumber *familyId = @-1;
    
    if( self.headOfHouse.individualId > 0 ) {
        familyId = [NSNumber numberWithLong:self.headOfHouse.individualId];
    } else if( self.spouse.individualId ) {
        familyId = [NSNumber numberWithLong:self.spouse.individualId];
    } else {
        for( LCDMember *child in self.children ) {
            if( child.individualId > 0 ) {
                familyId = [NSNumber numberWithLong:child.individualId];
                break;
            }
        }
    }
    
    return familyId;
}

@end

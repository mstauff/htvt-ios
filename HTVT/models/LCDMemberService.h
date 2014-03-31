//
//  LCDMemberService.h
//  HTVT
//
//  Created by Matt Stauffer on 3/26/14.
//  Copyright (c) 2014 LDS Community Developers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCDMember.h"
//#import "LCDFamily.h"
#import "LCDDistrict.h"

@interface LCDMemberService : NSObject

- (void)hydrateDistricts:(NSArray *)districts;
- (void)hydrateDistrict:(LCDDistrict *)district;
-(id)initWithFamilyList:(NSArray *)familyList;
-(LCDMember *) memberForIndividualId:(long)individualId;


@end

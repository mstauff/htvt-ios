//
//  LCDMemberService.m
//  HTVT
//
//  Created by Matt Stauffer on 3/26/14.
//  Copyright (c) 2014 LDS Community Developers. All rights reserved.
//

#import "LCDMemberService.h"
#import "LCDFamily.h"
//#import "LCDDistrict.h"
#import "LCDCompanionship.h"
#import "LCDCompanionshipMember.h"

@interface LCDMemberService()

@property (strong, nonatomic) NSArray* familyList;
@property (strong, nonatomic) NSDictionary* memberDictionary;

@end

@implementation LCDMemberService

- (id)initWithFamilyList:(NSArray *)familyList
{
    self = [super init];
    self.familyList = familyList;
    self.memberDictionary = [[NSMutableDictionary alloc] init];
    NSNumber *currMemberIndividualId = nil;
    for( LCDFamily *family in familyList ) {
        if( family.headOfHouse.individualId > 0 ) {
            currMemberIndividualId = [NSNumber numberWithLong:family.headOfHouse.individualId];
            [self.memberDictionary setValue:family.headOfHouse forKey: currMemberIndividualId];
        }
        if( family.spouse.individualId > 0 ) {
            currMemberIndividualId = [NSNumber numberWithLong:family.spouse.individualId];
            [self.memberDictionary setValue:family.spouse forKey: currMemberIndividualId];
        }
        if( family.children ) {
            for( LCDMember *child in family.children ) {
                if( child.individualId > 0 ) {
                    currMemberIndividualId = [NSNumber numberWithLong:child.individualId];
                    [self.memberDictionary setValue:child forKey: currMemberIndividualId];
                }

            }
        }
    }
    
    return self;
}

- (LCDMember *)memberForIndividualId:(long)individualId {
    LCDMember *member = nil;
    NSNumber *individualIdKey = [NSNumber numberWithLong:individualId];
    member = self.memberDictionary[individualIdKey];
    
    return member;
}

- (void)hydrateDistricts:(NSArray *)districts {
    for( LCDDistrict* district in districts ) {
        [self hydrateDistrict:district];
    }
}

- (void)hydrateDistrict:(LCDDistrict *)district {
    for( LCDCompanionship *companionship in district.companionships ) {
        [self hydrateCompanionshipMembers: companionship.assignments];
        [self hydrateCompanionshipMembers: companionship.teachers];
    }
    
}

- (void)hydrateCompanionshipMembers:(NSArray *)companionshipMembers {
    for( LCDCompanionshipMember *compMember in companionshipMembers ) {
        if( [compMember isKindOfClass:[LCDCompanionshipMember class]] ) {
            compMember.member = [self memberForIndividualId:compMember.individualId];
        }
    }
    
}

@end

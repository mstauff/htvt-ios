//
//  CDHTFamilyBuilder.m
//  HTVT
//
//  Created by Matt Stauffer on 2/26/14.
//  Copyright (c) 2014 Matt Stauffer. All rights reserved.
//

#import "LCDHtvtDataBuilder.h"
#import "LCDFamily.h"
#import "LCDConfig.h"

@implementation LCDHtvtDataBuilder

+ (NSArray *)familiesFromJSON:(NSData *)objectNotation error:(NSError *__autoreleasing *)error {
    NSError *localError = nil;
    NSArray* memberListFromJSON = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:error];
    
    if( localError != nil ) {
        *error = localError;
        return nil;
    }
    
    NSMutableArray *families = [[NSMutableArray alloc] init];
    NSLog(@"Returned %d families", memberListFromJSON.count);
    
    for( NSDictionary *familyDictionary in memberListFromJSON ) {
        LCDFamily *family = [ [LCDFamily alloc] init];
        // todo - move these json strings to constants
        for( NSString *key in familyDictionary) {
            if( [key isEqualToString:@"headOfHouse"] ) {
                LCDMember *hoh = [LCDHtvtDataBuilder memberFromDictionary: [familyDictionary objectForKey:key]];
                family.headOfHouse = hoh;
            } else if( [key isEqualToString:@"spouse"] ) {
                NSDictionary *memberDictionary = [familyDictionary objectForKey:key];
                if (memberDictionary && ![memberDictionary isKindOfClass:[NSNull class]]) {
                    LCDMember *spouse = [LCDHtvtDataBuilder memberFromDictionary: memberDictionary];
                    family.spouse = spouse;

                }
            } else if( [key isEqualToString:@"children"] ) {
                NSArray *childJSONArray = [familyDictionary objectForKey:key];
                NSMutableArray *children = nil;
                if( childJSONArray && childJSONArray.count > 0 ) {
                    children = [[NSMutableArray alloc] init];
                    for( NSDictionary *childDictionary in childJSONArray) {
                        LCDMember *child = [LCDHtvtDataBuilder memberFromDictionary:childDictionary];
                        [children addObject:child];
                    }
                }
                
                family.children = children;
            } else if( [family respondsToSelector:NSSelectorFromString(key)]
                      && ![[familyDictionary valueForKey:key] isKindOfClass:[NSNull class]]) {
                // If there is a null in the JSON it comes back as NSNull obj rather
                // than nil, so try to avoid propagating it into the object
                [family setValue:[familyDictionary valueForKey:key] forKey:key];
            }
            
        }
        [families addObject:family];
    }
    return families;
}

+ (LCDMember *)memberFromDictionary:(NSDictionary *)memberDictionary  {
    
    LCDMember *member = [[LCDMember alloc] init];
    
    for( NSString *key in memberDictionary) {
        if( [key isEqualToString:@"gender"] ) {
            member.gender = [LCDMember genderFromString:[memberDictionary objectForKey:key] ];
        } else if( [member respondsToSelector:NSSelectorFromString(key)]) {
            
            //todo - need to deal with address
            [member setValue:[memberDictionary objectForKey:key] forKey:key];
        }
        
    }
    return member;
}

+ (LCDConfig *)configFromJSON:(NSData *)jsonData error:(NSError *__autoreleasing *)error {
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:error];
    
    if( localError != nil ) {
        *error = localError;
        return nil;
    }
    LCDConfig *config = [[LCDConfig alloc] init];
    //    config.urls = [parsedObject valueForKey:@"urls"];
    //    config.params = [parsedObject valueForKey:@"params"];
    for( NSString *key in parsedObject) {
        if( [config respondsToSelector:NSSelectorFromString(key)]) {
            [config setValue:[parsedObject valueForKey:key] forKey:key];
        }
        
    }
    
    
    return config;
}

@end


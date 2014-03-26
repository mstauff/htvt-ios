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
#import "LCDAuxiliary.h"
#import "LCDDistrict.h"
#import "LCDCompanionship.h"
#import "LCDAssignment.h"
#import "LCDTeacher.h"
#import "LCDVisit.h"

@interface LCDHtvtDataBuilder()
@property (nonatomic, strong)NSDictionary *collectionObjectMapping;
@end

@implementation LCDHtvtDataBuilder

- (instancetype)init {
    self = [super init];
    self.collectionObjectMapping = @{ @"companionships" : @"LCDCompanionship",
                                      @"teachers" : @"LCDTeacher",
                                      @"assignments" : @"LCDAssignment",
                                      @"visits" : @"LCDVisit"};
    return self;
}


- (NSArray *)districtsFromJSON:(NSData *)districtsJSON error:(NSError *__autoreleasing *)error {
    
    NSError *localError = nil;
    NSArray* districtListFromJSON = [NSJSONSerialization JSONObjectWithData:districtsJSON options:0 error:error];
    
    if( localError != nil ) {
        *error = localError;
        return nil;
    }
    
    NSArray *districts = [self arrayObjectsFromJSONArray:districtListFromJSON forClass:@"LCDDistrict"];
    NSLog(@"Returned %lu districts", (unsigned long)districtListFromJSON.count);
    
    return districts;
}

- (NSArray *)arrayObjectsFromJSONArray:(NSArray *)jsonArray forClass:(NSString *)objectClassName {
    // todo - need to handle an empty array
    NSMutableArray *objectArray = [[NSMutableArray alloc] init];
    for( NSDictionary *objectDictionary in jsonArray ) {
        id object = [self objectFromJSONDictionary:objectDictionary forClass:objectClassName];
        [objectArray addObject:object];
    }
    
    return objectArray;
}

/*
 This method will work to deserialize json into model objects as long as all attributes are either a
 foundation object property (NSString, int, etc), or an array. Also, for any array attributes there
 needs to be an entry in collectionObjectMapping that maps the attribute to a class type.
 */
- (id)objectFromJSONDictionary:(NSDictionary *)jsonDictionary forClass:(NSString *)objectClassName {
    Class objectMetaClass =  NSClassFromString(objectClassName);
    id object = nil;
    if( objectMetaClass ) {
        object = [[objectMetaClass alloc] init ];
        for( NSString *key in jsonDictionary) {
            if( self.collectionObjectMapping[key] != nil ) {
                // todo - neeed to recursively call collectionFromDict
                NSArray *jsonArray = jsonDictionary[key];
                NSString *arrayObjectClassName = self.collectionObjectMapping[key];
                [object setValue:[self arrayObjectsFromJSONArray:jsonArray forClass:arrayObjectClassName] forKey:key];
            } else if( [object respondsToSelector:NSSelectorFromString(key)]
                      && [self isDictionaryValueNotNull:jsonDictionary forKey:key]) {
                // If there is a null in the JSON it comes back as NSNull obj rather
                // than nil, so try to avoid propagating it into the object
                [object setValue:[jsonDictionary valueForKey:key] forKey:key];
            }
        }
    }
    return object;
}






- (NSArray *)familiesFromJSON:(NSData *)objectNotation error:(NSError *__autoreleasing *)error {
    NSError *localError = nil;
    NSArray* memberListFromJSON = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:error];
    
    if( localError != nil ) {
        *error = localError;
        return nil;
    }
    
    NSMutableArray *families = [[NSMutableArray alloc] init];
    NSLog(@"Returned %lu families", (unsigned long)memberListFromJSON.count);
    
    for( NSDictionary *familyDictionary in memberListFromJSON ) {
        LCDFamily *family = [ [LCDFamily alloc] init];
        // todo - move these json strings to constants
        for( NSString *key in familyDictionary) {
            if( [key isEqualToString:@"headOfHouse"] ) {
                LCDMember *hoh = [self memberFromDictionary: [familyDictionary objectForKey:key]];
                family.headOfHouse = hoh;
            } else if( [key isEqualToString:@"spouse"] ) {
                NSDictionary *memberDictionary = [familyDictionary objectForKey:key];
                if (memberDictionary && ![memberDictionary isKindOfClass:[NSNull class]]) {
                    LCDMember *spouse = [self memberFromDictionary: memberDictionary];
                    family.spouse = spouse;
                    
                }
            } else if( [key isEqualToString:@"children"] ) {
                NSArray *childJSONArray = [familyDictionary objectForKey:key];
                NSMutableArray *children = nil;
                if( childJSONArray && childJSONArray.count > 0 ) {
                    children = [[NSMutableArray alloc] init];
                    for( NSDictionary *childDictionary in childJSONArray) {
                        LCDMember *child = [self memberFromDictionary:childDictionary];
                        [children addObject:child];
                    }
                }
                
                family.children = children;
            } else if( [family respondsToSelector:NSSelectorFromString(key)]
                      && [self isDictionaryValueNotNull:familyDictionary forKey:key]) {
                // If there is a null in the JSON it comes back as NSNull obj rather
                // than nil, so try to avoid propagating it into the object
                [family setValue:[familyDictionary valueForKey:key] forKey:key];
            }
            
        }
        [families addObject:family];
    }
    return families;
}

- (LCDMember *)memberFromDictionary:(NSDictionary *)memberDictionary  {
    
    LCDMember *member = [[LCDMember alloc] init];
    
    for( NSString *key in memberDictionary) {
        if( [key isEqualToString:@"gender"] ) {
            member.gender = [LCDMember genderFromString:[memberDictionary valueForKey:key] ];
        } else if( [self isDictionaryValueNotNull:memberDictionary forKey:key]
                  && [member respondsToSelector:NSSelectorFromString(key)]
                  ) {
            
            //todo - need to deal with address
            [member setValue:memberDictionary[key] forKey:key];
        }
        
    }
    return member;
}

- (LCDConfig *)configFromJSON:(NSData *)jsonData error:(NSError *__autoreleasing *)error {
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:error];
    
    if( localError != nil ) {
        *error = localError;
        return nil;
    }
    LCDConfig *config = [[LCDConfig alloc] init];
    for( NSString *key in parsedObject) {
        if( [config respondsToSelector:NSSelectorFromString(key)]) {
            [config setValue:parsedObject[key] forKey:key];
        }
        
    }
    
    
    return config;
}

- (BOOL)isDictionaryValueNotNull:(NSDictionary *)dictionary forKey:(NSString *)key {
    return ![[dictionary valueForKey:key] isKindOfClass:[NSNull class]];
}

@end


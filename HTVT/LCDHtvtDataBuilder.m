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
    NSDictionary *parseObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:error];
    
    if( localError != nil ) {
        *error = localError;
        return nil;
    }
    
    NSMutableArray *families = [[NSMutableArray alloc] init];
    NSArray *results = [parseObject allValues];
    NSLog(@"Count %d", results.count);
    
    for( NSDictionary *familyDictionary in results ) {
        LCDFamily *family = [ [LCDFamily alloc] init];
        
        for( NSString *key in familyDictionary) {
            if( [family respondsToSelector:NSSelectorFromString(key)]) {
                [family setValue:[familyDictionary valueForKey:key] forKey:key];
            }
            
        }
    }
    return families;
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


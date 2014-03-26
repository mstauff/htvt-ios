//
//  CDHTFamilyBuilder.h
//  HTVT
//
//  Created by Matt Stauffer on 2/26/14.
//  Copyright (c) 2014 Matt Stauffer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCDConfig.h"
#import "LCDMember.h"

@interface LCDHtvtDataBuilder : NSObject

- (NSArray *)familiesFromJSON:(NSData *)objectNotation error:(NSError **)error;
- (LCDConfig *)configFromJSON:(NSData *)objectNotation error:(NSError **)error;
- (NSArray *)districtsFromJSON:(NSData *)districtsJSON error:(NSError **)error;
- (NSArray *)arrayObjectsFromJSONArray:(NSArray *)jsonArray forClass:(NSString *)objectClassName;
- (id)objectFromJSONDictionary:(NSDictionary *)jsonDictionary forClass:(NSString *)objectClassName;

@end



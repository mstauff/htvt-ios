//
//  CDHTHtvtCommunicatorDelegate.h
//  HTVT
//
//  Created by Matt Stauffer on 2/25/14.
//  Copyright (c) 2014 Matt Stauffer. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LCDHtvtCommunicatorDelegate <NSObject>
//- (void)receivedMembersJSON:(NSData *)objectNotation;
//- (void)fetchingMembersFailedWithError:(NSError *)error;
- (void)receivedConfigJSON:(NSData *)objectNotation;
- (void)fetchingConfigFailedWithError:(NSError *)error;

@end

//
//  LCDHtvtDataManager.m
//  HTVT
//
//  Created by Matt Stauffer on 2/26/14.
//  Copyright (c) 2014 LDS Community Developers. All rights reserved.
//

#import "LCDHtvtDataManager.h"
#import "LCDHtvtDataBuilder.h"
#import "LCDHtvtCommunicator.h"
#import "LCDConfig.h"

@implementation LCDHtvtDataManager

- (void)fetchConfig {
    [self.communicator getConfig];
}

#pragma mark - LCDHtvtCommunicatorDelegate
-(void)receivedConfigJSON:(NSData *)objectNotation
{
    NSError *error = nil;
    LCDConfig *config = [LCDHtvtDataBuilder configFromJSON:objectNotation error:&error];
    
    if (error != nil) {
        [self.delegate fetchingConfigFailedWithError:error];
        
    } else {
        [self.delegate didReceiveConfig:config];
    }
    
}

- (void)fetchingConfigFailedWithError:(NSError *)error
{
    [self.delegate fetchingConfigFailedWithError:error];
}

@end

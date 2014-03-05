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

@implementation LCDHtvtDataManager {
    loadConfigBlock_t _configLoadedBlock;
    errorBlock_t _errorBlock;
    
}

- (id)init {
    self = [super init];
    self.communicator = [[LCDHtvtCommunicator alloc] init];
    self.communicator.delegate = self;
   
    return self;
}

- (void)fetchConfig : (loadConfigBlock_t) loadConfigBlock : (errorBlock_t) errorBlock {
    [self.communicator getConfig];
    _configLoadedBlock = loadConfigBlock;
    _errorBlock = errorBlock;
    
}

#pragma mark - LCDHtvtCommunicatorDelegate
-(void)receivedConfigJSON:(NSData *)objectNotation
{
    NSError *error = nil;
    LCDConfig *config = [LCDHtvtDataBuilder configFromJSON:objectNotation error:&error];
    
    if (error != nil) {
        _errorBlock( error );
        
    } else {
        _configLoadedBlock( config );
    }
    
}

- (void)fetchingConfigFailedWithError:(NSError *)error
{
    _errorBlock( error );
}

@end

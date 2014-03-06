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
    
}

- (id)init {
    self = [super init];
    self.communicator = [[LCDHtvtCommunicator alloc] init];
   
    return self;
}

- (void)fetchConfig : (fetchConfigCompletionHandler_t) configLoadedBlock {
    [self.communicator getConfig:^(NSData* data, NSError* error){
        NSError *jsonError = nil;
        LCDConfig *config = nil;
        if( !error ) {
            config = [LCDHtvtDataBuilder configFromJSON:data error:&jsonError];
            error = jsonError;
            
        }
        configLoadedBlock( config, error );
        
    }];
    
}

@end

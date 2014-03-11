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

#define htvtConfigUrl @"http://htvt-ldscd.rhcloud.com/config"
//#define htvtConfigUrl @"http://localhost:8080/config"

@implementation LCDHtvtDataManager {
    LCDConfig* _config;
    
}

- (instancetype)init {
    self = [super init];
    self.communicator = [[LCDHtvtCommunicator alloc] init];
   
    return self;
}

- (void)fetchConfig : (fetchConfigCompletionHandler_t) configLoadedBlock {
    [self.communicator getConfig:htvtConfigUrl completionHandler:^(NSData* data, NSError* error){
        NSError *jsonError = nil;
        LCDConfig *config = nil;
        if( !error ) {
            config = [LCDHtvtDataBuilder configFromJSON:data error:&jsonError];
            error = jsonError;
            
        }
        _config = config;
        configLoadedBlock( config, error );
        
    }];
    
}

- (void)fetchMemberList:(long) unitNumber withCompletionHandler:(fetchMemberListCompletionHandler_t) memberListLoadedBlock {
    
    NSString* memberListUrl = [NSString stringWithFormat:[_config.urls objectForKey:CONFIG_URL_MEMBER_LIST], [NSNumber numberWithLong:unitNumber]];
    [self.communicator getMembersForUnit: memberListUrl completionHandler:^(NSData* data, NSError* error){
            NSError *jsonError = nil;
            NSArray* memberList = nil;
    
        if( !error ) {
            memberList = [LCDHtvtDataBuilder familiesFromJSON:data error:&jsonError];
            error = jsonError;
            
        }
        memberListLoadedBlock( memberList, error );
    
    }];
    
}

@end

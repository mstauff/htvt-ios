//
//  LCDHtvtDataManager.h
//  HTVT
//
//  Created by Matt Stauffer on 2/26/14.
//  Copyright (c) 2014 LDS Community Developers. All rights reserved.
//

@import Foundation;
#import "LCDHtvtCommunicator.h"
#import "LCDConfig.h"
#import "LCDConstants.h"

typedef void (^fetchConfigCompletionHandler_t)(LCDConfig* config, NSError* error);
typedef void (^fetchMemberListCompletionHandler_t)(NSArray* memberList,
                                                   NSError* error);

@interface LCDHtvtDataManager : NSObject
@property (strong, nonatomic)LCDHtvtCommunicator *communicator;

- (void)fetchConfig:(fetchConfigCompletionHandler_t)configLoadedBlock;
- (void)fetchMemberList: (long)unitNumber withCompletionHandler:(fetchMemberListCompletionHandler_t)memberListLoadedBlock;

@end

//
//  LCDHtvtDataManager.h
//  HTVT
//
//  Created by Matt Stauffer on 2/26/14.
//  Copyright (c) 2014 LDS Community Developers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCDHtvtCommunicatorDelegate.h"
#import "LCDConfig.h"

typedef void (^loadConfigBlock_t)(LCDConfig* payload);
typedef void (^errorBlock_t)(NSError* error);

@class LCDHtvtCommunicator;

@interface LCDHtvtDataManager : NSObject<LCDHtvtCommunicatorDelegate>
@property (strong, nonatomic)LCDHtvtCommunicator *communicator;

- (void)fetchConfig:(loadConfigBlock_t)configLoadedBlock : (errorBlock_t)errorBlock;

@end

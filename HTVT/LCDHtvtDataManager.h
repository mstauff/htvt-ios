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

typedef void (^fetchConfigCompletionHandler_t)(LCDConfig* config, NSError* error);


@interface LCDHtvtDataManager : NSObject
@property (strong, nonatomic)LCDHtvtCommunicator *communicator;

- (void)fetchConfig:(fetchConfigCompletionHandler_t)configLoadedBlock;

@end

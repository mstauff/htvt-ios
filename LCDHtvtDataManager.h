//
//  LCDHtvtDataManager.h
//  HTVT
//
//  Created by Matt Stauffer on 2/26/14.
//  Copyright (c) 2014 LDS Community Developers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCDHtvtDataManagerDelegate.h"
#import "LCDHtvtCommunicatorDelegate.h"

@class LCDHtvtCommunicator;

@interface LCDHtvtDataManager : NSObject<LCDHtvtCommunicatorDelegate>
@property (strong, nonatomic)LCDHtvtCommunicator *communicator;
@property (weak, nonatomic)id<LCDHtvtDataManagerDelegate> delegate;

- (void)fetchConfig;

@end

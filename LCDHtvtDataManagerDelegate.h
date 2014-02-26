//
//  LCDHtvtDataManagerDelegate.h
//  HTVT
//
//  Created by Matt Stauffer on 2/26/14.
//  Copyright (c) 2014 LDS Community Developers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCDConfig.h"

@protocol LCDHtvtDataManagerDelegate
- (void)didReceiveConfig:(LCDConfig *)config;
- (void)fetchingConfigFailedWithError:(NSError *)error;

@end

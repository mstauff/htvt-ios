//
//  CDHTHtvtCommunicator.h
//  HTVT
//
//  Created by Matt Stauffer on 2/25/14.
//  Copyright (c) 2014 Matt Stauffer. All rights reserved.
//

//#import <Foundation/Foundation.h>
@protocol LCDHtvtCommunicatorDelegate;

@interface LCDHtvtCommunicator : NSObject
@property (weak, nonatomic) id<LCDHtvtCommunicatorDelegate> delegate;

-(void)getConfig;
//-(void)getMembersForUnit:(long) unitNum;

@end

//
//  CDHTHtvtCommunicator.h
//  HTVT
//
//  Created by Matt Stauffer on 2/25/14.
//  Copyright (c) 2014 Matt Stauffer. All rights reserved.
//

//#import <Foundation/Foundation.h>
typedef void (^dataRequestCompletionHandler_t)(NSData* payload, NSError* error);

@interface LCDHtvtCommunicator : NSObject

-(void)getConfig:(dataRequestCompletionHandler_t)dataRequestCompleteBlock;
//-(void)getMembersForUnit:(long) unitNum;

@end

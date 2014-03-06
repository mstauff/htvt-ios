//
//  CDHTHtvtCommunicator.m
//  HTVT
//
//  Created by Matt Stauffer on 2/25/14.
//  Copyright (c) 2014 Matt Stauffer. All rights reserved.
//

#import "LCDHtvtCommunicator.h"

#define htvtConfigUrl @"http://htvt-ldscd.rhcloud.com/config"

@implementation LCDHtvtCommunicator {
    NSString *memberListUrl;
    
}


- (void)httpRequest:(NSURL *)configUrl
  completionHandler:(dataRequestCompletionHandler_t)dataRequestCompleteBlock {
    NSLog(@"Connecting to %@", htvtConfigUrl);
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:configUrl] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
        
        if( httpResponse.statusCode != 200 ) {
            NSMutableDictionary* errorDetail = [NSMutableDictionary dictionary];
            [errorDetail setValue:@"Http Error" forKey:NSLocalizedDescriptionKey];
            [errorDetail setValue:[NSString stringWithFormat:@"%d", httpResponse.statusCode] forKey:NSLocalizedFailureReasonErrorKey];
            error = [NSError errorWithDomain:@"ldscd.htvt" code:httpResponse.statusCode userInfo:errorDetail];
        }
        
        dataRequestCompleteBlock( data, error );
    }];
}

-(void)getConfig:(dataRequestCompletionHandler_t)dataRequestCompleteBlock {
    NSURL *configUrl = [ [NSURL alloc] initWithString:htvtConfigUrl];
    [self httpRequest:configUrl completionHandler:dataRequestCompleteBlock];
    
}


//- (void)getMembersForUnit:(long)unitNum {
//    NSURL *url = [[NSURL alloc] initWithString:memberListUrl];
//    NSLog(@"%@", url.path);
//    
//    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//        
//        if (error) {
//            [self.delegate fetchingMembersFailedWithError:error];
//        } else {
//            [self.delegate receivedMembersJSON:data];
//        }
//    }];
//}

@end

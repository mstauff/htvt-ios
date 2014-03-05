//
//  CDHTHtvtCommunicator.m
//  HTVT
//
//  Created by Matt Stauffer on 2/25/14.
//  Copyright (c) 2014 Matt Stauffer. All rights reserved.
//

#import "LCDHtvtCommunicator.h"
#import "LCDHtvtCommunicatorDelegate.h"

#define htvtConfigUrl @"http://htvt-ldscd.rhcloud.com/confi"

@implementation LCDHtvtCommunicator {
    NSString *memberListUrl;
    
}


-(void)getConfig {
    NSURL *configUrl = [ [NSURL alloc] initWithString:htvtConfigUrl];
    NSLog(@"Connecting to %@", htvtConfigUrl);
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:configUrl] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
        
        if (error) {
            [self.delegate fetchingConfigFailedWithError:error];
        } else if( httpResponse.statusCode == 200 ) {
            [self.delegate receivedConfigJSON:data];
        } else {
            NSMutableDictionary* errorDetail = [NSMutableDictionary dictionary];
            [errorDetail setValue:@"Http Error" forKey:NSLocalizedDescriptionKey];
            [errorDetail setValue:[NSString stringWithFormat:@"%d", httpResponse.statusCode] forKey:NSLocalizedFailureReasonErrorKey];
            [self.delegate fetchingConfigFailedWithError:[NSError errorWithDomain:@"ldscd.htvt" code:httpResponse.statusCode userInfo:errorDetail]];
        }
    }];
    
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

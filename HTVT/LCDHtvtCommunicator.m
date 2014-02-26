//
//  CDHTHtvtCommunicator.m
//  HTVT
//
//  Created by Matt Stauffer on 2/25/14.
//  Copyright (c) 2014 Matt Stauffer. All rights reserved.
//

#import "LCDHtvtCommunicator.h"
#import "LCDHtvtCommunicatorDelegate.h"

#define htvtConfigUrl @"http://htvt-ldscd.rhcloud.com/config"

@implementation LCDHtvtCommunicator {
    NSString *memberListUrl;
    
}


-(void)getConfig {
    NSURL *configUrl = [ [NSURL alloc] initWithString:htvtConfigUrl];
    NSLog(@"Connecting to %@", htvtConfigUrl);
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:configUrl] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            [self.delegate fetchingConfigFailedWithError:error];
        } else {
            [self.delegate receivedConfigJSON:data];
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

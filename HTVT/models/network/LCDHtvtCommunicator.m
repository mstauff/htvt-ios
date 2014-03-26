//
//  CDHTHtvtCommunicator.m
//  HTVT
//
//  Created by Matt Stauffer on 2/25/14.
//  Copyright (c) 2014 Matt Stauffer. All rights reserved.
//

#import "LCDHtvtCommunicator.h"


@implementation LCDHtvtCommunicator {
    
}


- (void)httpRequest:(NSURL *)configUrl
  completionHandler:(dataRequestCompletionHandler_t)dataRequestCompleteBlock {
    NSLog(@"Connecting to %@", configUrl);
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:configUrl] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
        
        if( httpResponse.statusCode != 200 ) {
            NSMutableDictionary* errorDetail = [NSMutableDictionary dictionary];
            [errorDetail setValue:@"Http Error" forKey:NSLocalizedDescriptionKey];
            [errorDetail setValue:[NSString stringWithFormat:@"%ld", (long)httpResponse.statusCode] forKey:NSLocalizedFailureReasonErrorKey];
            error = [NSError errorWithDomain:@"ldscd.htvt" code:httpResponse.statusCode userInfo:errorDetail];
        }
        
        dataRequestCompleteBlock( data, error );
    }];
}

-(void)makeHttpRequest:(NSString*)url completionHandler:(dataRequestCompletionHandler_t)dataRequestCompletedBlock {
    NSURL *configUrl = [ [NSURL alloc] initWithString:url];
    [self httpRequest:configUrl completionHandler:dataRequestCompletedBlock];
}

-(void)getConfig:(NSString*)url completionHandler:(dataRequestCompletionHandler_t)dataRequestCompleteBlock {
    [self makeHttpRequest:url completionHandler:dataRequestCompleteBlock];
}


- (void)getMembersForUnit:(NSString*)url completionHandler:(dataRequestCompletionHandler_t)dataRequestCompleteBlock {
    [self makeHttpRequest:url completionHandler:dataRequestCompleteBlock];
}

- (void)getDistrictsForAuxiliary:(NSString*)url completionHandler:(dataRequestCompletionHandler_t)dataRequestCompleteBlock {
    [self makeHttpRequest:url completionHandler:dataRequestCompleteBlock];
}


@end

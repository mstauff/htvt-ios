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
    [self httpRequest:configUrl withPostBody:nil completionHandler:dataRequestCompleteBlock];
}

-(void)httpRequest:(NSURL *)configUrl withPostBody:(NSData *)postBody completionHandler:(dataRequestCompletionHandler_t)dataRequestCompleteBlock {
    
    NSLog(@"Connecting to %@", configUrl);
    NSMutableURLRequest *request =[[NSMutableURLRequest alloc] initWithURL:configUrl];
    [request setHTTPBody:postBody];
    if( postBody ) {
        [request setHTTPMethod:@"POST"];
    }
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
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
    [self makeHttpRequest:url withPostBodyObject:nil completionHandler:dataRequestCompletedBlock];
}

- (void)makeHttpRequest:(NSString *)url withPostBodyObject:(NSData *)postBodyObject completionHandler:(dataRequestCompletionHandler_t)dataRequestCompletedBlock {
    NSURL *configUrl = [ [NSURL alloc] initWithString:url];
    [self httpRequest:configUrl withPostBody:postBodyObject completionHandler:dataRequestCompletedBlock];
    
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

- (void)recordVisit:(NSString *)url visitAsJson:(NSData *)visit completionHandler:(dataRequestCompletionHandler_t)dataRequestCompletedBlock {
    [self makeHttpRequest:url withPostBodyObject:visit completionHandler:dataRequestCompletedBlock];
}


@end

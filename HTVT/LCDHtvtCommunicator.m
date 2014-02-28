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

//- (void)loadConfig
//{
//    NSURL *restURL = [NSURL URLWithString:htvtConfigUrl];
//    NSURLRequest *restRequest = [NSURLRequest requestWithURL:restURL];
//
//    // cancel any possible existing connection
//    if( currentConnection ) {
//        [currentConnection cancel];
//        currentConnection = nil;
//        self.apiReturnJSONData = nil;
//    }
//
//    currentConnection = [[NSURLConnection alloc] initWithRequest:restRequest delegate:self];
//
//    self.apiReturnJSONData = [NSMutableData data];
//
//}

//- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response {
//    [self.apiReturnJSONData setLength:0];
//}
//
//- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData *)data {
//    [self.apiReturnJSONData appendData:data];
//}
//
//- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError *)error {
//    NSLog(@"URL Connection Failed");
//    currentConnection = nil;
//}

//- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
//    NSLog(@"Finished Loading data");
//    currentConnection = nil;
//    NSError *error =[[NSError alloc] init];
//    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:self.apiReturnJSONData options:0 error:&error];
//
////    if( error == nil ) {
////        *error = localError;
////        return nil;
////    }
//    LCDConfig *config = [[LCDConfig alloc] init];
//    //    config.urls = [parsedObject valueForKey:@"urls"];
//    //    config.params = [parsedObject valueForKey:@"params"];
//    for( NSString *key in parsedObject) {
//        if( [config respondsToSelector:NSSelectorFromString(key)]) {
//            [config setValue:[parsedObject valueForKey:key] forKey:key];
//        }
//
//    }
//    self.label.text = [ NSString stringWithFormat:@"Loaded %lu Properties", (unsigned long)config.urls.allKeys.count];
//
//
//
//}

@end

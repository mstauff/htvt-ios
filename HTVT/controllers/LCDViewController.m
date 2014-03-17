//
//  CDHTViewController.m
//  HTVT
//
//  Created by Matt Stauffer on 2/25/14.
//  Copyright (c) 2014 Matt Stauffer. All rights reserved.
//

#import "LCDViewController.h"
#import "LCDConfig.h"
#import "LCDHtvtDataManager.h"

@interface LCDViewController ()
    @property (nonatomic, strong) LCDHtvtDataManager *manager;

@end

@implementation LCDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _manager = [[LCDHtvtDataManager alloc] init];
    [self loadConfig];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void (^)(void))networkError: (NSError*) error {
    return ^ {
        //run the UI update on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            self.label.text = @"Error Loading Config";
            NSLog( @"Error loading config: %@", error.description );
        });
};
}

- (void)loadConfig
{
    [_manager fetchConfig:^(LCDConfig* config, NSError* error) {
        if( error ) {
            [self fetchingConfigFailedWithError:error];
        } else {
            [self didReceiveConfig:config];
        }
    } ];
}

- (void)didReceiveConfig:(LCDConfig *)config {
    _config = config;
    //run the UI update on the main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        self.label.text = [ NSString stringWithFormat:@"Loaded %lu Properties", (unsigned long)config.urls.allKeys.count];
        NSLog( @"Assigned label: %@", self.label.text );
        [self loadMemberList];
        
    });
    NSLog( @"Exiting didReceiveConfig" );
}

- (void)didReceiveMemberList:(NSArray* )memberList {
    //run the UI update on the main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        self.label.text = [ NSString stringWithFormat:@"Loaded %lu Members", (unsigned long)memberList.count];
        NSLog( @"Assigned label: %@", self.label.text );
        
        
    });
    NSLog( @"Exiting didReceiveConfig" );
}

- (void)fetchingConfigFailedWithError:(NSError *)error {
    NSLog(@"Error %@; %@", error, [error localizedDescription]);
    [self networkError:error];
}

- (void)loadMemberList
{
    [_manager fetchMemberList:111 withCompletionHandler:^(NSArray* memberList, NSError* error) {
        if( error ) {
            [self networkError:error];
        } else {
            [self didReceiveMemberList:memberList];
        }
    }];
}
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

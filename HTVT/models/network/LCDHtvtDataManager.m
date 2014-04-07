//
//  LCDHtvtDataManager.m
//  HTVT
//
//  Created by Matt Stauffer on 2/26/14.
//  Copyright (c) 2014 LDS Community Developers. All rights reserved.
//

#import "LCDHtvtDataManager.h"
#import "LCDHtvtDataBuilder.h"
#import "LCDHtvtCommunicator.h"
#import "LCDConfig.h"

@interface LCDHtvtDataManager()
@property (nonatomic, strong) LCDConfig *config;
@property (nonatomic, strong) NSArray *memberList;
@property (nonatomic, strong) NSArray *districtList;
@property (nonatomic, strong) LCDHtvtDataBuilder *dataBuilder;


@end

@implementation LCDHtvtDataManager

//NSString * const HTVT_CONFIG_URL = @"http://htvt-ldscd.rhcloud.com/config";
NSString * const HTVT_CONFIG_URL = @"http://localhost:8080/config";


- (instancetype)init {
    self = [super init];
    self.communicator = [[LCDHtvtCommunicator alloc] init];
    self.dataBuilder = [[LCDHtvtDataBuilder alloc] init];
    
    return self;
}

- (void)fetchConfig : (fetchConfigCompletionHandler_t) configLoadedBlock {
    if( self.config ) {
        configLoadedBlock( self.config, nil );
    } else {
        [self.communicator getConfig:HTVT_CONFIG_URL completionHandler:^(NSData *data, NSError *error){
            NSError *jsonError = nil;
            LCDConfig *config = nil;
            if( !error ) {
                config = [self.dataBuilder configFromJSON:data error:&jsonError];
                error = jsonError;
                
            }
            self.config = config;
            configLoadedBlock( config, error );
            
        }];
        
    }
    
}

- (void)fetchMemberList:(long) unitNumber withCompletionHandler:(fetchMemberListCompletionHandler_t) memberListLoadedBlock {
    
    if( self.memberList ) {
        memberListLoadedBlock( self.memberList, nil );
    } else {
        NSString *memberListUrl = [NSString stringWithFormat:[_config.urls objectForKey:CONFIG_URL_MEMBER_LIST], [NSNumber numberWithLong:unitNumber]];
        [self.communicator getMembersForUnit: memberListUrl completionHandler:^(NSData *data, NSError *error){
            NSError *jsonError = nil;
            NSArray *memberList = nil;
            
            if( !error ) {
                memberList = [self.dataBuilder familiesFromJSON:data error:&jsonError];
                error = jsonError;
                
            }
            self.memberList = memberList;
            memberListLoadedBlock( memberList, error );
        }];
    }
}

- (void)fetchDistrictList:(long) auxiliaryId withCompletionHandler:(fetchDistrictListCompletionHandler_t) districtListLoadedBlock {
    
    if( self.districtList ) {
        districtListLoadedBlock( self.districtList, nil );
    } else {
        NSString *districtListUrl = [NSString stringWithFormat:[_config.urls objectForKey:CONFIG_URL_HTVT_DISTRICTS], @111, [NSNumber numberWithLong:auxiliaryId]];
        [self.communicator getDistrictsForAuxiliary:districtListUrl completionHandler:^(NSData *data, NSError *error){
            NSError *jsonError = nil;
            NSArray *districtList = nil;
            
            if( !error ) {
                districtList = [self.dataBuilder districtsFromJSON:data error:&jsonError];
                error = jsonError;
                
            }
            self.districtList = districtList;
            districtListLoadedBlock( districtList, error );
            
        }];
    }
}

- (void)recordVisit:(LCDVisit *)visit forUnit:(long)unitNumber withCompletionHandler:(recordVisitCompletionHandler_t)recordVisitCompletedBlock {
    NSDictionary *objectDictionary = visit.objectDictionary;
    NSError *jsonError;
    NSData *visitJson = [NSJSONSerialization dataWithJSONObject:objectDictionary options:0 error:&jsonError];
    NSString *recordVisitUrl = [NSString stringWithFormat:[self.config.urls objectForKey:CONFIG_URL_VISIT_RECORD], @111];
    [self.communicator recordVisit:recordVisitUrl visitAsJson:visitJson completionHandler:^(NSData *data, NSError *error) {
        LCDVisit *visitResult = nil;
        if ( !error ) {
            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            visitResult = [self.dataBuilder objectFromJSONDictionary:jsonDictionary forClass:@"LCDVisit"];
            
        }
        recordVisitCompletedBlock( visitResult, error );
    }];
    
    
}

- (void)deleteVisit:(long)visitId forUnit:(long)unitNumber withCompletionHandler:(deleteDataCompletionHandler_t)deletedVisitCompletedBlock {
    NSString *deleteVisitUrl = [NSString stringWithFormat:[self.config.urls objectForKey:CONFIG_URL_VISIT_DELETE], @111, [[NSNumber numberWithLong:visitId] stringValue]];
    [self.communicator deleteVisit:deleteVisitUrl visitId:visitId completionHandler:^(NSData *data, NSError *error) {
        deletedVisitCompletedBlock( error );
    }];
    
    
}
@end

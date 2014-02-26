//
//  LCDConstants.h
//  HTVT
//
//  Created by Matt Stauffer on 2/26/14.
//  Copyright (c) 2014 LDS Community Developers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCDConstants : NSObject

// URL keys
extern NSString *const CONFIG_URL_LOGIN;
extern NSString *const CONFIG_URL_LOGOUT;
extern NSString *const CONFIG_URL_CURRENT_USER;
extern NSString *const CONFIG_URL_MEMBER_LIST;
extern NSString *const CONFIG_URL_HTVT_DISTRICTS;
extern NSString *const CONFIG_URL_DISTRICT_CREATE;
extern NSString *const CONFIG_URL_DISTRICT_UPDATE;
extern NSString *const CONFIG_URL_DISTRICT_DELETE;
extern NSString *const CONFIG_URL_COMP_CREATE;
extern NSString *const CONFIG_URL_COMP_DELETE;
extern NSString *const CONFIG_URL_VISIT_RECORD;
extern NSString *const CONFIG_URL_VISIT_DELETE;
extern NSString *const CONFIG_URL_LATEST_VISITS;

// property keys
extern NSString *const CONFIG_PROP_CACHE_MEMBER_DATA;

@end

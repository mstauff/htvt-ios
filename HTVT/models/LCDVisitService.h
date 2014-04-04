//
//  LCDVisitService.h
//  HTVT
//
//  Created by Matt Stauffer on 4/2/14.
//  Copyright (c) 2014 LDS Community Developers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCDVisit.h"

@interface LCDVisitService : NSObject

+ (int)getCurrentReportingMonth;
+ (int)getReportingMonthForDate:(NSDate *)date;
+ (LCDVisit *)getVisitForMonth:(int) month fromList:(NSArray *)visitList;

@end

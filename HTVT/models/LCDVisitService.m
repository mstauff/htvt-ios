//
//  LCDVisitService.m
//  HTVT
//
//  Created by Matt Stauffer on 4/2/14.
//  Copyright (c) 2014 LDS Community Developers. All rights reserved.
//

#import "LCDVisitService.h"

@implementation LCDVisitService

int const MID_MONTH_THRESHHOLD = 15;

+ (int)getCurrentReportingMonth {
    return [self.class getReportingMonthForDate:[NSDate date]];
}

+ (int)getReportingMonthForDate:(NSDate *)date {
    int currentMonth = 2;
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit fromDate:date];
    NSInteger day = components.day;
    currentMonth = components.month;
    
    // if we're in the first half of the month we default to the previous month
    if( day < MID_MONTH_THRESHHOLD ) {
        currentMonth--;
    }
    return currentMonth;
    
}


@end

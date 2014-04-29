//
//  LCDVisitServicesTest.m
//  HTVT
//
//  Created by Alex Carrasco on 4/16/14.
//  Copyright (c) 2014 LDS Community Developers. All rights reserved.
//
#import "LCDVisitService.h"
#import <XCTest/XCTest.h>


@interface LCDVisitServicesTest : XCTestCase
@end

@implementation LCDVisitServicesTest


int const MID_MONTH_THRESHHOLD = 15;

// utils declaration
-(LCDVisit *) createVisit:(int)visitID withMonth:(int)month withYear:(int)year withIsVisited:(int) isVisited
{
    // create and returns visit object
    LCDVisit *newVisit = [[LCDVisit alloc]init];
    newVisit.id= @(visitID);
    newVisit.month=month;
    newVisit.year =year;
    newVisit.visited=@(isVisited);
    return newVisit;
}

-(int ) getReportingMonth:(NSDate*) currDate
{
    // returns the current month of the reporting.
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:currDate];
    int currmonth = components.month;
    NSInteger day = components.day;
    // if date falls under 15 then we discount one to the current month
    if( day < MID_MONTH_THRESHHOLD ) {
        currmonth--;
    }
    return currmonth;
}

-(NSDate* ) dateFromString:(NSString*) dateString
{
    //returns a date object from a string date
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc]init];
    dateFormater.timeStyle=NSDateFormatterNoStyle;
    dateFormater.dateFormat=@"MM-dd-yyyy";
    NSDate *date=[dateFormater dateFromString:dateString];
    return date;
}

-(void) validateVisitInList:(NSArray*) visitList visitToFind:(LCDVisit*) visit exceptionMessage:(NSString*) message visitExpectedInlist:(BOOL) visitFoundOnList
{
    LCDVisit *visitResult=[LCDVisitService getVisitForMonth:(visit.month) fromList:visitList] ;
    if(visitFoundOnList){
        XCTAssertEqual(visitResult.id,visit.id,@"%@" ,message);
        
    }else{
        XCTAssertNil(visitResult, @"%@" ,message);
    }
}

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testgetCurrentReportingMonth
{
    NSLog(@"Starting getCurrentReportingMonthTest -------------------------");
    NSDate* date=[[NSDate alloc] init];
    
    // get current month based on  current date
    int currentMonth = [self getReportingMonth: date];

    // get current month from server
    int result=[LCDVisitService getCurrentReportingMonth];
    XCTAssertEqual(result,currentMonth,@"did not return current month" );
    
}

-(void)testgetReportingMonthForDate
{
    NSLog(@"Starting getReportingMonthForDateTest -------------------------");
    //todo Use NSString formatting to take in account the threshold value when passing a datemkk
    // passing a date below the month threshhold
    NSDate* dateBelowTheThreshold=[self dateFromString:@"04-01-2014"];
    int monthBelowThreshold = [self getReportingMonth: dateBelowTheThreshold];
    int resultBelowtheThreshold=[LCDVisitService getReportingMonthForDate:dateBelowTheThreshold] ;
    XCTAssertEqual(resultBelowtheThreshold,monthBelowThreshold ,@"did not return correct month");
    

    // passing a date below the month threshhold
    NSDate* dateAboveTheThreshold=[self dateFromString:@"04-17-2014"];
    int monthAboveThreshold = [self getReportingMonth: dateAboveTheThreshold];
    int resultAbovetheThreshold=[LCDVisitService getReportingMonthForDate:dateAboveTheThreshold] ;
    XCTAssertEqual(resultAbovetheThreshold,monthAboveThreshold ,@"did not return correct month");

}

-(void)testgetVisitForMonth
{
    NSLog(@"Starting getVisitForMonthTest -------------------------");
    
    // create 3 visits
    LCDVisit *visitToFindInlist=[self createVisit:1122 withMonth:6 withYear:2014 withIsVisited:1];
    LCDVisit *visitDontCare=[self createVisit:1133 withMonth:5 withYear:2014 withIsVisited:0];
    LCDVisit *visitDontCare2=[self createVisit:1144 withMonth:4 withYear:2014 withIsVisited:0];
    
    // 1. visit to be found first in the list
    NSArray *visitListFoundFirstInTheList=@[visitToFindInlist,visitDontCare, visitDontCare2];
    [self validateVisitInList:visitListFoundFirstInTheList visitToFind:visitToFindInlist exceptionMessage:@"did not return one visit for the requested month" visitExpectedInlist:true];
    
    
    // 2.visit to be found second in the list
    NSArray *visitListFoundInTheMiddle=@[visitDontCare, visitToFindInlist,visitDontCare2];
    [self validateVisitInList:visitListFoundInTheMiddle visitToFind:visitToFindInlist exceptionMessage:@"did not return one visit for the requested month" visitExpectedInlist:true];
   
  
    // 3.visit NOT to be found in the list at all
     NSArray *visitListWithNoVisitFound=@[visitDontCare,visitDontCare2];
    [self validateVisitInList:visitListWithNoVisitFound visitToFind:visitToFindInlist exceptionMessage:@"Returned something. expected nill" visitExpectedInlist:false];
   
    
    // 4.passing an empty list
     NSArray *visitListEmpty=@[visitDontCare,visitDontCare2];
    [self validateVisitInList:visitListEmpty visitToFind:visitToFindInlist exceptionMessage:@"Returned something. expected nill" visitExpectedInlist:false];
 
}

@end

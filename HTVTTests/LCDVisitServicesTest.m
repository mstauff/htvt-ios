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
    int currentMonth = [self getCurrentmonth: date];

    // get current month from server
    int result=[LCDVisitService getCurrentReportingMonth];
    XCTAssertEqual(result,currentMonth,@"did not return current month" );
    
}

-(void)testgetReportingMonthForDate
{
    NSLog(@"Starting getReportingMonthForDateTest -------------------------");
    
    //todo fix this ones with miningfull variables
    // passing date above month threshold
    NSDate* newCustomDate=[self setCustomDate:@"04-16-2014"];
    int newCurrentMonth = [self getCurrentmonth: newCustomDate];
    int resultCustom=[LCDVisitService getReportingMonthForDate:newCustomDate] ;
    XCTAssertEqual(resultCustom,newCurrentMonth ,@"did not return correct month");
    
    // passing a date below the month threshhold
    NSDate* newCustomDate=[self setCustomDate:@"04-01-2014"];
    int newCurrentMonth = [self getCurrentmonth: newCustomDate];
    int resultCustom=[LCDVisitService getReportingMonthForDate:newCustomDate] ;
    XCTAssertEqual(resultCustom,newCurrentMonth ,@"did not return correct month");
    
}

-(void)testgetVisitForMonth
{
    NSLog(@"Starting getVisitForMonthTest -------------------------");
    
    // create 3 visits
    LCDVisit *visitToFindInlist=[self createVisit:1122 withMonth:6 withYear:2014 withIsVisited:1];
    LCDVisit *visitDontCare=[self createVisit:1133 withMonth:5 withYear:2014 withIsVisited:0];
    LCDVisit *visitDontCare2=[self createVisit:1144 withMonth:4 withYear:2014 withIsVisited:0];
    
    // 1. visit to be found first in the list
    NSMutableArray *visitListWithVisitFoundFirst = [[NSMutableArray alloc] init];
    [visitListCase1 addObject:visitToFindInlist];
    [visitListCase1 addObject:visitDontCare];
    [visitListCase1 addObject:visitDontCare2];
    [self validateVisitInList:visitListCase1 withVisittoFind:visitToFindInlist withExceptionMessage:@"did not return one visit for the requested month", withFindInList;true];
    
    
    // 2.visit to be found second in the list
    NSArray *[visitListFoundInTheMiddle]=@[visitDontCare, visitToFindInlist,visitDontCare2];
    [self validateVisitInList:visitListWithVisitInTheMiddle withVisittoFind:visitToFindInlist withExceptionMessage:@"did not return one visit for the requested month"];
     
  
    // 3.visit NOT to be found in the list at all
    NSMutableArray *visitListWithNoVisitFound = [[NSMutableArray alloc] init];
    [visitListCase3 addObject:visitDontCare];
    [visitListCase3 addObject:visitDontCare2];
    [self validateVisitInList:<#(NSMutableArray *)#> withVisittoFind:<#(LCDVisit *)#> withExceptionMessage:<#(NSString *)#>:visitListCase3 withVisitobject:visitToFindInlist withMessage:@"did return one visit for the requested month. expected none"];

    // 4.passing an empty list
    NSMutableArray *visitListEmpty = [[NSMutableArray alloc] init];
    [self validateVisitInList:<#(NSMutableArray *)#> withVisittoFind:<#(LCDVisit *)#> withExceptionMessage:<#(NSString *)#>:visitListCase4 withVisitobject:visitToFindInlist withMessage:@"did return something. expected nil"];
 
}

@end

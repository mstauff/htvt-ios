//
//  LCDToggleableSegmentedControl.m
//  HTVT
//
//  Created by Matt Stauffer on 4/3/14.
//  Copyright (c) 2014 LDS Community Developers. All rights reserved.
//

#import "LCDToggleableSegmentedControl.h"

@implementation LCDToggleableSegmentedControl

- (id) init {
    self = [super init];
    self.selectedSegmentIndex = UISegmentedControlNoSegment;
    return self;
    
    
}

+ (BOOL)isIOS7 {
    static BOOL isIOS7 = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSInteger deviceSystemMajorVersion = [[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] integerValue];
        if (deviceSystemMajorVersion >= 7) {
            isIOS7 = YES;
        }
        else {
            isIOS7 = NO;
        }
    });
    return isIOS7;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSInteger previousSelectedSegmentIndex = self.selectedSegmentIndex;
    [super touchesBegan:touches withEvent:event];
    if (![[self class] isIOS7]) {
        // before iOS7 the segment is selected in touchesBegan
        if (previousSelectedSegmentIndex == self.selectedSegmentIndex) {
            // if the selectedSegmentIndex before the selection process is equal to the selectedSegmentIndex
            // after the selection process the superclass won't send a UIControlEventValueChanged event.
            // So we have to do this ourselves.
            self.selectedSegmentIndex = UISegmentedControlNoSegment;            [self sendActionsForControlEvents:UIControlEventValueChanged];
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSInteger previousSelectedSegmentIndex = self.selectedSegmentIndex;
    [super touchesEnded:touches withEvent:event];
    if ([[self class] isIOS7]) {
        // on iOS7 the segment is selected in touchesEnded
        if (previousSelectedSegmentIndex == self.selectedSegmentIndex) {
            self.selectedSegmentIndex = UISegmentedControlNoSegment;       [self sendActionsForControlEvents:UIControlEventValueChanged];
        }
    }
}

@end

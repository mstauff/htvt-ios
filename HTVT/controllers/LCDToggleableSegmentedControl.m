//
//  LCDToggleableSegmentedControl.m
//  HTVT
//
//  Created by Matt Stauffer on 4/3/14.
//  Copyright (c) 2014 LDS Community Developers. All rights reserved.
//

#import "LCDToggleableSegmentedControl.h"

@implementation LCDToggleableSegmentedControl

- (void) setSelectedSegmentIndex:(NSInteger)toValue {
    if (self.selectedSegmentIndex == toValue) {
        [super setSelectedSegmentIndex:UISegmentedControlNoSegment];
    } else {
        [super setSelectedSegmentIndex:toValue];
    }}
@end

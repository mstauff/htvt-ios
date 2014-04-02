//
//  LCDAssignmentlTableViewCell.h
//  HTVT
//
//  Created by Matt Stauffer on 4/2/14.
//  Copyright (c) 2014 LDS Community Developers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCDAssignmentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *assignmentNameLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *visitRecordButtons;

@end

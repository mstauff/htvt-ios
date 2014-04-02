//
//  LCDAssignmentlTableViewCell.m
//  HTVT
//
//  Created by Matt Stauffer on 4/2/14.
//  Copyright (c) 2014 LDS Community Developers. All rights reserved.
//

#import "LCDAssignmentTableViewCell.h"

@implementation LCDAssignmentTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

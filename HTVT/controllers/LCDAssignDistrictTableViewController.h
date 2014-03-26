//
//  LCDAssignDistrictTableViewController.h
//  HTVT
//
//  Created by Matt Stauffer on 3/25/14.
//  Copyright (c) 2014 LDS Community Developers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCDDistrict.h"

@interface LCDAssignDistrictTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationBar;

@property (weak, nonatomic) LCDDistrict *district;
@end

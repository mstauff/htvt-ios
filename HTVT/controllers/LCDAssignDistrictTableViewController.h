//
//  LCDAssignDistrictTableViewController.h
//  HTVT
//
//  Created by Matt Stauffer on 3/25/14.
//  Copyright (c) 2014 LDS Community Developers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCDDistrict.h"
#import "LCDMemberService.h"
#import "LCDHtvtDataManager.h"

@interface LCDAssignDistrictTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationBar;

@property (weak, nonatomic) LCDDistrict *district;
@property (weak, nonatomic) LCDMemberService *memberService;
@property (weak, nonatomic) LCDHtvtDataManager *dataManager;
@end

//
//  LCDIndividualsTableViewController.h
//  HTVT
//
//  Created by Matt Stauffer on 3/12/14.
//  Copyright (c) 2014 LDS Community Developers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCDHtvtDataManager.h"

@interface LCDIndividualsTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, weak) NSArray *members;
@property (nonatomic, weak) LCDHtvtDataManager *dataManager;

@end

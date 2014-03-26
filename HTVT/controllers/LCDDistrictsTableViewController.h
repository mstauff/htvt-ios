//
//  LCDDistrictsTableViewController.h
//  HTVT
//
//  Created by Matt Stauffer on 3/20/14.
//  Copyright (c) 2014 LDS Community Developers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCDHtvtDataManager.h"

@interface LCDDistrictsTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) NSArray *members;
@property (nonatomic, weak) NSArray *districts;
@property (nonatomic, weak) LCDHtvtDataManager *dataManager;

@end

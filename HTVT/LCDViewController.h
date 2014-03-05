//
//  CDHTViewController.h
//  HTVT
//
//  Created by Matt Stauffer on 2/25/14.
//  Copyright (c) 2014 Matt Stauffer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCDConfig.h"

@interface LCDViewController : UIViewController <NSURLConnectionDelegate>

@property (strong, nonatomic) LCDConfig *config;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

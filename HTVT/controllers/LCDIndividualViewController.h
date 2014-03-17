//
//  LCDIndividualViewController.h
//  HTVT
//
//  Created by Matt Stauffer on 3/17/14.
//  Copyright (c) 2014 LDS Community Developers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCDMember.h"
#import "LCDFamily.h"
     
@interface LCDIndividualViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) LCDMember *member;
@property (weak, nonatomic) LCDFamily *family;


@end

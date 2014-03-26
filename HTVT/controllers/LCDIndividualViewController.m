//
//  LCDIndividualViewController.m
//  HTVT
//
//  Created by Matt Stauffer on 3/17/14.
//  Copyright (c) 2014 LDS Community Developers. All rights reserved.
//

#import "LCDIndividualViewController.h"

@interface LCDIndividualViewController ()
@end

@implementation LCDIndividualViewController

- (void)setFamily:(LCDFamily *)family {
    _family = family;
    if( self.view.window ) {
        [self updateUI];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)updateUI {
    self.member = self.family.headOfHouse;
    self.nameLabel.text = self.member.formattedName;
    self.phoneLabel.text = self.member.phone;
    self.emailLabel.text = self.member.email;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

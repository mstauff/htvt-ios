//
//  LCDIndividualsTableViewController.m
//  HTVT
//
//  Created by Matt Stauffer on 3/12/14.
//  Copyright (c) 2014 LDS Community Developers. All rights reserved.
//

#import "LCDIndividualsTableViewController.h"
#import "LCDIndividualViewController.h"
#import "LCDFamily.h"

@interface LCDIndividualsTableViewController ()

@end

@implementation LCDIndividualsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadConfig];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void (^)(void))networkError: (NSError*) error {
    return ^ {
        //run the UI update on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
//            self.label.text = @"Error Loading Config";
            NSLog( @"Error loading config: %@", error.description );
        });
    };
}

- (void)loadConfig
{
    [self.dataManager fetchConfig:^(LCDConfig* config, NSError* error) {
        if( error ) {
            [self fetchingConfigFailedWithError:error];
        } else {
            [self didReceiveConfig:config];
        }
    } ];
}

- (void)didReceiveConfig:(LCDConfig *)config {
        [self loadMemberList];
    NSLog( @"Exiting didReceiveConfig" );
}

- (void)didReceiveMemberList:(NSArray* )memberList {
    //run the UI update on the main thread
    dispatch_async(dispatch_get_main_queue(), ^{
//        self.label.text = [ NSString stringWithFormat:@"Loaded %lu Members", (unsigned long)memberList.count];
//        NSLog( @"Assigned label: %@", self.label.text );
        self.members = memberList;
        [self.tableView reloadData];
        
    });
    NSLog( @"Exiting didReceiveConfig" );
}

- (void)fetchingConfigFailedWithError:(NSError *)error {
    NSLog(@"Error %@; %@", error, [error localizedDescription]);
    [self networkError:error];
}

- (void)loadMemberList
{
    [self.dataManager fetchMemberList:111 withCompletionHandler:^(NSArray* memberList, NSError* error) {
        if( error ) {
            [self networkError:error];
        } else {
            [self didReceiveMemberList:memberList];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.members.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"IndividualTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if( !cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [(LCDFamily*)[self.members objectAtIndex:indexPath.row] formattedCoupleName];
    
    return cell;
}
//
//- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"Tapped %@", [(LCDFamily*)[self.members objectAtIndex:indexPath.row] formattedCoupleName] );
//    
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if( [[segue identifier] isEqualToString:@"ShowIndividualDetails"]) {
        LCDIndividualViewController *individualViewController = [segue destinationViewController];
        NSIndexPath *selectedMemberIndexPath = [self.tableView indexPathForSelectedRow];
        
        long row = [selectedMemberIndexPath row];
        
        individualViewController.family = self.members[row];
        
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end

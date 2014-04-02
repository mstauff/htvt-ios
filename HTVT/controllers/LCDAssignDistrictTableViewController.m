//
//  LCDAssignDistrictTableViewController.m
//  HTVT
//
//  Created by Matt Stauffer on 3/25/14.
//  Copyright (c) 2014 LDS Community Developers. All rights reserved.
//

#import "LCDAssignDistrictTableViewController.h"
#import "LCDCompanionship.h"
#import "LCDCompanionshipMember.h"
#import "LCDTeacher.h"
#import "LCDAssignment.h"
#import "LCDVisitService.h"
#import "LCDAssignmentTableViewCell.h"

@interface LCDAssignDistrictTableViewController ()

@property (nonatomic) int reportingMonth;

@end

@implementation LCDAssignDistrictTableViewController

NSString *const NO_NAME_PLACEHOLDER = @"---";
int const VISITED_YES_INDEX = 0;
int const VISITED_NO_INDEX = 1;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationBar.title = self.district.name;
    self.reportingMonth = [LCDVisitService getCurrentReportingMonth];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.district.companionships.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    LCDCompanionship *companionship = self.district.companionships[section];
    
    // we want at least one row, if there are no actual assignments
    return companionship.assignments.count > 0 ? companionship.assignments.count : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"AssignTableViewCell";
    LCDAssignmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if( !cell ) {
        cell = [[LCDAssignmentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    LCDCompanionship *comp = self.district.companionships[indexPath.section];
    if( comp.assignments.count > 0 ) {
        LCDAssignment *assignment = comp.assignments[indexPath.row];
        LCDMember *member = assignment.member;
        cell.assignmentNameLabel.text = member.formattedName;
        NSNumber *visited = [assignment getVisitedForMonth: self.reportingMonth];
        [cell.visitRecordButtons setHidden:NO];
        if( visited == nil ) {
            cell.visitRecordButtons.selectedSegmentIndex = UISegmentedControlNoSegment;
        } else {
            cell.visitRecordButtons.selectedSegmentIndex = visited.intValue > 0 ? VISITED_YES_INDEX : VISITED_NO_INDEX;
        }
    } else {
        cell.assignmentNameLabel.text = NO_NAME_PLACEHOLDER;
        [cell.visitRecordButtons setHidden:YES];
    }
    
    return cell;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *teacherDelimiter = @" / ";
    LCDCompanionship *comp = self.district.companionships[section];
    NSMutableString *teacherNames = [[NSMutableString alloc] init];
    if( comp.teachers.count ) {
        for( LCDTeacher *teacher in comp.teachers ) {
            [teacherNames appendFormat:@"%@%@", teacher.member.formattedName, teacherDelimiter];
        }
        [teacherNames deleteCharactersInRange:NSMakeRange(teacherNames.length - teacherDelimiter.length, teacherDelimiter.length)];
    } else {
        [teacherNames appendString:NO_NAME_PLACEHOLDER];
    }
    return teacherNames;
}

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

//
//  EHSettingsViewController.m
//  BounceScrollView
//
//  Created by Hani Ibrahim on 12/7/13.
//  Copyright (c) 2013 Hani Ibrahim. All rights reserved.
//

#import "EHSettingsViewController.h"
#import "EHViewController.h"

@interface EHSettingsViewController ()
@property (nonatomic, strong) IBOutlet UISwitch *limitSwitch;
@property (nonatomic, strong) IBOutlet UISwitch *ratioSwitch;

@property (nonatomic, strong) IBOutlet UISegmentedControl *limitSegmentedControl;
@property (nonatomic, strong) IBOutlet UISegmentedControl *ratioSegmentedControl;

@property (nonatomic) BOOL isHorizontal;
@end

@implementation EHSettingsViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"showScrollView"]) {
		EHViewController *viewController = segue.destinationViewController;
		viewController.isHorizontal = self.isHorizontal;
		if (self.limitSwitch.on) {
			viewController.limitDistance = [[[self.limitSegmentedControl titleForSegmentAtIndex:self.limitSegmentedControl.selectedSegmentIndex] stringByReplacingOccurrencesOfString:@"pt" withString:@""] floatValue];
		}
		if (self.ratioSwitch.on) {
			viewController.resistanceRatio = [[self.ratioSegmentedControl titleForSegmentAtIndex:self.ratioSegmentedControl.selectedSegmentIndex] floatValue];
		}
	}
}


#pragma mark - View Actions

- (IBAction)limitSwitchValueChanged:(UISwitch *)sender
{
	self.limitSegmentedControl.enabled = sender.on;
}

- (IBAction)ratioSwitchValueChanged:(UISwitch *)sender
{
	self.ratioSegmentedControl.enabled = sender.on;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	if (indexPath.section == 0) {
		UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
		selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
		
		UITableViewCell *otherCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:!indexPath.row inSection:0]];
		otherCell.accessoryType = UITableViewCellAccessoryNone;
		
		self.isHorizontal = indexPath.row;
	}
}

@end

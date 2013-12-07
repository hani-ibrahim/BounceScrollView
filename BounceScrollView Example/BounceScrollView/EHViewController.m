//
//  EHViewController.m
//  BounceScrollView
//
//  Created by Hani Ibrahim on 12/7/13.
//  Copyright (c) 2013 Hani Ibrahim. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "EHViewController.h"
#import "EHBounceScrollView.h"

@interface EHViewController ()
@property (nonatomic, strong) IBOutlet EHBounceScrollView *scrollView;
@end

@implementation EHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	// Setup Scroll View
	if (self.isHorizontal) {
		for (int i=0; i<5; i++) {
			UILabel *labelA = [self getLabelWithText:[NSString stringWithFormat:@"A - %d",i+1] atOrigin:CGPointMake(i*200, 0)];
			UILabel *labelB = [self getLabelWithText:[NSString stringWithFormat:@"B - %d",i+1] atOrigin:CGPointMake(i*200, ceilf((self.scrollView.frame.size.height-100)/2.0))];
			UILabel *labelC = [self getLabelWithText:[NSString stringWithFormat:@"C - %d",i+1] atOrigin:CGPointMake(i*200, self.scrollView.frame.size.height-50)];
			
			[self.scrollView addSubview:labelA];
			[self.scrollView addSubview:labelB];
			[self.scrollView addSubview:labelC];
		}
		self.scrollView.contentSize = CGSizeMake(200*4+100, self.scrollView.frame.size.height);
	} else {
		for (int i=0; i<10; i++) {
			UILabel *labelA = [self getLabelWithText:[NSString stringWithFormat:@"A - %d",i+1] atOrigin:CGPointMake(0, i*100)];
			UILabel *labelB = [self getLabelWithText:[NSString stringWithFormat:@"B - %d",i+1] atOrigin:CGPointMake(self.scrollView.frame.size.width-100, i*100)];
			
			[self.scrollView addSubview:labelA];
			[self.scrollView addSubview:labelB];
		}
		self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, 100*9+50);
	}
	
	if (self.limitDistance != 0) {
		self.scrollView.freeDirectionX = NO;
		self.scrollView.freeDirectionY = NO;
		self.scrollView.limitDistanceX = self.limitDistance;
		self.scrollView.limitDistanceY = self.limitDistance;
	}
	
	if (self.resistanceRatio != 0) {
		self.scrollView.resistanceRatioX = self.resistanceRatio;
		self.scrollView.resistanceRatioY = self.resistanceRatio;
	}
}

- (UILabel *)getLabelWithText:(NSString *)text atOrigin:(CGPoint)origin
{
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(origin.x, origin.y, 100, 50)];
	label.text = text;
	label.textAlignment = NSTextAlignmentCenter;
	label.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
	label.layer.borderColor = [UIColor blackColor].CGColor;
	label.layer.borderWidth = 1;
	return label;
}

@end

//
//  EHBounceScrollView.m
//  BounceScrollView
//
//  Created by Hani Ibrahim on 12/7/13.
//  Copyright (c) 2013 Hani Ibrahim. All rights reserved.
//

#import "EHBounceScrollView.h"

@interface EHBounceScrollView () <UIScrollViewDelegate>
@property (nonatomic) CGPoint beginOffset;
@property (nonatomic) CGPoint movedTouch;

// We use this method to prevent the resistance to apply for the first time only ... to avoid flicker
@property (nonatomic) BOOL neglectResistancePositiveX;
@property (nonatomic) BOOL neglectResistanceNegativeX;
@property (nonatomic) BOOL neglectResistancePositiveY;
@property (nonatomic) BOOL neglectResistanceNegativeY;
@property (nonatomic, assign) BOOL isInActiveGesture;
@end

@implementation EHBounceScrollView

#pragma mark - Initialization

- (instancetype)init
{
	self = [super init];
	if (self) {
		[self initialize];
	}
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self initialize];
	}
	return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self initialize];
	}
	return self;
}

- (void)initialize
{
	// We need to capture the delegate
	self.delegate = self;
	
	// Setting the default values
	self.freeDirectionX = YES;
	self.freeDirectionY = YES;
	self.resistanceRatioX = 1.0;
	self.resistanceRatioY = 1.0;
	
	// Add ourself tp the panGestureRecognizer
	[self.panGestureRecognizer addTarget:self action:@selector(panGestureRecognizerDetected:)];
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	// Scroll Limit X Direction
	BOOL reachedMaxX = NO;
	if (!self.freeDirectionX) {
		if (scrollView.contentOffset.x <= -self.limitDistanceX) {
			CGPoint offset = scrollView.contentOffset;
			offset.x = -self.limitDistanceX;
			scrollView.contentOffset = offset;
			reachedMaxX = YES;
		} else if (scrollView.contentOffset.x >= (scrollView.contentSize.width-scrollView.frame.size.width) + self.limitDistanceX) {
			CGPoint offset = scrollView.contentOffset;
			offset.x = (scrollView.contentSize.width-scrollView.frame.size.width) + self.limitDistanceX;
			scrollView.contentOffset = offset;
			reachedMaxX = YES;
		}
	}
	
	// Scroll Limit Y Direction
	BOOL reachedMaxY = NO;
	if (!self.freeDirectionY) {
		if (scrollView.contentOffset.y <= -self.limitDistanceY) {
			CGPoint offset = scrollView.contentOffset;
			offset.y = -self.limitDistanceY;
			scrollView.contentOffset = offset;
			reachedMaxY = YES;
		} else if (scrollView.contentOffset.y >= (scrollView.contentSize.height-scrollView.frame.size.height) + self.limitDistanceY) {
			CGPoint offset = scrollView.contentOffset;
			offset.y = (scrollView.contentSize.height-scrollView.frame.size.height) + self.limitDistanceY;
			scrollView.contentOffset = offset;
			reachedMaxY = YES;
		}
	}
	
	// Scroll Resistance X Direction
    if (self.resistanceRatioX != 1 && self.tracking && !reachedMaxX) {
		if (scrollView.contentOffset.x <= 0 && !self.neglectResistancePositiveX) {
			CGFloat distanceMoved = self.movedTouch.x - self.beginOffset.x;
			CGPoint offset = scrollView.contentOffset;
			offset.x =  -distanceMoved / self.resistanceRatioX;
			scrollView.contentOffset = offset;
		} else if (scrollView.contentOffset.x >= scrollView.contentSize.width-scrollView.frame.size.width && !self.neglectResistanceNegativeX) {
			CGFloat distanceMoved = self.movedTouch.x - (self.beginOffset.x-(scrollView.contentSize.width-scrollView.frame.size.width));
			CGPoint offset = scrollView.contentOffset;
			offset.x = scrollView.contentSize.width-scrollView.frame.size.width - distanceMoved / self.resistanceRatioX;
			scrollView.contentOffset = offset;
		}
	}
	
	// Scroll Resistance Y Direction
    if (self.resistanceRatioY != 1 && self.tracking && !reachedMaxY) {
		if (scrollView.contentOffset.y <= 0 && !self.neglectResistancePositiveY) {
			CGFloat distanceMoved = self.movedTouch.y - self.beginOffset.y;
			CGPoint offset = scrollView.contentOffset;
			offset.y =  -distanceMoved / self.resistanceRatioY;
			scrollView.contentOffset = offset;
		} else if (scrollView.contentOffset.y >= scrollView.contentSize.height-scrollView.frame.size.height && !self.neglectResistanceNegativeY) {
			CGFloat distanceMoved = self.movedTouch.y - (self.beginOffset.y-(scrollView.contentSize.height-scrollView.frame.size.height));
			CGPoint offset = scrollView.contentOffset;
			offset.y = scrollView.contentSize.height-scrollView.frame.size.height - distanceMoved / self.resistanceRatioY;
			scrollView.contentOffset = offset;
		}
	}
	
	// Reset neglect resistances
	self.neglectResistancePositiveX = NO;
	self.neglectResistancePositiveY = NO;
	self.neglectResistanceNegativeX = NO;
	self.neglectResistanceNegativeY = NO;
}

#pragma mark - Gesture Recognizer

- (void)panGestureRecognizerDetected:(UIPanGestureRecognizer *)recognizer
{
	self.movedTouch = [recognizer translationInView:self];
  self.beginOffset = self.contentOffset;
  
  switch (recognizer.state) {
    case UIGestureRecognizerStateBegan:
      self.isInActiveGesture = YES;
      break;
      
    case UIGestureRecognizerStateCancelled:
    case UIGestureRecognizerStateEnded:
    case UIGestureRecognizerStateFailed:
      self.isInActiveGesture = NO;
      break;
      
    default:
      break;
  }
}

@end

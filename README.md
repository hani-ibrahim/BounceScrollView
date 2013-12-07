Bounce Scroll View
================

Bounce Scroll View can be used to Customize the appearance of the UIScrollView when it the user tries to scroll it beyond the scroll view content

**There are two options**

1. **Scroll Limit**

  In which the scroll view will stop at the desired offset outside the content size
2. **Resistance Ratio** 

  In which the scroll view will prevent the user from dragging the scroll view outside the content size with this ration of resistance



# How To Use

Installation is vey simple you have only one class "EHBounceScrollView" which is a subclass of "UIScrollView" so You can use it instead of UIScrollView

**You have these properties**

1. **limitDistanceX & limitDistanceY:** The distance limited in the X or Y Direction, the user will not be able to scroll the view beyond it
2. **freeDirectionX & freeDirectionY:** When set to yes the value in 'limitDistanceX' or 'limitDistanceY' will be neglected and the normal behaviour will be applied `Default is YES`
3. **resistanceRatioX & resistanceRatioY:** The resistance ratio that the user will encounter when scrolling beyond the scroll content limit in the X or Y direction `Default is 1 which is normal behavior`


# Source Code

**EHBounceScrollView.h**

```Objective-C
//
//  EHBounceScrollView.h
//  BounceScrollView
//
//  Created by Hani Ibrahim on 12/7/13.
//  Copyright (c) 2013 Hani Ibrahim. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *	@class EHBounceScrollView
 *	@brief Control the behavior when the user scroll beyonds the limit of the scroll view content
 *	@copyright Eng Hani Ibrahim
 */

@interface EHBounceScrollView : UIScrollView

/**
 *	@property Free Direction X
 *	@brief When set to yes the value in 'limitDistanceX' will be neglected and the normal behaviour will be applied
 *	@note Default is YES
 */
@property (nonatomic) BOOL freeDirectionX;

/**
 *	@property Free Direction Y
 *	@brief When set to yes the value in 'limitDistanceY' will be neglected and the normal behaviour will be applied
 *	@note Default is YES
 */
@property (nonatomic) BOOL freeDirectionY;

/**
 *	@property Limit Distance X
 *	@brief The distance limited in the X Direction, the user will not be able to scroll the view beyond it
 */
@property (nonatomic) CGFloat limitDistanceX;

/**
 *	@property Limit Distance Y
 *	@brief The distance limited in the Y Direction, the user will not be able to scroll the view beyond it
 */
@property (nonatomic) CGFloat limitDistanceY;



/**
 *	@property Resistance Ratio X
 *	@brief The resistance ratio that the user will encounter when scrolling beyond the scroll content limit in the X direction
 *	@note Default is 1 which is normal behavior
 */
@property (nonatomic) CGFloat resistanceRatioX;

/**
 *	@property Resistance Ratio Y
 *	@brief The resistance ratio that the user will encounter when scrolling beyond the scroll content limit in the Y direction
 *	@note Default is 1 which is normal behavior
 */
@property (nonatomic) CGFloat resistanceRatioY;


@end
```

**EHBounceScrollView.m**

```Objective-C
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
}


#pragma mark - Touch Events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	self.beginOffset = self.contentOffset;
	self.neglectResistancePositiveX = self.contentOffset.x == 0;
	self.neglectResistancePositiveY = self.contentOffset.y == 0;
	self.neglectResistanceNegativeX = self.contentOffset.x == self.contentSize.width-self.frame.size.width;
	self.neglectResistanceNegativeY = self.contentOffset.y == self.contentSize.height-self.frame.size.height;
}

@end
```
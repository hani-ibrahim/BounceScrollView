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

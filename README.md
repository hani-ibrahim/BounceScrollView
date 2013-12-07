Bounce Scroll View
================

Bounce Scroll View can be used to Customize the appearance of the UIScrollView when it the user tries to scroll it beyond the scroll view content

**There are two options**

1. **Scroll Limit**

  In which the scroll view will stop at the desired offset outside the content size
2. **Resistance Ratio** 

  In which the scroll view will prevent the user from dragging the scroll view outside the content size with this ration of resistance



# Installation

Installation is vey simple you have only one class "EHBounceScrollView" which is a subclass of "UIScrollView" so You can use it instead of UIScrollView

**You have these properties**

1. **limitDistanceX & limitDistanceY:** The distance limited in the X or Y Direction, the user will not be able to scroll the view beyond it
2. **freeDirectionX & freeDirectionY:** When set to yes the value in 'limitDistanceX' or 'limitDistanceY' will be neglected and the normal behaviour will be applied `Default is YES`
3. **resistanceRatioX & resistanceRatioY:** The resistance ratio that the user will encounter when scrolling beyond the scroll content limit in the X or Y direction `Default is 1 which is normal behavior`

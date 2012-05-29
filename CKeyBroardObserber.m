//
//  CKeyBroardObserber.m
//  GuideAssist
//
//  Created by 朱 起伟 on 12-5-15.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CKeyBroardObserber.h"
#import <QuartzCore/QuartzCore.h>


@implementation CKeyBroardObserber

@synthesize rootView = rootView_;
@synthesize keyboardBound = keyboardBound_;
@synthesize autoAdjustRootView = bAutoAdjustRootView_;

- (id)init
{
    self = [ super init ];
    if ( self )
    {
        bAutoAdjustRootView_ = NO;
        nMovedHeight_ = 0;
        
        [ self getOSVersion ];
        
        if ( fOSVersion_ < 5.0 )
        {
            [[ NSNotificationCenter defaultCenter ] addObserver:self
                                                       selector:@selector(keyboardWillChangeFrame:) 
                                                           name:UIKeyboardWillShowNotification 
                                                         object:nil ];        
            
            [[ NSNotificationCenter defaultCenter ] addObserver:self
                                                       selector:@selector(keyboardWillChangeFrame:) 
                                                           name:UIKeyboardWillHideNotification 
                                                         object:nil ];
            
        }
        else
        {
//#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED  
//            [[ NSNotificationCenter defaultCenter ] addObserver:self
//                                                       selector:@selector(keyboardWillChangeFrame:) 
//                                                           name:UIKeyboardWillChangeFrameNotification
//                                                         object:nil ];
 
        }
        
        arrInputViews_ = [[ NSMutableArray alloc ] init ];
    }
    
    return self;
}

- (void)dealloc
{
    [[ NSNotificationCenter defaultCenter ] removeObserver:self
                                                      name:UIKeyboardWillShowNotification
                                                    object:nil ];
    [[ NSNotificationCenter defaultCenter ] removeObserver:self
                                                      name:UIKeyboardWillHideNotification
                                                    object:nil ];
    [ arrInputViews_ removeAllObjects ];
    [ arrInputViews_ release ];
    self.rootView = nil;
    [ super dealloc ];
}

- (void)hideKeyboard
{
    for ( UIView *view in arrInputViews_ )
    {
        [ view resignFirstResponder ];
    }
}

- (UIView *)getFirsrResponder:(UIViewController *)ctrller
{
    return nil;
}

- (float)getOSVersion
{
    if ( fOSVersion_ < 0.1 )
    {
        fOSVersion_ = [[[ UIDevice currentDevice ] systemVersion ] floatValue ];  
    }
    return fOSVersion_;
}

- (void)setKeyboardWillShowDidMethod:(id)delegate forSelector:(SEL)selector
{
    delegateWillShow_ = delegate;
    selectorWillShow_ = selector;    
}

- (void)setKeyboardWillHideDidMethod:(id)delegate forSelector:(SEL)selector
{
    deletateWillHide_ = delegate;
    selectorWillHide_ = selector;
}

- (void)addViewOfNeedKeyboard:(UIView *)view
{
    if ( [ view isKindOfClass:[ UIView class ]] )
    {
        [ arrInputViews_ addObject:view ];
    }
}

- (void)deleteViewOfNeedKeyboard:(UIView *)view
{
    [ arrInputViews_ removeObject:view ];
}

- (void)clearAllView
{
    [ arrInputViews_ removeAllObjects ];
}

- (UIView *)getFirsrResponderView
{
    for ( UIView *view in arrInputViews_ )
    {
        if ( [ view isFirstResponder ] )
        {
            return view;
        }
    }
    
    return nil;
}

- (void)autoScrollRootView
{
    if ( bAutoAdjustRootView_ )
    {
        firstResponderView_ = [ self getFirsrResponderView ];
        if ( nil != firstResponderView_ )
        {
            CGRect frameScreen = [[ UIScreen mainScreen ] bounds ];
            CGRect frameView = [ firstResponderView_ convertRect:firstResponderView_.bounds 
                                                          toView:nil ];
            if ( ( frameView.origin.y + frameView.size.height ) > ( frameScreen.size.height -keyboardBound_.size.height ) )
            {
                nMovedHeight_ = frameView.origin.y - frameScreen.size.height 
                + keyboardBound_.size.height + frameView.size.height;
                [ UIView animateWithDuration:0.3 
                                  animations:^
                 {
                     CGRect frameSrc = rootView_.frame;
                     frameSrc.origin.y -= nMovedHeight_;
                     rootView_.frame = frameSrc;
                     
                     // [ UIView setAnimationDuration:kAnimationDuration ];
                     [ UIView setAnimationCurve:UIViewAnimationCurveEaseInOut ];
                     [ UIView setAnimationTransition:UIViewAnimationTransitionNone 
                                             forView:rootView_ cache:NO ];  
                 } ];
            }
//            else
//            {
//                nMovedHeight_ = 0;
//            }
        }
    }

}

- (void)keyboardWillChangeFrame:(NSNotification *)notifacation
{
    if ( fOSVersion_ < 5.0 )
    {
        if ( [[ notifacation name ] isEqualToString: UIKeyboardWillShowNotification ] ) 
        {
            NSValue *value = [[ notifacation  userInfo ] objectForKey: UIKeyboardFrameEndUserInfoKey ];
            [ value getValue:&keyboardBound_ ];
            //        NSLog( @"keyboard width:%.2f, height:%.2f", keyboardBound_.size.width, keyboardBound_.size.height );
            
            if ( delegateWillShow_ && selectorWillShow_ )
            {
                if ( [ delegateWillShow_ respondsToSelector:selectorWillShow_ ] )
                {
                    [ delegateWillShow_ performSelector:selectorWillShow_ ];
                }
            }
       //     [ self autoScrollRootView ];
            
        }
        else if ( [[ notifacation name ] isEqualToString: UIKeyboardWillHideNotification ] )
        {
            if ( deletateWillHide_ && selectorWillHide_ )
            {
                if ( [ deletateWillHide_ respondsToSelector:selectorWillHide_ ] )
                {
                    [ deletateWillHide_ performSelector:selectorWillHide_ ];
                }
                 
            }
            if ( bAutoAdjustRootView_ && nMovedHeight_ )
            {
                [ UIView animateWithDuration:0.3
                                  animations:^
                 {
                     CGRect frameSrc = rootView_.frame;
                     frameSrc.origin.y += nMovedHeight_;
                     rootView_.frame = frameSrc;
                     
                     // [ UIView setAnimationDuration:kAnimationDuration ];
                     [ UIView setAnimationCurve:UIViewAnimationCurveEaseInOut ];
                     [ UIView setAnimationTransition:UIViewAnimationTransitionNone 
                                             forView:rootView_ cache:NO ];  
                     nMovedHeight_ = 0;
                 } ];
            }
        }
    }
}

@end

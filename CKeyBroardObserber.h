//
//  CKeyBroardObserber.h
//  GuideAssist
//
//  Created by 朱 起伟 on 12-5-15.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CKeyBroardObserber : NSObject 
{
    CGRect keyboardBound_;
    float fOSVersion_;
    id    delegateWillShow_;
    id    deletateWillHide_;
    SEL   selectorWillShow_;
    SEL   selectorWillHide_; 
    UIView *rootView_;
    UIView *firstResponderView_;
    NSMutableArray *arrInputViews_;
    BOOL bAutoAdjustRootView_;
    int nMovedHeight_;
}

@property ( nonatomic, readonly ) CGRect keyboardBound;
@property ( nonatomic, retain ) UIView *rootView;
@property ( nonatomic, assign ) BOOL autoAdjustRootView;

- (float)getOSVersion;

- (void)keyboardWillChangeFrame:(NSNotification*)notifacation;

- (void)setKeyboardWillShowDidMethod:(id)delegate forSelector:(SEL)selector;
- (void)setKeyboardWillHideDidMethod:(id)delegate forSelector:(SEL)selector;

- (void)addViewOfNeedKeyboard:(UIView*)view;
- (void)deleteViewOfNeedKeyboard:(UIView*)view;
- (void)clearAllView;
- (void)hideKeyboard;
- (void)autoScrollRootView;

- (UIView*)getFirsrResponderView;


@end

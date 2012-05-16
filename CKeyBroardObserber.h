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
    id    threadDelegate_;
    SEL   selector_;
    
}

@property ( nonatomic, readonly ) CGRect keyboardBound;

- (void)getOSVersion;

- (void)keyboardWillChangeFrame:(NSNotification*)notifacation;

- (void)setKeyboardWillShowDidMethod:(id)delegate forSelector:(SEL)selector;

- (UIView*)getFirsrResponder:(UIViewController*)ctrller;


@end

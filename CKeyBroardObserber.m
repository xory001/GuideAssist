//
//  CKeyBroardObserber.m
//  GuideAssist
//
//  Created by 朱 起伟 on 12-5-15.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CKeyBroardObserber.h"


@implementation CKeyBroardObserber

@synthesize keyboardBound = keyboardBound_;

- (id)init
{
    self = [ super init ];
    if ( self )
    {
        [ self getOSVersion ];
        
        if ( fOSVersion_ < 5.0 )
        {
            [[ NSNotificationCenter defaultCenter ] addObserver:self
                                                       selector:@selector(keyboardWillChangeFrame:) 
                                                           name:UIKeyboardWillShowNotification 
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
    }
    
    return self;
}

- (void)dealloc
{
    [[ NSNotificationCenter defaultCenter ] removeObserver:self
                                                      name:UIKeyboardWillShowNotification
                                                    object:nil ];
    [ super dealloc ];
}

- (void)getOSVersion
{
    fOSVersion_ = [[[ UIDevice currentDevice ] systemVersion ] floatValue ];
}

- (void)keyboardWillChangeFrame:(NSNotification *)notifacation
{
    if ( fOSVersion_ < 5.0 )
    {
        NSValue *value = [[ notifacation  userInfo ] objectForKey: UIKeyboardFrameEndUserInfoKey ];
        [ value getValue:&keyboardBound_ ];
        NSLog( @"keyboard width:%.2f, height:%.2f", keyboardBound_.size.width, keyboardBound_.size.height );
    }
}

@end

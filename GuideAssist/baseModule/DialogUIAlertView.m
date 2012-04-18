//
//  DialogUIAlertView.m
//  WindowTemplateTest
//
//  Created by Titaro on 11-9-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "DialogUIAlertView.h" 

@implementation DialogUIAlertView 

- (id)initWithTitle:(NSString*)title message:(NSString*)message cancelButtonTitle:(NSString*)cancelButtonTitle
{
    alv = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil, nil];
    isWaiting4Tap = YES;
    return self;
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... 
{ 
    alv = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles,nil]; 
    
    isWaiting4Tap = YES; 
    return self; 
} 

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex 
{ 
    alertViewRetValue = buttonIndex; 
    isWaiting4Tap = NO; 
} 

- (int)showDialog 
{ 
    isWaiting4Tap = YES; 
    [alv show]; 
    while (isWaiting4Tap) { 
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
    }
    return alertViewRetValue; 
} 

- (void)showDialogWithTime:(NSTimeInterval) dbTime 
{ 
    isWaiting4Tap = YES; 
    [alv show]; 
    CFTimeInterval endTime = CFAbsoluteTimeGetCurrent() + (CFTimeInterval)dbTime;
    while (CFAbsoluteTimeGetCurrent() < endTime) 
    { 
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
    }
    [alv dismissWithClickedButtonIndex:0 animated:YES];
} 

- (NSInteger)addButtonWithTitle:(NSString*)title
{
    return [alv addButtonWithTitle:title];
}

- (void)dealloc 
{ 
    [super dealloc]; 
    [alv release]; 
} 
@end


NSInteger msgBox(NSString* title, NSString* message, NSString* cancelButtonTitle, ...)
{
    DialogUIAlertView* dlgView = nil;
    dlgView = [[DialogUIAlertView alloc] initWithTitle:title message:message cancelButtonTitle:cancelButtonTitle];  
    va_list argList;
    va_start(argList, cancelButtonTitle);
    NSString* strArgButton = nil;
    while ((strArgButton = va_arg(argList, NSString*)))
    {
        [dlgView addButtonWithTitle:strArgButton];
    }
    va_end(argList);
    NSInteger iRet = [dlgView showDialog];
    [dlgView release];
    return iRet;
}

void msgBoxWithTime(NSTimeInterval dbTime, NSString* title, NSString* message, NSString* cancelButtonTitle, ...)
{
    DialogUIAlertView* dlgView = nil;
    dlgView = [[DialogUIAlertView alloc] initWithTitle:title message:message cancelButtonTitle:cancelButtonTitle];  
    va_list argList;
    va_start(argList, cancelButtonTitle);
    NSString* strArgButton = nil;
    while ((strArgButton = va_arg(argList, NSString*)))
    {
        [dlgView addButtonWithTitle:strArgButton];
    }
    va_end(argList);
    [dlgView showDialogWithTime:dbTime];
    [dlgView release];
}

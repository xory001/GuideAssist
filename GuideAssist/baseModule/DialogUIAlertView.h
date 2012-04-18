//
//  DialogUIAlertView.h
//  WindowTemplateTest
//
//  Created by Titaro on 11-9-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DialogUIAlertView : NSObject { 
    BOOL isWaiting4Tap; 
    UIAlertView * alv; 
    int alertViewRetValue; 
    
} 

- (id)initWithTitle:(NSString*)title message:(NSString*)message cancelButtonTitle:(NSString*)cancelButtonTitle;
- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;
- (int)showDialog;
- (void)showDialogWithTime:(NSTimeInterval) dbTime;
- (NSInteger)addButtonWithTitle:(NSString*)title;
@end

//弹出式警告框函数
//参数：
//   NSString* title 标题栏。
//   NSString* message 要显示的消息。
//   NSString* cancelButtonTitle cancel按钮的标题，不允许传nil。
//   ... 其他需要加入的按钮，NSString*类型。中间用“,”分隔，最后一个参数必须为nil，如果只传入一个nil，则只有一个cancel按钮。
//返回值：NSInteger，表示被用户按下的按钮序号。
//备注：
//   此函数为阻塞调用，即在函数执行完毕之前不会执行下一条语句。但由于在函数内部调用了RunLoop，在函数调用之前发送给RunLoop的消息将在窗口显示的时候被处理。可以善加利用这一条。
//   调用举例
//   msgBox(@"警告", @"错误信息", @"否", @"是", nil);
FOUNDATION_EXTERN NSInteger msgBox(NSString* title, NSString* message, NSString* cancelButtonTitle, ...);
FOUNDATION_EXTERN void msgBoxWithTime(NSTimeInterval dbTime, NSString* title, NSString* message, NSString* cancelButtonTitle, ...);

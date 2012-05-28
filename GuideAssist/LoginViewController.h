//
//  LoginViewController.h
//  GuideAssist
//
//  Created by 朱 起伟 on 11-8-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKeyBroardObserber.h"


@interface LoginViewController : UIViewController < UITextFieldDelegate >
{
  UITextField *loginName_;
  UITextField *loginPassword_;
  UISegmentedControl *loginType_;
  

    CKeyBroardObserber *keyboardObserver_;
    
  //  UILabel *pLableTest_;
    

 
}


@property (nonatomic,retain) IBOutlet UISegmentedControl *loginType;
@property (nonatomic,retain ) IBOutlet UITextField *loginName;
@property ( nonatomic,retain ) IBOutlet UITextField *loginPassword;
//@property( nonatomic, retain ) IBOutlet UILabel *lableTest;

- (IBAction)LoginButtonPressed:(id)sender;
- (IBAction)quitBtnPressed:(id)sender;
- (IBAction)textFeildDone:(id)sender forEvent:(UIEvent *)event;


- (void)keyboardWliiShow; //when keyboard will show,call this method

@end

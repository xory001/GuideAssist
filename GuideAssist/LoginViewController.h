//
//  LoginViewController.h
//  GuideAssist
//
//  Created by 朱 起伟 on 11-8-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoginViewController : UIViewController {
  UITextField *loginName_;
  UITextField *loginPassword_;
  UISegmentedControl *loginType_;
  
  NSOperationQueue *opetationQueue_;
  NSInvocationOperation *invoctionOperation_;
  
  NSString *strWebServiceURL_; //end not has "/"
  BOOL bQuitThread_;
    

 
}
//, getter = loiginName,setter = setLoginName:
//@property (nonatomic, retain) IBOutlet UITextField *textName_;
@property (nonatomic,retain,getter = loginType,setter = setLoginType:) IBOutlet UISegmentedControl *loginType_;

@property (nonatomic,retain,getter = loiginName,setter = setLoginName:) IBOutlet UITextField *loginName_;

@property (nonatomic,retain,getter = loginPassword, setter = setLoginPassword:) IBOutlet UITextField *loginPassword_;

- (IBAction)LoginButtonPressed:(id)sender;

- (void)ThreadLogin:(NSString*)strWebServiceURL;
- (void)ThreadQuitCalledMethod:(id)loginResult;

@end

//
//  LoginViewController.m
//  GuideAssist
//
//  Created by 朱 起伟 on 11-8-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "GuideAssistAppDelegate.h"
#import "DebugMacroDefine.h"
#import "CWaitModelViewController.h"

@implementation LoginViewController

@synthesize loginPassword = loginPassword_;
@synthesize loginType = loginType_;
@synthesize loginName = loginName_;
//@synthesize lableTest = pLableTest_;


////user defined method

- (IBAction)LoginButtonPressed:(id)sender
{
//  Log( @"LoginViewController LoginButtonPressed self retanCount:%d", [self retainCount]);
//  opetationQueue_ = [[NSOperationQueue alloc] init];
//  [opetationQueue_ setMaxConcurrentOperationCount:1];
//  invoctionOperation_ = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(ThreadLogin:) object:strWebServiceURL_];
//  [opetationQueue_ addOperation:invoctionOperation_];
 // [self release];
  //Log( @"LoginViewController LoginButtonPressed self retanCount:%d", [self retainCount]); 
   GuideAssistAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
   [appDelegate ShowMainView];

  
}

- (IBAction)quitBtnPressed:(id)sender
{
    exit( 0 );
}

- (void)keyboardWliiShow
{
    return;
  
//    if ( [ loginName_ isFirstResponder ] )
//    {
//        CGRect viewFrame = self.view.frame;
//        viewFrame.origin.y -= 216;//g_pAppDelegate.boundKeyboard.size.height;
//        self.view.frame = viewFrame;
//        [ UIView animateWithDuration:0.4 
//                          animations:^
//                        {
//                           [ UIView setAnimationTransition:UIViewAnimationTransitionCurlUp 
//                                                   forView:self.view cache:NO ];  
//                        }
//                          completion:^(BOOL bComplete)
//                        {
//                            if ( bComplete )
//                            {
//                                NSLog( @"complete");
//                            }
//                        } ];
//    }
}

- (IBAction)textFeildDone:(id)sender forEvent:(UIEvent *)event 
{
    if ( sender == loginName_ )
    {
        [ loginPassword_ becomeFirstResponder ];
    }
    else
    {
        [ sender resignFirstResponder ];

    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [ keyboardObserver_ hideKeyboard ];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ( textField == loginPassword_ )
    {

    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{

}

-(void)ThreadLogin:(NSString *)strWebServiceURL
{
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
  NSLog( @"LoginViewController ThreadLogin start");

  BOOL bRet = FALSE;
  //do logining
  bRet = TRUE;
  
  NSNumber *numRet = [[NSNumber alloc] initWithBool:bRet];
  Log( @"LoginViewController ThreadLogin numRet 1 retanCount:%u", [numRet retainCount]);
  
  
  [self performSelectorOnMainThread:@selector(ThreadQuitCalledMethod:) 
                         withObject:numRet 
                      waitUntilDone:YES];
  Log( @"LoginViewController ThreadLogin numRet 2 retanCount:%u", [numRet retainCount]);
  Log( @"LoginViewController ThreadLogin 1 self retanCount:%u",[self retainCount]);

  [numRet release];
  NSLog( @"LoginViewController ThreadLogin end");
  [pool drain];
  Log( @"LoginViewController ThreadLogin 2 self retanCount:%u",[self retainCount]);

  
}

-(void)ThreadQuitCalledMethod:(id)loginResult
{
  NSNumber *numRet = (NSNumber*)loginResult;

  if ( [numRet boolValue] )
  {
//    GuideAssistAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
//    [appDelegate ShowMainView];
      [ g_pAppDelegate ShowMainView ];
  }
}

////////inherited method////

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        strWebServiceURL_ = [[NSString alloc] init];

        self.view.backgroundColor = g_pAppDelegate.bgImgColor;
        keyboardObserver_ = [[ CKeyBroardObserber alloc ] init ];
//        [ keyboardObserver_ setKeyboardWillShowDidMethod:self
//                                             forSelector:@selector(keyboardWliiShow) ];
        keyboardObserver_.autoAdjustRootView = YES;
        keyboardObserver_.rootView = self.view;
        [ keyboardObserver_ addViewOfNeedKeyboard:loginName_ ];
        [ keyboardObserver_ addViewOfNeedKeyboard:loginPassword_ ];
    }
    return self;
}

- (void)dealloc
{
    self.loginName = nil;
    self.loginPassword = nil;
    self.loginType = nil;
    [ keyboardObserver_ release ];
  [strWebServiceURL_ release];
  [opetationQueue_ release];
  [invoctionOperation_ release];
   [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{

   [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

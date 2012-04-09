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


@implementation LoginViewController

@synthesize loginPassword_;
@synthesize loginType_;
@synthesize loginName_;



////user defined method

- (IBAction)LoginButtonPressed:(id)sender
{
  Log( @"LoginViewController LoginButtonPressed self retanCount:%d", [self retainCount]);
  opetationQueue_ = [[NSOperationQueue alloc] init];
  [opetationQueue_ setMaxConcurrentOperationCount:1];
  invoctionOperation_ = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(ThreadLogin:) object:strWebServiceURL_];
  [opetationQueue_ addOperation:invoctionOperation_];
 // [self release];
  Log( @"LoginViewController LoginButtonPressed self retanCount:%d", [self retainCount]); 

  
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
 // Log( @"LoginViewController ThreadQuiCallMethod: 1, loginResult retainCount: %u", [loginResult retainCount]);
  NSNumber *numRet = (NSNumber*)loginResult;
  Log( @"LoginViewController ThreadQuiCallMethod: loginResult: %@,refCount:%u", numRet,[numRet retainCount]);
  Log( @"LoginViewController ThreadQuiCallMethod: self refCount:%u",[self retainCount]);

  //return;
  if ( [numRet boolValue] )
  {
    GuideAssistAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate ShowMainView];
  }
}

////////inherited method////

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      strWebServiceURL_ = [[NSString alloc] init];
    }
    return self;
}

- (void)dealloc
{
  [loginPassword_ release];
  [loginType_ release];
  [loginName_ release];
  [strWebServiceURL_ release];
  [opetationQueue_ release];
  [invoctionOperation_ release];
  Log(@"LoginViewController dealloc");
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
  [self setLoginPassword:nil];
  [self setLoginName:nil];
  [self setLoginType:nil];
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

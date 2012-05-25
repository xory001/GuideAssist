//
//  CWaitModelViewController.m
//  GuideAssist
//
//  Created by 朱 起伟 on 12-5-15.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CWaitModelViewController.h"


@implementation CWaitModelViewController
@synthesize labelMessage_;
@synthesize activityIndicatorView = activityIndicatorView_;
@synthesize message = strMessage_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
      //  [ activityIndicatorView_ startAnimating ];
    }
    return self;
}

- (void)dealloc
{
    
    [activityIndicatorView_ release];
    self.message = nil;
    [labelMessage_ release];
    [super dealloc];
}

- (void)start
{
    labelMessage_.text = strMessage_;
  //  [ activityIndicatorView_ startAnimating ];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
#ifdef DEBUG
   [ self.parentViewController dismissModalViewControllerAnimated:NO ];
#endif
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
    [self setActivityIndicatorView:nil];
    [self setLabelMessage_:nil];
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

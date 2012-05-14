//
//  CTodayItineraryController.m
//  GuideAssist
//
//  Created by 朱 起伟 on 12-5-13.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
#import "GuideAssistAppDelegate.h"
#import "CTodayItineraryController.h"


@implementation CTodayItineraryController
@synthesize scrollView_;
@synthesize btnPreDay_;
@synthesize btnNextDay_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        self.title = @"今日行程";
        self.view.backgroundColor = g_pAppDelegate.bgImgColor;
       // scrollView_.frame = g_pAppDelegate.frameApp;
        scrollView_.backgroundColor = [ UIColor clearColor ];
        [ self.view addSubview: scrollView_ ];
    }
    return self;
}

- (void)dealloc
{
    [ scrollView_ release ];
    [btnPreDay_ release];
    [btnNextDay_ release];
    [super dealloc];
}

- (IBAction)btnPreDayClick:(id)sender forEvent:(UIEvent *)event {
}

- (IBAction)btnNextDayClick:(id)sender forEvent:(UIEvent *)event {
}

- (BOOL)userInit:(NSString *)pstrItinearyNumber
{
    scrollView_.contentSize = CGSizeMake( g_pAppDelegate.frameApp.size.width, 480 * 2 );
    return YES;
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
    [self setScrollView_:nil];
    [self setBtnPreDay_:nil];
    [self setBtnNextDay_:nil];
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

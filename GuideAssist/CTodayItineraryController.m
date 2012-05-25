//
//  CTodayItineraryController.m
//  GuideAssist
//
//  Created by 朱 起伟 on 12-5-13.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
#import "GuideAssistAppDelegate.h"
#import "CTodayItineraryController.h"
#import "CCalendarCalc.h"


@implementation CTodayItineraryController

//@synthesize groupName = strGroupName_;
//@synthesize itineraryNumber = strItineraryNumber_;

@synthesize scrollView_;
@synthesize btnPreDay_;
@synthesize btnNextDay_;
@synthesize labelDay_;
@synthesize labelCity_;
@synthesize labelCount_;
@synthesize labelGuideName_;
@synthesize labelGuidePhone_;
@synthesize labelTrafficType_;
@synthesize labelDriveName_;
@synthesize labelDrivePhone_;
@synthesize labelItineraryDesc;
@synthesize labelPage_;
@synthesize labelTravelGroupName_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        self.title = @"今日行程";
        self.view.backgroundColor = g_pAppDelegate.bgImgColor;
        scrollView_.backgroundColor = [ UIColor clearColor ];
        [ self.view addSubview: scrollView_ ];
        arrDetailItinerary_ = [[ NSMutableArray alloc ] init ];
    }
    return self;
}

- (void)dealloc
{
    [ arrDetailItinerary_ removeAllObjects ];
    [ arrDetailItinerary_ release ];
    [ strGroupName_ release ];
    [ strItineraryNumber_ release ];
    [ strCurDate_ release ];
    
    [ scrollView_ release ];
    [btnPreDay_ release];
    [btnNextDay_ release];
    [labelDay_ release];
    [labelCity_ release];
    [labelCount_ release];
    [labelGuideName_ release];
    [labelGuidePhone_ release];
    [labelTrafficType_ release];
    [labelDriveName_ release];
    [labelDrivePhone_ release];
    [labelItineraryDesc release];
    [labelPage_ release];
    [labelTravelGroupName_ release];
    [super dealloc];
}

- (IBAction)btnPreDayClick:(id)sender forEvent:(UIEvent *)event 
{
    if ( nDetailIndex_ > 0 )
    {
        nDetailIndex_--;
        [ self showItineraryDetailInfo ];
    }
}

- (IBAction)btnNextDayClick:(id)sender forEvent:(UIEvent *)event 
{
    if ( nDetailIndex_ + 1 < ( [ arrDetailItinerary_ count ] ) )
    {
        nDetailIndex_++;
        [ self showItineraryDetailInfo ];
    }
}

- (BOOL)userInit:(NSString *)pstrItinearyNumber groupName:(NSString *)strGroupName
{
    strGroupName_ = [ strGroupName copy ];
    strItineraryNumber_ = [ pstrItinearyNumber copy ];

       
    
   
    
    [ g_pAppDelegate.dataAccess getAllDetailItinerary:arrDetailItinerary_ 
                                   ByMainSerialNumber:strItineraryNumber_ ];
    
    scrollView_.contentSize = CGSizeMake( g_pAppDelegate.frameApp.size.width, 
                                         labelItineraryDesc.frame.origin.y + labelItineraryDesc.frame.size.height + 20 );
    nDetailIndex_ = -1;
    for ( CDetailItinerary *pDetail in arrDetailItinerary_ )
    {
        if ( [ pDetail.day isEqualToString: strCurDate_ ])
        {
            nDetailIndex_ = [ arrDetailItinerary_ indexOfObject: pDetail ];
            break;
        }
    }
    if ( -1 == nDetailIndex_ ) 
    {  
        nDetailIndex_ = 0;
    }
    
    [ self showItineraryDetailInfo ];
    
    return YES;
}

- (void)showItineraryDetailInfo
{
    
    if ( nDetailIndex_ >= 0 && nDetailIndex_ < [ arrDetailItinerary_ count ] )
    {
        CDetailItinerary *detail = [ arrDetailItinerary_ objectAtIndex:nDetailIndex_ ];
        labelGuideName_.text = strGroupName_;
        labelDay_.text = detail.day;
        labelCity_.text = detail.city;
        labelGuideName_.text = detail.localGuide;
        labelGuidePhone_.text = detail.localGuidePhone;
        labelTrafficType_.text = detail.traffic;
        labelDriveName_.text = detail.driverName;
        labelDrivePhone_.text = detail.driverPhone;
        labelItineraryDesc.text = detail.detailDesc;
    }
    NSString *strPage = nil;
    if ( [ arrDetailItinerary_ count ] )
    {
        strPage = [[ NSString alloc ] initWithFormat:@"第%d/%d日" ];
    }
    else
    {
        strPage = [[ NSString alloc ] initWithString:@"第0/0日" ];
    }
    labelPage_.text = strPage;
    [ strPage release ];
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
    [self setLabelDay_:nil];
    [self setLabelCity_:nil];
    [self setLabelCount_:nil];
    [self setLabelGuideName_:nil];
    [self setLabelGuidePhone_:nil];
    [self setLabelTrafficType_:nil];
    [self setLabelDriveName_:nil];
    [self setLabelDrivePhone_:nil];
    [self setLabelItineraryDesc:nil];
    [self setLabelPage_:nil];
    [self setLabelTravelGroupName_:nil];
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

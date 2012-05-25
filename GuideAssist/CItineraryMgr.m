//
//  CItineraryMgr.m
//  GuideAssist
//
//  Created by 朱 起伟 on 12-5-17.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CItineraryMgr.h"
#import "GuideAssistAppDelegate.h"


@implementation CItineraryMgr

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        self.title = @"行程管理";
        self.view.backgroundColor = g_pAppDelegate.bgImgColor;
     //   dictLabel_ = [[ NSMutableDictionary alloc ] init ];
        arrLabel_ = [[ NSMutableArray alloc ] init ];
        [ CCalendarCalc getCurYear:&nCurYear_ andMonth:&nCurMonth_ ];
        arrItineraryNumber_ = [[ NSMutableArray alloc ] init ];
        
        NSString *strImgMonth = [ [NSBundle mainBundle ] pathForResource:@"past" 
                                                              ofType:@"png" 
                                                         inDirectory:@"resource" ];
        UIImage *img = [ UIImage imageWithContentsOfFile:strImgMonth ];
        imgViewLastMonth_ = [[ UIImageView alloc ] initWithImage:img ];
        
        strImgMonth = [ [NSBundle mainBundle ] pathForResource:@"current" 
                                                         ofType:@"png" 
                                                    inDirectory:@"resource" ];
        img = [ UIImage imageWithContentsOfFile:strImgMonth ];
        imgViewCurMonth_ = [[ UIImageView alloc ] initWithImage:img ];

        strImgMonth = [ [NSBundle mainBundle ] pathForResource:@"future" 
                                                         ofType:@"png" 
                                                    inDirectory:@"resource" ];
        img = [ UIImage imageWithContentsOfFile:strImgMonth ];
        imgViewNexMonth_ = [[ UIImageView alloc ] initWithImage:img ];

        
        
       
        int nLabelWid = g_pAppDelegate.frameApp.size.width / 7;
        int nStartPos = (NSInteger)g_pAppDelegate.frameApp.size.width % 7 / 2;

        NSString *pstrImg = [ [NSBundle mainBundle ] pathForResource:@"date_bg" 
                                                              ofType:@"png" 
                                                         inDirectory:@"resource" ];
        CGRect frameBG = CGRectMake( 0, 10, g_pAppDelegate.frameApp.size.width, nLabelWid / 2 );
        UIView *viewBG = [[ UIView alloc ] initWithFrame: frameBG ];
        viewBG.backgroundColor = [[ UIColor alloc ] initWithPatternImage:
                                  [ UIImage imageWithContentsOfFile:pstrImg ] ];

        [ self.view addSubview:viewBG ];
        [ viewBG release ];
        
        
        UIColor *clearColor = [ UIColor clearColor ];     
       // CGColorRef cgcolorBlack = [[ UIColor blackColor ] CGColor ];
        NSMutableArray *arrWeekLabel = [[ NSMutableArray alloc ] init ];
        CGRect frameLabel = CGRectMake( nStartPos, 10, nLabelWid, nLabelWid / 2 );
        for ( int j = 0; j < 7; j++ )
        {

            UILabel *labelWeek = [[ UILabel alloc ] initWithFrame:frameLabel ];
            [ self.view addSubview:labelWeek ];
            labelWeek.backgroundColor = clearColor;
            labelWeek.textAlignment = UITextAlignmentCenter;
         //   labelWeek.layer.borderWidth = 0.5;
         //   labelWeek.layer.borderColor = [ UIColor blackColor ].CGColor;
            [ arrWeekLabel addObject:labelWeek ];
       
            [ labelWeek release ];
            
            frameLabel.origin.x += nLabelWid;
        }
        
        ((UILabel*)[ arrWeekLabel objectAtIndex:0 ]).text = @"日";
        ((UILabel*)[ arrWeekLabel objectAtIndex:1 ]).text = @"一";
        ((UILabel*)[ arrWeekLabel objectAtIndex:2 ]).text = @"二";
        ((UILabel*)[ arrWeekLabel objectAtIndex:3 ]).text = @"三";
        ((UILabel*)[ arrWeekLabel objectAtIndex:4 ]).text = @"四";
        ((UILabel*)[ arrWeekLabel objectAtIndex:5 ]).text = @"五";
        ((UILabel*)[ arrWeekLabel objectAtIndex:6 ]).text = @"六";
        
        [ arrWeekLabel removeAllObjects ];
        [ arrWeekLabel release ];
        
        frameLabel.origin.x = 0;
        frameLabel.origin.y += nLabelWid / 2;
        frameLabel.size.height = nLabelWid;
        for ( int i = 0; i < 6 ; i++ )
        {
            for ( int j = 0; j < 7; j++ )
            {
                if ( 0 == j )
                {
                    frameLabel.size.width = nLabelWid + nStartPos;
                }
                else if ( 6 == j )
                {
                    frameLabel.size.width = nLabelWid + nStartPos + 1;
                }
                else
                {
                    frameLabel.size.width = nLabelWid;
                }
                UIButton *label = [[ UIButton alloc ] initWithFrame:frameLabel ];
             //   label.backgroundColor = clearColor;
                label.tag = 0;
                [ label addTarget:self action:@selector(labelClick:forEvent:) forControlEvents:UIControlEventTouchUpInside ];
             //   label.titleLabel.textAlignment = UITextAlignmentCenter;
             //   label.layer.borderWidth = 1;
             //   label.layer.borderColor = cgcolorBlack;
             //   label.userInteractionEnabled = YES;
                  
                [ self.view addSubview:label ];
                [ arrLabel_ addObject:label ];
                [ label release ];
                
                frameLabel.origin.x += frameLabel.size.width;
            }
            frameLabel.origin.y += nLabelWid;
            frameLabel.origin.x = 0;
        }
        
        [ self showCalendar ];        
        

    }
    return self;
}

- (void)labelClick:(id)sender forEvent:(UIEvent *)event
{
    UIButton *btn = sender;
  //  [ btn addSubview:imgViewLastMonth_ ];
  //  NSLog(@"lable: %@", ((UIButton*)sender).currentTitle );
    NSInteger nDay = btn.tag;
    NSString *strDay = [ NSString stringWithFormat:@"%04d-%02d-%02d", ( nDay >> 16 ) & 0xffff,
                             ( nDay >> 8 ) & 0xff, nDay & 0xff ];
    NSLog(@"%@", strDay );
}

- (void)showCalendar
{
    //calc weekday
    NSInteger nTag = 0;
    int nDaysOfMonth = 0;
    int nFirstWeekDay = [ CCalendarCalc getFisrtDayWeekAndDaysOfMonth:&nDaysOfMonth
                                                               byYear:nCurYear_ andMonth:nCurMonth_ ];

    UIButton *label = nil;
    UIColor *colorBlack =  [ UIColor blackColor ];
    UIColor *colorGray = [ UIColor grayColor ];
    for ( int i = 1; i <= nDaysOfMonth; i++ )
    {
         NSString *strCurMonth = [[ NSString alloc ] initWithFormat:@"%d", i ];
         label = [ arrLabel_ objectAtIndex: i + nFirstWeekDay - 2 ];
       
        [ label setTitle:strCurMonth forState:UIControlStateNormal ];
   //     [ label setTitle:strTemp forState:UIControlStateHighlighted ];
        [ label setTitleColor:colorBlack forState:UIControlStateNormal ];
        nTag =  ( nCurYear_ << 16 ) | ( nCurMonth_ << 8 ) | i;
        [ label setTag: nTag ]; 
  //      [ label setTitleColor:colorBlack forState:UIControlStateHighlighted ];
   //     [ label setBackgroundColor:colorGray ];
        [ strCurMonth release ];
    }
    
   
    //last month
    int nDayOfLastMonth = 0;
    int nLastMonth = 0, nLastYear = 0;
    if ( 1 == nCurMonth_ ) 
    {
        nLastMonth = 12;
        nLastYear = nCurYear_ - 1;
    }
    else
    {
        nLastMonth = nCurMonth_ - 1;
        nLastYear = nCurYear_;
    }
    [ CCalendarCalc getFisrtDayWeekAndDaysOfMonth:&nDayOfLastMonth byYear:nLastYear andMonth:nLastMonth ];
    int nLastMonthPos = nFirstWeekDay - 2;
    while ( nLastMonthPos >= 0 )
    {
        NSString *strLastMonth = [[ NSString alloc ] initWithFormat:@"%d", nDayOfLastMonth ];
        label = [ arrLabel_ objectAtIndex:nLastMonthPos ];
        [ label setTitle:strLastMonth forState:UIControlStateNormal ];
        [ label setTitleColor:colorGray forState:UIControlStateNormal ];
        [ label setTag:( nLastYear << 16 ) | ( nLastMonth << 8 ) | nDayOfLastMonth ]; 
        [ strLastMonth release ];
       
        nLastMonthPos--;
        nDayOfLastMonth--;
    }
    
//    NSString *strStartDay = [ NSString stringWithFormat:@"%d-%02d-%02@",  ];

    //next month
    int nNextYear = 0, nNextMobth = 0;
    if ( 12 == nCurMonth_ )
    {
        nNextYear = nCurYear_ + 1;
        nNextMobth = 1;
    }
    else
    {
        nNextYear = nCurYear_;
        nNextMobth = nCurMonth_ + 1;
    }
    int nNextMonthPos = nDaysOfMonth + nFirstWeekDay - 2 + 1;
    int nNextMonthDay = 1;
    while ( nNextMonthPos < [ arrLabel_ count ] )
    {
        NSString *strNextMonth = [[ NSString alloc ] initWithFormat:@"%d", nNextMonthDay ];
        label = [ arrLabel_ objectAtIndex: nNextMonthPos ];
        [ label setTitle:strNextMonth forState:UIControlStateNormal ];
        [ label setTitleColor:colorGray forState:UIControlStateNormal ];
      //  [ label setBackgroundColor:colorBlack ];
        [ label setTag: ( nNextYear << 16 ) | ( nNextMobth << 8 ) | nNextMonthDay ];
        [ strNextMonth release ];
        
        nNextMonthDay++;
        nNextMonthPos++;
    }
    
    int nDay = ((UIButton*)[ arrLabel_ objectAtIndex:0 ]).tag;
    NSString *strStartDay = [ NSString stringWithFormat:@"%04d-%02d-%02d", ( nDay >> 16 ) & 0xffff,
                         ( nDay >> 8 ) & 0xff, nDay & 0xff ];
    nDay = ((UIButton*)[ arrLabel_ lastObject ]).tag;
    NSString *strEndDay = [ NSString stringWithFormat:@"%04d-%02d-%02d", ( nDay >> 16 ) & 0xffff,
                           ( nDay >> 8 ) & 0xff, nDay & 0xff ];
    [ arrItineraryNumber_ removeAllObjects ];
    if ( [ g_pAppDelegate.dataAccess getMainItineraryNumber:arrItineraryNumber_
                                                 byStartDay:strStartDay 
                                                  andEndDay:strEndDay ] )
    {
        NSMutableString *strDate = [[ NSMutableString alloc ] init ];
        for ( CMainItinerarySerialNumner *itinerayNumber in arrItineraryNumber_ )
        {
            for ( UIButton *btn in arrLabel_ )
            {
                [ strDate setString:@"" ];
                NSInteger nDay = btn.tag;
                [ strDate appendFormat:@"%04d-%02d-%02d", ( nDay >> 16 ) & 0xffff,
                                    ( nDay >> 8 ) & 0xff, nDay & 0xff ];
                if ( [ strDate isEqualToString:itinerayNumber.date ] )
                {
                    NSLog(@"%@", strDate );
                }
            
            }
        }
        [ strDate release ];
    }
}

- (void)dealloc
{
   // [ dictLabel_ removeAllObjects ];
  //  [ dictLabel_ release ];
    [ arrLabel_ removeAllObjects ];
    [ arrLabel_ release ];
    [ arrItineraryNumber_ removeAllObjects ];
    [ arrItineraryNumber_ release ];
    [ imgViewCurMonth_ release ];
    [ imgViewLastMonth_ release ];
    [ imgViewNexMonth_ release ];
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

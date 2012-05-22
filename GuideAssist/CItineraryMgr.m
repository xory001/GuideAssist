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
        
        
               
        NSMutableArray *arrWeekLabel = [[ NSMutableArray alloc ] init ];
        CGRect frameLabel = CGRectMake( nStartPos, 10, nLabelWid, nLabelWid / 2 );
        for ( int j = 0; j < 7; j++ )
        {

            UILabel *labelWeek = [[ UILabel alloc ] initWithFrame:frameLabel ];
           // label.text = @"8";
           // label.tag = ( i << 16 ) & j;
            [ self.view addSubview:labelWeek ];
            labelWeek.backgroundColor = [ UIColor clearColor ];
            labelWeek.textAlignment = UITextAlignmentCenter;
         //   labelWeek.layer.borderWidth = 0.5;
         //   labelWeek.layer.borderColor = [ UIColor blackColor ].CGColor;
            labelWeek.backgroundColor = [ UIColor clearColor ];
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
                UILabel *label = [[ UILabel alloc ] initWithFrame:frameLabel ];
                label.backgroundColor = [ UIColor clearColor ];
                label.tag = i * j + j;
                label.textAlignment = UITextAlignmentCenter;
                label.layer.borderWidth = 0.5;
                label.layer.borderColor = [ UIColor blackColor ].CGColor;
                //[ label ];
                
                [ self.view addSubview:label ];
                [ arrLabel_ addObject:label ];
                [ label release ];
                
                frameLabel.origin.x += frameLabel.size.width;
            }
            frameLabel.origin.y += nLabelWid;
            frameLabel.origin.x = 0;
        }
        
        //calc weekday
        //NSString *strEmpty = [ NSString 
        NSMutableString *strTemp = [[ NSMutableString alloc ] init ];
        int nDaysOfMonth = 0;
        int nFirstWeekDay = [ CCalendarCalc getCurMonthFisrtDayWeek: &nDaysOfMonth ];
        for ( int i = 1; i <= nDaysOfMonth; i++ )
        {
            [ strTemp setString:@"" ];
            [ strTemp appendFormat:@"%d", i ];
            ( (UILabel*)[ arrLabel_ objectAtIndex:i + nFirstWeekDay - 2 ] ).text = strTemp;
        }
        
        

    }
    return self;
}

- (void)labelClick:(id)sender forEvent:(UIEvent *)event
{
    NSLog(@"lable: %d", ((UILabel*)sender).tag );
}

- (void)dealloc
{
   // [ dictLabel_ removeAllObjects ];
  //  [ dictLabel_ release ];
    [ arrLabel_ removeAllObjects ];
    [ arrLabel_ release ];
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

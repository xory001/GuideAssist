//
//  MainViewController.m
//  GuideAssist
//
//  Created by 朱 起伟 on 11-8-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "GuideAssistAppDelegate.h"
#import "MainViewController.h"
#import "CGroupMemberListController.h"
#import "CTodayItineraryController.h"
#import "CItineraryMgr.h"
#import "DialogUIAlertView.h"



@implementation MainViewController

@synthesize dicMainIcon = pDictMainIcon_;
@synthesize mainView = pMainView_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        [ self initBtns ];  
        self.title = @"导游助手";
        self.view.backgroundColor = g_pAppDelegate.bgImgColor;
    }
    return self;
}

- (void)dealloc
{
    self.dicMainIcon = nil;
    self.mainView = nil;
    [ strCurDayItinerary_ release ];
    [super dealloc];
}

         
- (void)BtnEvent:(id)sender forEvent:(UIControlEvents)event
{
    UIButton *pBtn = (UIButton*)sender;
    int nTag = pBtn.tag;
    switch ( nTag )
    {
        case  1:
        {
            NSString *strCurDay = [ CCalendarCalc getCurDay ];
            NSArray *retArray = [ g_pAppDelegate.dataAccess getFirstMainItineraryByDate:strCurDay ];
            if ( nil == retArray )
            {
                msgBox(@"", @"今日无行程", @"确定", nil );
                return;
            }
            
            strCurDayItinerary_ = [[ retArray objectAtIndex:0 ] copy ];
            
            CTodayItineraryController *pTodayC = 
                [[ CTodayItineraryController alloc ] initWithNibName:nil bundle:nil ];
            [ pTodayC userInit:strCurDayItinerary_ groupName:[ retArray lastObject ] ];
            [ self.navigationController pushViewController:pTodayC animated:YES ];
            [ pTodayC release ];
        }
            break;
            
        case 2: //group menber manage
        {
            if ( nil == strCurDayItinerary_ )
            {
                NSString *strCurDay = [ CCalendarCalc getCurDay ];
                NSArray *retArray = [ g_pAppDelegate.dataAccess getFirstMainItineraryByDate:strCurDay ];
                if ( nil == retArray )
                {
                    msgBox(@"", @"今日无行程,没有团员信息", @"确定", nil );
                    return;
                }
                strCurDayItinerary_ = [[ retArray objectAtIndex:0 ] copy ];
            }
                        
           
            
            CGroupMemberListController *pGroupC = 
                        [[ CGroupMemberListController alloc ] initWithNibName:nil bundle:nil ];
            [ pGroupC loadData:strCurDayItinerary_ ];
            [ self.navigationController pushViewController:pGroupC animated:YES ];
            [ pGroupC release ];
        }
            break;
            
        case 4:
        {
            CItineraryMgr *itineraryMgr = [[ CItineraryMgr alloc ] initWithNibName:nil
                                                                            bundle:nil ];
            [ self.navigationController pushViewController:itineraryMgr animated:YES ];
            [ itineraryMgr release ];
        }
            break;
            
        default:
            break;
    }

}
 
- (BOOL)initBtns
{
    //load icon.plist file
    NSString *pstrIconFile = [[ NSBundle mainBundle ] pathForResource:@"icon" 
                                                               ofType:@"plist" inDirectory:@"config" ];
    NSDictionary *pdicIconContent = [[[ NSDictionary alloc ] initWithContentsOfFile: pstrIconFile ] autorelease ];
    
    NSString *pstrResoucePath =  [[[ NSString alloc ] initWithFormat:@"%@/resource",
                                   [[ NSBundle mainBundle ] bundlePath ] ] autorelease ];
    
#define MAIN_ICON_WIDTH 64
#define MAIN_ICON_HEIGHT 64
#define WIDTH_ICONS   4
    
    CGRect rectCurView = self.view.frame;
    int nYMargin = 10;
    int nXmargin = ( rectCurView.size.width - MAIN_ICON_WIDTH * WIDTH_ICONS ) / 5;
    int nRow = 0;
    int nColumn = 0;
   
    NSString *pstrValue = nil;
    NSString  *pstrImgPath = nil;
    UIButton *pBtn = nil;
    NSArray *pArrKey = [ pdicIconContent allKeys ];

    CGRect rectBtn = CGRectMake( nXmargin, nYMargin, MAIN_ICON_WIDTH, MAIN_ICON_HEIGHT );
    NSArray *pArrayString = nil;
    UIImage *pImg = nil;
    for ( NSString *pstrKey in pArrKey )
    {
        pstrValue = [ pdicIconContent objectForKey:pstrKey ];
        pArrayString = [ pstrValue componentsSeparatedByString:@"," ];
        if ( 2 != [ pArrayString count ] ) 
        {
            continue;
        }
        pstrImgPath = [[ NSString alloc ] initWithFormat:@"%@/%@", pstrResoucePath, 
                       [ pArrayString objectAtIndex:0 ]];
        pImg = [ UIImage imageWithContentsOfFile: pstrImgPath ];
        pBtn = [[ UIButton alloc] init ];
        if ( pImg )
        {
            [ pBtn setBackgroundImage:pImg forState:UIControlStateNormal ];
        }
        [ pBtn setTag: [ pstrKey intValue ]]; 
        [ pBtn setFrame:rectBtn ];
        [ pBtn setTitle:[ pArrayString lastObject ] forState:UIControlStateNormal ];
        [ pBtn addTarget:self action:@selector(BtnEvent:forEvent:) forControlEvents:UIControlEventTouchUpInside ];
        [ self.view addSubview: pBtn ];
        [ pBtn release ];
        
        nColumn++;
        if ( WIDTH_ICONS == nColumn ) 
        {
            nColumn = 0;
            nRow++;
            rectBtn.origin.y = ( nRow + 1 ) * nYMargin + nRow * MAIN_ICON_HEIGHT;
        }
        rectBtn.origin.x = ( nColumn + 1 ) * nXmargin + nColumn * MAIN_ICON_WIDTH;
        

    }
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

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
        int nLabelWid = g_pAppDelegate.frameApp.size.width / 7;
        int nStartPos = (NSInteger)g_pAppDelegate.frameApp.size.width % 7 / 2;
        
        NSMutableArray *arrWeekLabel = [[ NSMutableArray alloc ] init ];
        CGRect frameLabel = CGRectMake( nStartPos, 40, nLabelWid, nLabelWid );
        for ( int j = 0; j < 7; j++ )
        {
            UILabel *labelWeek = [[ UILabel alloc ] initWithFrame:frameLabel ];
           // label.text = @"8";
           // label.tag = ( i << 16 ) & j;
            [ self.view addSubview:labelWeek ];
            labelWeek.textAlignment = UITextAlignmentCenter;
            labelWeek.layer.borderWidth = 0.5;
            labelWeek.layer.borderColor = [ UIColor blackColor ].CGColor;
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
        
        frameLabel.origin.x = nStartPos;
        frameLabel.origin.y += nLabelWid;
        for ( int i = 0; i < 6 ; i++ )
        {
            for ( int j = 0; j < 7; j++ )
            {
                UILabel *label = [[ UILabel alloc ] initWithFrame:frameLabel ];
                label.text = @"8";
                label.tag = ( i << 16 ) & j;
                [ self.view addSubview:label ];
                label.textAlignment = UITextAlignmentCenter;
                label.layer.borderWidth = 0.5;
                label.layer.borderColor = [ UIColor blackColor ].CGColor;
                [ label release ];
                
                frameLabel.origin.x += nLabelWid;
            }
            frameLabel.origin.y += nLabelWid;
            frameLabel.origin.x = nStartPos;
        }
        

    }
    return self;
}

- (void)dealloc
{
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

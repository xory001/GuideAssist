//
//  MainViewController.m
//  GuideAssist
//
//  Created by 朱 起伟 on 11-8-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"



@implementation MainViewController

@synthesize dicMainIcon = pDictMainIcon_;
@synthesize mainView = pMainView_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        //load icon.plist file
        NSString *pstrIconFile = [[ NSBundle mainBundle ] pathForResource:@"icon" 
                                ofType:@"plist" inDirectory:@"config" ];
        pDictMainIcon_ = [[ NSDictionary alloc ] initWithContentsOfFile: pstrIconFile ];
        
        NSString *pstrResoucePath =  [[ NSString alloc ] initWithFormat:@"%@/resource",
                                [[ NSBundle mainBundle ] bundlePath ] ];
        
        NSString *pstrKey = nil, *pstrValue = nil;
        UIButton *pBtn = nil;
        NSArray *pArrKey = [ pDictMainIcon_ allKeys ];
        int nIndex  = 0;
        
        int nColumn = 0;
        CGRect rectView = self.view.frame;
        CGRect rectBtn;
        while ( TRUE )
        {
            for ( int i = 0 ; i < 4; i++ )
            {
        
            }
//            {
//                pstrValue = [ pDictMainIcon_ objectForKey:pstrKey ];
//                pArrayString = [ pstrValue componentsSeparatedByString:@"," ];
//                for ( NSString *pstrTmp in pArrayString )
//                {
//                    pBtn = [ UIButton alloc ] initWithCoder:<#(NSCoder *)#>
//                }
//                
//            }
 
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

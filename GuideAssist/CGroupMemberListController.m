//
//  CGroupMemberListController.m
//  GuideAssist
//
//  Created by 朱 起伟 on 12-5-9.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CGroupMemberListController.h"
#import "GuideAssistAppDelegate.h"


@implementation CGroupMemberListController

#define TABLE_ROW_HEIGHT 64


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
     //   NSLog( @"Group member list controller initWithNibName:");

        CGRect appFrame = [[ UIScreen mainScreen ] applicationFrame ];
        UITableView *pGroupMemberTabView = [[ UITableView alloc ] initWithFrame:appFrame 
                                                            style:UITableViewStyleGrouped ];
        [ pGroupMemberTabView setDelegate:self ];
        [ pGroupMemberTabView setDataSource:self ];
        [ pGroupMemberTabView setTag:11 ];
        self.view.frame = appFrame;
        [self.view addSubview:pGroupMemberTabView ];
         nMaxTableItemShowing_ = pGroupMemberTabView.frame.size.height / TABLE_ROW_HEIGHT;
        [ pGroupMemberTabView release ];
        
       
        pstrResoucePath_ =  [[ NSString alloc ] initWithFormat:@"%@/resource",
                                       [[ NSBundle mainBundle ] bundlePath ]];

        pArrGroupMember_ = [[ NSMutableArray alloc ] init ];
        
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
    [ pArrGroupMember_ release ];
    [ pstrResoucePath_ release ];
}

- (BOOL)loadData:(NSString *)pstrMainItineraryNumber
{
    //get data base access;
    GuideAssistAppDelegate *pAppdelegate = [ UIApplication sharedApplication ].delegate;
    pDBAccess_ = pAppdelegate.dataAccess;
    return [ pDBAccess_ getAllGroupMember:pArrGroupMember_ ByMainSerialNumber:pstrMainItineraryNumber ];
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // return nil;
    NSLog(@"table row: %d", indexPath.row );
    if ( indexPath.row > [ pArrGroupMember_ count ] )
    {
        return nil;
    }
    NSString *pstrIdentify = [[ NSString alloc ] initWithFormat:@"%d", 
                              indexPath.row % nMaxTableItemShowing_ + 1 ];
     
    UITableViewCell *pCell = [ tableView dequeueReusableCellWithIdentifier:pstrIdentify ];
    if ( nil == pCell )
    {
        pCell = [[ UITableViewCell alloc ] initWithStyle:UITableViewCellStyleDefault 
                                                          reuseIdentifier:pstrIdentify ];
        if ( [ pArrGroupMember_ count ] )
        {
            UIImage *pImgSex = nil;
            NSMutableString *pstrPic = [[ NSMutableString alloc ] initWithString: pstrResoucePath_ ];
            CGroupMember *pMember = [ pArrGroupMember_ objectAtIndex:indexPath.row ];
            if ( [ pMember.sex isEqualToString:@"1" ] ) //male
            {
                [ pstrPic appendString:@"/boy.png" ];
                pImgSex = [ UIImage imageWithContentsOfFile: pstrPic ];
            }
            else if ( [ pMember.sex isEqualToString:@"2" ] ) //female
            {
                [ pstrPic appendString:@"/girl.png" ];
                pImgSex = [ UIImage imageWithContentsOfFile: pstrPic ];
            }
            [ pCell.imageView setImage:pImgSex ];
            [ pImgSex release ];
            
            pCell.detailTextLabel.text = pMember.phone;
            pCell.textLabel.text = pMember.name;
            pCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else
        {
           pCell.textLabel.text = pstrIdentify; 
        }
    }
    [ pstrIdentify release ];
    return pCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ( ( nil != pArrGroupMember_) && [ pArrGroupMember_ count ] )
    {
        NSLog( @"row count: %d", [ pArrGroupMember_ count ] );
        return [ pArrGroupMember_ count ];
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64.0f;  
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
    
    
    //NSLog( @"Group member list controller viewDidLoad");
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

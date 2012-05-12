//
//  CGroupMemberListController.m
//  GuideAssist
//
//  Created by 朱 起伟 on 12-5-9.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CGroupMemberListController.h"
#import "GuideAssistAppDelegate.h"
#import "CGroupMemberDetailController.h"


@implementation CGroupMemberListController

#define TABLE_ROW_HEIGHT 64


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
     //   NSLog( @"Group member list controller initWithNibName:");
         self.view.backgroundColor = g_pAppDelegate.bgImgColor;
        CGRect scnFrame = [[ UIScreen mainScreen ] bounds ];
        
        UITableView *pGroupMemberTabView = [[ UITableView alloc ] 
                                            initWithFrame:scnFrame 
                                                    style:UITableViewStyleGrouped ];
        [ pGroupMemberTabView setDelegate:self ];
        [ pGroupMemberTabView setDataSource:self ];
        [ pGroupMemberTabView setTag:11 ];
        pGroupMemberTabView.allowsSelection = YES;
        self.view.frame = [[ UIScreen mainScreen ] applicationFrame ];
        [self.view addSubview:pGroupMemberTabView ];
         nMaxTableItemShowing_ = pGroupMemberTabView.frame.size.height / TABLE_ROW_HEIGHT;
        if ( nMaxTableItemShowing_ == 0 )
        {
            nMaxTableItemShowing_ = 1;
        }
        pGroupMemberTabView.backgroundColor = [ UIColor clearColor ];
        [ pGroupMemberTabView release ];
        self.title = @"团员管理"; //团员详细信息
       
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

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
   // NSLog( @"%d", indexPath.row );
}

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView
         accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath

{
    //NSLog( @"%d", indexPath.row );
    return UITableViewCellAccessoryDisclosureIndicator;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //return @"团圆信息";
    return nil;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"table row: %d", indexPath.row );

    NSString *pstrIdentify = [[[ NSString alloc ] initWithFormat:@"%d", 
                              indexPath.row % nMaxTableItemShowing_ + 1 ] autorelease ];
     
    UITableViewCell *pCell = [ tableView dequeueReusableCellWithIdentifier:pstrIdentify ];
       
    if ( nil == pCell )
    {
        pCell = [[ UITableViewCell alloc ] initWithStyle:UITableViewCellStyleSubtitle
                                                          reuseIdentifier:pstrIdentify ];
    }
  //  pCell.backgroundColor = [ UIColor clearColor ];

    if ( [ pArrGroupMember_ count ] )
    {
        UIImage *pImgSex = nil;
        NSMutableString *pstrPic = [[[ NSMutableString alloc ] 
                                    initWithString: pstrResoucePath_ ] autorelease ];
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
        if ( nil != pImgSex )
        {
            [ pCell.imageView setImage:pImgSex ];
        }
       
     
        pCell.detailTextLabel.text = pMember.phone;
        pCell.textLabel.text = pMember.name;
        pCell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    else
    {
        pCell.textLabel.text = [ NSString stringWithFormat:@"empty item" ];
    }

    return pCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [ tableView deselectRowAtIndexPath:indexPath animated:YES ];
    CGroupMemberDetailController *pGroupDetailCtrller = 
                [[ CGroupMemberDetailController alloc ] initWithNibName:nil bundle:nil ];
    pGroupDetailCtrller.arrGroupMember = pArrGroupMember_;
    pGroupDetailCtrller.nCurMemberIndex = indexPath.row;
    [ pGroupDetailCtrller initViewState ];
    [ self.navigationController pushViewController:pGroupDetailCtrller animated:YES ];
    [ pGroupDetailCtrller release ];
    
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

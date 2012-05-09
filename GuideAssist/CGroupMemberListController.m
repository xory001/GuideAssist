//
//  CGroupMemberListController.m
//  GuideAssist
//
//  Created by 朱 起伟 on 12-5-9.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CGroupMemberListController.h"


@implementation CGroupMemberListController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        CGRect appFrame = [[ UIScreen mainScreen ] applicationFrame ];
        UITableView *pGroupMemberTabView = [[ UITableView alloc ] initWithFrame:appFrame 
                                                            style:UITableViewStyleGrouped ];
        [ pGroupMemberTabView setDelegate:self ];
        [ pGroupMemberTabView setDataSource:self ];
        self.view.frame = appFrame;
        [self.view addSubview:pGroupMemberTabView ];
        [ pGroupMemberTabView release ];
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *pCell = [[ UITableViewCell alloc ] initWithStyle:UITableViewCellStyleDefault 
                                                      reuseIdentifier:@"1" ];
    pCell.textLabel.text = @"1";
    return pCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
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

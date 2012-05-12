//
//  CGroupMemberDetailController.m
//  GuideAssist
//
//  Created by 朱 起伟 on 12-5-12.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GuideAssistAppDelegate.h"
#import "CGroupMemberDetailController.h"


@implementation CGroupMemberDetailController

@synthesize labelPage_;
@synthesize labelSex_;
@synthesize labelAge_;
@synthesize labelPhone_;
@synthesize labelIDCard_;
@synthesize labelIDCardNo_;
@synthesize labelPaidState_;
@synthesize labelRemark_;
@synthesize labelName_;
@synthesize btnPrePage_;
@synthesize btnNextPage_;

@synthesize arrGroupMember = pArrGroupMember_;
@synthesize nCurMemberIndex = nCurMemberIndex_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = g_pAppDelegate.bgImgColor;
        self.title = @"团员信息";

    }
    return self;
}

- (void)dealloc
{
    [labelPage_ release];
    [labelSex_ release];
    [labelAge_ release];
    [labelPhone_ release];
    [labelIDCard_ release];
    [labelIDCardNo_ release];
    [labelPaidState_ release];
    [labelRemark_ release];
    [labelName_ release];
    [btnPrePage_ release];
    [btnNextPage_ release];
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
}

- (void)viewDidUnload
{
    [self setLabelPage_:nil];
    [self setLabelSex_:nil];
    [self setLabelAge_:nil];
    [self setLabelPhone_:nil];
    [self setLabelIDCard_:nil];
    [self setLabelIDCardNo_:nil];
    [self setLabelPaidState_:nil];
    [self setLabelRemark_:nil];
    [self setLabelName_:nil];
    [self setBtnPrePage_:nil];
    [self setBtnNextPage_:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)initViewState
{
    if ( ( nil == pArrGroupMember_ ) || ( 0 == [ pArrGroupMember_ count ] ) ) 
    {
        btnPrePage_.enabled = NO;
        btnPrePage_.enabled = NO;
    }
    else if ( 0 == nCurMemberIndex_ )
    {
        btnPrePage_.enabled = NO;
        btnNextPage_.enabled = YES;
    }
    else if ( nCurMemberIndex_ == ( [ pArrGroupMember_ count ] - 1 ) )
    {
        btnPrePage_.enabled = YES;
        btnNextPage_.enabled = NO;
    }
    [ self updateMemberInfo ];
}

- (void)updateMemberInfo
{
    if ( ( nil != pArrGroupMember_ ) && ( nCurMemberIndex_ < [ pArrGroupMember_ count ] ) )
    {
        CGroupMember *pGroupMember = [ pArrGroupMember_ objectAtIndex:nCurMemberIndex_ ];
        labelAge_.text = pGroupMember.age;
        labelIDCard_.text = pGroupMember.idCardType;
        labelIDCardNo_.text = pGroupMember.idCardNumber;
        //labelPaidState_.text = pGroupMember.paid;
        labelPhone_.text = pGroupMember.phone;
        labelRemark_.text = pGroupMember.remark;
        labelSex_.text = pGroupMember.sex;
        labelName_.text = pGroupMember.name;
        
        NSString *pstrPage = [[ NSString alloc ] initWithFormat:@"第%d/%d位", 
                              nCurMemberIndex_ + 1, [ pArrGroupMember_ count ]];
        labelPage_.text = pstrPage;
        [ pstrPage release ];
    }
}

- (void)btnPrePageClick:(id)sender forEvent:(UIEvent *)event
{
    nCurMemberIndex_--;
    if ( nCurMemberIndex_ <= 0 )
    {
        btnPrePage_.enabled = NO;
        btnNextPage_.enabled = YES;
        nCurMemberIndex_ = 0;
    }
    [ self updateMemberInfo ];
    
}

- (void)btnNextPageClick:(id)sender forEvent:(UIEvent *)event
{
    nCurMemberIndex_++;
    if ( nCurMemberIndex_ == ( [ pArrGroupMember_ count ] - 1 ) )
    {
//        nCurMemberIndex_ = [ pArrGroupMember_ count ] - 1;
        btnPrePage_.enabled = YES;
        btnNextPage_.enabled = NO;
    }
    [ self updateMemberInfo ];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

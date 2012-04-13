//
//  CGroupMember.m
//  GuideAssist
//
//  Created by 朱 起伟 on 12-4-11.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CGroupMember.h"


@implementation CGroupMember

@synthesize uid = uid_;
@synthesize nPaid = nPaid_;
@synthesize name = pstrName_;
@synthesize sex = pstrSex_;
@synthesize age = pstrAge_;
@synthesize remark = pstrRemark_;
@synthesize phone = pstrPhone_;
@synthesize idCardType = pstrIDCardType_;
@synthesize idCardNumber = pstrIDCardNumber_;

- (id)init
{
    self = [ super init ];
    if ( self )
    {
      uid_ = 0;
      nPaid_ = 0;
      pstrName_ = [[ NSString alloc ] init ];
      pstrSex_ = [[ NSString alloc ] init ];
      pstrAge_ = [[ NSString alloc ] init ];
      pstrRemark_ = [[ NSString alloc ] init ];
      pstrPhone_ = [[ NSString alloc ] init ];
      pstrIDCardType_ = [[ NSString alloc ] init ];
      pstrIDCardNumber_ = [[ NSString alloc ] init ];
      
    }
    return self;
}

- (void)dealloc
{
    self.name = nil;
    self.sex = nil;
    self.age = nil;
    self.remark = nil;
    self.phone = nil;
    self.idCardNumber = nil;
    self.idCardType = nil;
    [ super dealloc ];
}


@end

//
//  CGroupMember.m
//  GuideAssist
//
//  Created by 朱 起伟 on 12-4-11.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CGroupMember.h"


@implementation CGroupMember

@synthesize nid = nid_;
@synthesize nPaid = nPaid_;
@synthesize Name = pstrName_;
@synthesize Sex = pstrSex_;
@synthesize Age = pstrAge_;
@synthesize Remark = pstrRemark_;
@synthesize Phone = pstrPhone_;
@synthesize IDCardType = pstrIDCardType_;
@synthesize IDCardNumber = pstrIDCardNumber_;

- (id)init
{
    self = [ super init ];
    if ( self )
    {
      nid_ = 0;
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
    self.Name = nil;
    self.Sex = nil;
    self.Age = nil;
    self.Remark = nil;
    self.Phone = nil;
    self.IDCardNumber = nil;
    self.IDCardType = nil;
    [ super dealloc ];
}


@end

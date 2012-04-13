//
//  File.c
//  GuideAssist
//
//  Created by 朱 起伟 on 12-4-10.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
#import "CDataTypeDef.h"

@implementation CMainItineraryDateID

@synthesize uid = uid_;
@synthesize date = pstrDate_;

- (id)init
{
    self = [ super init ];
    if ( self )
    {
        uid_ = 0;
        pstrDate_ = [[ NSString alloc ] init ];
    }
    return self;
}

- (void)dealloc
{
    self.date = nil;
    [ super dealloc ];
}

@end
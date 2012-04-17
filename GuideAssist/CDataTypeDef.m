//
//  File.c
//  GuideAssist
//
//  Created by 朱 起伟 on 12-4-10.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
#import "CDataTypeDef.h"

@implementation CMainItinerarySerialNumner

@synthesize serialNumner = pstrSerialNumner_;
@synthesize date = pstrDate_;

- (id)init
{
    self = [ super init ];
    if ( self )
    {
        pstrSerialNumner_ = [[ NSString alloc ] init ];
        pstrDate_ = [[ NSString alloc ] init ];
    }
    return self;
}

- (void)dealloc
{
    self.serialNumner = nil;
    self.date = nil;
    [ super dealloc ];
}

@end
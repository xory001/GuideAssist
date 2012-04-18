//
//  CWebServiceAccess.m
//  GuideAssist
//
//  Created by 朱 起伟 on 12-4-18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CWebServiceAccess.h"


@implementation CWebServiceAccess

@synthesize url = pstrURL_;
@synthesize soapAction = pstrSoapAction_;
@synthesize guidePhone = pstrGuidePhone_;
@synthesize icCardNumber = pstrICCardNumber_;

- (id)init
{
    self = [ super init ];
    if ( self )
    {
        pstrURL_ = [[ NSString alloc ] init ];
        pstrSoapAction_ = [[ NSString alloc ] init ];
        pstrGuidePhone_ = [[ NSString alloc ] init ];
        pstrICCardNumber_ = [[ NSString alloc ] init ];
        
        phttpRequest_ = [[ HttpDownloadHelper alloc ] init ];
        
        
    }
    
    return self;
}

- (void)dealloc
{
    self.url = nil;
    self.soapAction = nil;
    self.guidePhone = nil;
    self.icCardNumber = nil;
    
    [ phttpRequest_ release ];
    
    [ super dealloc ];
}



@end

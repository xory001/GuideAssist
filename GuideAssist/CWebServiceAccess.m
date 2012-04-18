//
//  CWebServiceAccess.m
//  GuideAssist
//
//  Created by 朱 起伟 on 12-4-18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CWebServiceAccess.h"
#import "baseModule/HttpRequest.h"


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
        pstrContentFormat_ = [[ NSString alloc ] initWithString:
                              @"<?xml version=\"1.0\" encoding=\"utf-8\"?> \
                              <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" \
                              xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" \
                              xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"> \
                              <soap:Body>%@</soap:Body></soap:Envelope>"];
        
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
    [ pstrContentFormat_ release ];
    
    [ phttpRequest_ release ];
    
    [ super dealloc ];
}

- (BOOL)userLogin:(NSMutableString *)pstrRetXML
{
    NSString *pstrMD5 = [[ NSString alloc ] init ];
    NSString *pstrLoginBody = [[ NSString alloc ] initWithFormat:
                               @"<userLogin xmlns=\"http://service.travelsys.pubinfo.zj.cn/\"> \
                               <arg0 xmlns=\"\">712936</arg0> \
                               <arg1 xmlns=\"\">15305712936</arg1> \
                               <arg2 xmlns=\"\">0</arg2> \
                               <arg3 xmlns=\"\">158f81736f</arg3> \
                               </userLogin>", self.icCardNumber,
                               self.guidePhone, 0, pstrMD5 ];
    [ phttpRequest_ setHTTPHeaderValue: self.soapAction forKey:@"SOAPAction" ];
    [ phttpRequest_ setHTTPMethod: @"POST" ];
    [ phttpRequest_ setHttpBody: pstrLoginBody withEncoding: NSUnicodeStringEncoding ];
    if ( [ phttpRequest_ startDownloadWithBlockTime: 10 ] )
    {
        NSString *pstrRet = [ phttpRequest_ getResultString ];
        NSLog( @"%@", pstrRet );
    }
    
    
    return NO;
}





@end

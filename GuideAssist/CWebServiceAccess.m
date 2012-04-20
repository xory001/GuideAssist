//
//  CWebServiceAccess.m
//  GuideAssist
//
//  Created by 朱 起伟 on 12-4-18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CWebServiceAccess.h"
#import <CommonCrypto/CommonDigest.h>
#import "baseModule/XMLParser.h"
#import "baseModule/TreeNode.h"
#import "baseModule/IniFileManager.h"
#import "CDBAccess.h"


@implementation CWebServiceAccess

@synthesize url = pstrURL_;
@synthesize soapAction = pstrSoapAction_;
@synthesize guidePhone = pstrGuidePhone_;
@synthesize icCardNumber = pstrICCardNumber_;
@synthesize dbAccess = pDBAccess_;

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
    self.dbAccess = nil;
    self.url = nil;
    self.soapAction = nil;
    self.guidePhone = nil;
    self.icCardNumber = nil;
    [ pstrContentFormat_ release ];
    
    [ phttpRequest_ release ];
    
    [ super dealloc ];
}

- (NSString*)getMD5:(NSString *)pstrSource
{
    NSMutableString *pstrMD5 = [[ NSMutableString alloc ] init ];
    unsigned char szMD5[16] = {0};
    CC_MD5( [ pstrSource UTF8String ], [ pstrSource length ], szMD5 );
    for (int i = 0; i < 16; i++ )
    {
        [ pstrMD5 appendFormat:@"%02x", szMD5[i] ];
    }
    NSString *pstrRet = [[[ NSString alloc ] initWithString: 
                         [ pstrMD5 substringWithRange: NSMakeRange( 2, 9 ) ] ] autorelease ];
    [ pstrMD5 release ];
    return pstrRet;
}

- (BOOL)getItineraryInfo:(NSString*)pstrItineraryNumber timeStamp:(NSString*)pstrTimeStamp opetation:(BOOL)bUpdate
{
    
    return NO;
}

- (BOOL)syncItineraryInfo:(NSMutableDictionary *)pDictSyncItineraryInfo
{
    NSMutableString *pstrItineraryInfo = [[ NSMutableString alloc ] init ];
    NSEnumerator *pEnumerator = [ pDictSyncItineraryInfo keyEnumerator ];
    NSString *pstrKey = NULL, *pstrValue = NULL;
    pstrKey = [ pEnumerator nextObject ];
    while ( pstrKey )
    {
        pstrValue = [ pDictSyncItineraryInfo objectForKey:pstrKey ];
        [ pstrItineraryInfo appendFormat:@"%@|%@", pstrKey, pstrValue ];
        pstrKey = [ pEnumerator nextObject ];
        if ( pstrKey )
        {
            [ pstrItineraryInfo appendString: @"," ];
        }
    }
    NSString *pCurDay = [ self getYYYYMMddhh ];
    NSString *pstrSource = [[[ NSString alloc ] initWithFormat:@"%@%@%@%@", pstrItineraryInfo,
                             pCurDay, self.icCardNumber,
                             self.guidePhone ] autorelease ];
    NSString *pstrMD5 = [ self getMD5: pstrSource ];
    NSString *pstrLoginInfo = [[[ NSString alloc ] initWithFormat:
                                @"<isDataSync xmlns=\"http://service.travelsys.pubinfo.zj.cn/\"> \
                                <arg0 xmlns=\"\">%@</arg0> \
                                <arg1 xmlns=\"\">%@</arg1> \
                                <arg2 xmlns=\"\">%@</arg2> \
                                <arg3 xmlns=\"\">%@</arg3> \
                                <arg4 xmlns=\"\">%@</arg4> \
                                <arg5 xmlns=\"\">1</arg5> \
                                </isDataSync>", pstrItineraryInfo,
                                pCurDay, self.icCardNumber,
                                self.guidePhone, pstrMD5 ] autorelease ];
    
    NSString *pstrBody = [[[ NSString alloc ] initWithFormat: pstrContentFormat_ , pstrLoginInfo ] autorelease ];
    
    NSString *pstrRet = [ self callMethod: pstrBody ];
    if ( pstrRet )
    {
        TreeNode *pXMLRoot = [[ XMLParser sharedInstance ] parseXMLFromData:
                              [ pstrRet dataUsingEncoding: NSUnicodeStringEncoding ]];
        if ( NSOrderedSame == [[ pXMLRoot leafForKey:@"Result" ] compare: @"0" ] )
        {
            NSLog(@"%@", [ pXMLRoot leafForKey:@"ErrInfo" ] ); 
             return NO;
        }
        else if ( NSOrderedSame == [[ pXMLRoot leafForKey:@"Result" ] compare: @"1" ] )
        {
            NSString *pstrItineraryInfo = [ pXMLRoot leafForKey:@"Xcd" ];
            NSArray *parrItinerary = [ pstrItineraryInfo componentsSeparatedByString:@"," ];
            for ( NSString *pstrTmp in parrItinerary )
            {
                NSArray *parrTmp = [ pstrTmp componentsSeparatedByString:@"|" ];
                NSString *pItineraryNumber = [ parrTmp objectAtIndex: 0 ];
                NSString *pItineraryState = [ parrTmp lastObject ];
                switch ( [ pItineraryState intValue ] )
                {
                    case ITINERARY_STATE_ADD:
                        [ self getItineraryInfo2DateBaseByItineraryNumber:pItineraryNumber ];
                        break;
                        
                    case ITINERARY_STATE_MODIFY:
                        [ self.dbAccess deleteAllItineraryBySerialNumber:pItineraryNumber ];
                        [ self getItineraryInfo2DateBaseByItineraryNumber:pItineraryNumber ];
                        break;
                        

                    case ITINERARY_STATE_DEL:
                        [ self.dbAccess deleteAllItineraryBySerialNumber:pItineraryNumber ];
                        break;
                        
                    default:
                        break;
                }
            }
            
            return YES;
        }
        else
        {
            return NO;
        }
        
    }
    
    
    return NO;
}

- (BOOL)userLogin:(NSString**)ppstrRetErrInfo
{
    NSString *pstrSource = [[[ NSString alloc ] initWithFormat:@"%@%@0", self.icCardNumber,
                                self.guidePhone ] autorelease ];
    NSString *pstrMD5 = [ self getMD5: pstrSource ];
    NSString *pstrLoginInfo = [[[ NSString alloc ] initWithFormat:
                               @"<userLogin xmlns=\"http://service.travelsys.pubinfo.zj.cn/\"> \
                               <arg0 xmlns=\"\">%@</arg0> \
                               <arg1 xmlns=\"\">%@</arg1> \
                               <arg2 xmlns=\"\">0</arg2> \
                               <arg3 xmlns=\"\">%@</arg3> \
                               </userLogin>", self.icCardNumber,
                               self.guidePhone, pstrMD5 ] autorelease ];
    NSString *pstrBody = [[[ NSString alloc ] initWithFormat: pstrContentFormat_ , pstrLoginInfo ] autorelease ];
   
    NSString *pstrRet = [ self callMethod: pstrBody ];
    if ( pstrRet )
    {
        TreeNode *pXMLRoot = [[ XMLParser sharedInstance ] parseXMLFromData:
                              [ pstrRet dataUsingEncoding: NSUnicodeStringEncoding ]];
        if ( NSOrderedSame == [[ pXMLRoot leafForKey:@"Result" ] compare: @"0" ] )
        {
            if ( NULL != ppstrRetErrInfo )
            {
                *ppstrRetErrInfo = [[[ NSString alloc ] initWithString: 
                                     [ pXMLRoot leafForKey:@"ErrInfo" ] ] autorelease ];
                //     NSLog(@"%@", *ppstrRetErrInfo );
            }
            return NO;
        }
        else if ( NSOrderedSame == [[ pXMLRoot leafForKey:@"Result" ] compare: @"1" ] )
        {
            return YES;
        }
        else
        {
            return NO;
        }
 
    }
     
    return NO;
}

- (NSString*)callMethod:(NSString *)pstrRequestBody
{
    [ phttpRequest_ setUrl: self.url ];
    [ phttpRequest_ setHTTPHeaderValue: self.soapAction forKey:@"SOAPAction" ];
    [ phttpRequest_ setHTTPMethod: @"POST" ];
    [ phttpRequest_ setHttpBody: pstrRequestBody withEncoding: NSUTF8StringEncoding ];
    if ( [ phttpRequest_ startDownloadWithBlockTime: 10000 ] )
    {
        NSString *pstrRet = [ [phttpRequest_ getResultString ] stringByReplacingOccurrencesOfString: @"&lt;" withString: @"<" ] ;
        NSUInteger uIndex = [ pstrRet findString: @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>" 
                               withStartLocation: 1 ];
        return [ pstrRet midString: uIndex ];
    }
    return nil;
}

- (NSString*)getYYYYMMddhh
{
    NSDateFormatter *pFormat = [[ NSDateFormatter alloc ] init ];
    [ pFormat setDateFormat:@"YYYYMMddhh" ];
    NSString *pDay = [ pFormat stringFromDate: [ NSDate date ] ];
    [ pFormat release ];
    return pDay;
}

@end













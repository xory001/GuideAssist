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
#import <sys/time.h>




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

- (BOOL)closeItinerary:(NSString *)pstrItineraryNumber remark:(NSString *)pstrRemark
{
    NSString *pstrSource = [[[ NSString alloc ] initWithFormat:@"%@%@%@", self.icCardNumber,
                             self.guidePhone, pstrItineraryNumber ] autorelease ];
    NSString *pstrMD5 = [ self getMD5: pstrSource ];
    NSString *pstrRequestInfo = [[[ NSString alloc ] initWithFormat:
                                  @"<XcdClose xmlns=\"http://service.tourhelper.pubinfo.zj.cn/\"> \
                                  <arg0 xmlns=\"\">%@</arg0> \
                                  <arg1 xmlns=\"\">%@</arg1> \
                                  <arg2 xmlns=\"\">%@</arg2> \
                                  <arg3 xmlns=\"\">%@</agr3> \
                                  <arg4 xmlns=\"\">%@</arg4> \
                                  </XcdClose>", self.icCardNumber,
                                  self.guidePhone, pstrItineraryNumber,pstrRemark, pstrMD5 ] autorelease ];
    
    NSString *pstrBody = [[[ NSString alloc ] initWithFormat: pstrContentFormat_ , pstrRequestInfo ] autorelease ];
    
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
            return YES;
        }
    }
    
    return NO;
}

- (BOOL)getGroupMember:(NSString *)pstrItineraryNumber timeStamp:(NSString *)pstrTimeStamp
{
    NSString *pstrSource = [[[ NSString alloc ] initWithFormat:@"%@0", pstrItineraryNumber,
                             pstrTimeStamp ] autorelease ];
    NSString *pstrMD5 = [ self getMD5: pstrSource ];  //http://service.travelsys.pubinfo.zj.cn
    NSString *pstrRequestInfo = [[[ NSString alloc ] initWithFormat: //http://service.tourhelper.pubinfo.zj.cn
                                @"<TyDataSync xmlns=\"http://service.tourhelper.pubinfo.zj.cn/\"> \
                                <arg0 xmlns=\"\">%@</arg0> \
                                <arg1 xmlns=\"\">0</arg1> \
                                <arg2 xmlns=\"\">%@</arg2> \
                                </TyDataSync>", pstrItineraryNumber,
                                /*pstrTimeStamp ,*/ pstrMD5 ] autorelease ];
    
    NSString *pstrBody = [[[ NSString alloc ] initWithFormat: pstrContentFormat_ , pstrRequestInfo ] autorelease ];
    
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
            TreeNode *pXMLGroupRoot = [ pXMLRoot objectForKey:@"TY" ];
            if ( NSOrderedSame == [[ pXMLGroupRoot leafForKey:@"s"] compare:@"1"] )
            {
                [ pDBAccess_ deleteGroupMemberInfoByBySerialNumber:pstrItineraryNumber ];
                NSArray *parrGroupMembers = [ pXMLGroupRoot objectsForKey:@"dd" ];
                CGroupMember *pMember = [[ CGroupMember alloc ] init ];
                for ( TreeNode *pTmpNode in parrGroupMembers )
                {
                    pMember.name = [ pTmpNode leafForKey:@"a" ];
                    pMember.sex = [ pTmpNode leafForKey:@"b" ];
                    pMember.age = [ pTmpNode leafForKey:@"c" ];
                    pMember.phone = [ pTmpNode leafForKey:@"d" ];
                    pMember.remark = [ pTmpNode leafForKey:@"f" ];
                    pMember.paid = [[ pTmpNode leafForKey:@"g" ] intValue ];
                    pMember.idCardType = [ pTmpNode leafForKey:@"h" ];
                    pMember.idCardNumber = [ pTmpNode leafForKey:@"i" ];
                    pMember.serialNumber = pstrItineraryNumber;
                    
                    [ pDBAccess_ insertGroupMember: pMember ];
                }
                [ pMember release ];

            }
            return YES;
        }
    }
    
    return NO;
}

- (BOOL)getItineraryInfo:(NSString*)pstrItineraryNumber timeStamp:(NSString*)pstrTimeStamp
{
    NSString *pstrCurTime = [ self getYYYYMMddhh ];
    NSString *pstrSource = [[[ NSString alloc ] initWithFormat:@"%@%@%@", self.icCardNumber,
                             self.guidePhone, pstrTimeStamp ] autorelease ];
    NSString *pstrMD5 = [ self getMD5: pstrSource ];
    NSString *pstrRequestInfo = [[[ NSString alloc ] initWithFormat:
                                @"<XcdDataSync xmlns=\"http://service.tourhelper.pubinfo.zj.cn/\"> \
                                <arg0 xmlns=\"\">%@</arg0> \
                                <arg1 xmlns=\"\">%@</arg1> \
                                <arg2 xmlns=\"\">%@</arg2> \
                                <arg3 xmlns=\"\">%@</arg3> \
                                <arg4 xmlns=\"\">%@</arg4> \
                                <arg5 xmlns=\"\">%@</arg5> \
                                </XcdDataSync>",self.icCardNumber,
                                self.guidePhone, pstrItineraryNumber, 
                                pstrTimeStamp, pstrCurTime , pstrMD5 ] autorelease ];
    
    NSString *pstrBody = [[[ NSString alloc ] initWithFormat: pstrContentFormat_ , pstrRequestInfo ] autorelease ];
    
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
            TreeNode *pXcdNode = [[ pXMLRoot objectForKey:@"Xcd" ] objectForKey:@"ds" ];
            TreeNode *pMainItineraryNode = [ pXcdNode objectForKey:@"mn" ];
            CMainItinerary *pMainItinerary = nil;
            if ( pMainItineraryNode )
            {
                pMainItinerary = [[ CMainItinerary alloc ] init ];
                
                pMainItinerary.tourGroupName = [ pMainItineraryNode leafForKey:@"a" ];
                pMainItinerary.travelAgencyName = [ pMainItineraryNode leafForKey:@"b" ];
                pMainItinerary.memberCount = [[ pMainItineraryNode leafForKey:@"c" ] intValue ];
                pMainItinerary.timeStamp = [ pMainItineraryNode leafForKey:@"d" ];
                pMainItinerary.startDay = [ pMainItineraryNode leafForKey:@"e" ];
                pMainItinerary.endDay = [ pMainItineraryNode leafForKey:@"f" ];
                pMainItinerary.serialNumber = pstrItineraryNumber;
            }
            pMainItineraryNode = [ pXcdNode objectForKey:@"fe" ];
            if ( pMainItineraryNode && pMainItinerary )
            {
                pMainItinerary.standardCost = [ pMainItineraryNode leafForKey:@"a" ];
                pMainItinerary.roomCost = [ pMainItineraryNode leafForKey:@"b" ];
                pMainItinerary.ticketCost = [ pMainItineraryNode leafForKey:@"c" ];
                pMainItinerary.mealCost = [ pMainItineraryNode leafForKey:@"d" ];
                pMainItinerary.trafficCost = [ pMainItineraryNode leafForKey:@"e" ];
                pMainItinerary.personalTotalCost = [ pMainItineraryNode leafForKey:@"f" ];
                pMainItinerary.groupTotalCost = [ pMainItineraryNode leafForKey:@"g" ];
            }
            if ( pMainItinerary )
            {
                [ pDBAccess_ deleteItineraryBySerialNumber: pstrItineraryNumber ];
                [ pDBAccess_ insertMainItinerary: pMainItinerary ];
                [ pMainItinerary release ]; 
            }

                  
            CDetailItinerary *pDetailItinerary = nil;
            pMainItineraryNode = [ pXcdNode objectForKey:@"dts" ];
            NSArray *parrDetailNode = [ pXcdNode objectsForKey:@"dd" ];
            int nIndex = 1;
          
            for ( TreeNode *pTmpNode in parrDetailNode ) 
            {
                pDetailItinerary = [[ CDetailItinerary alloc ] init ];
                
                pDetailItinerary.index = nIndex;
                pDetailItinerary.day = [ pTmpNode leafForKey:@"a" ];
                pDetailItinerary.traffic = [ pTmpNode leafForKey:@"c" ];
                pDetailItinerary.trafficNo = [ pTmpNode leafForKey:@"d" ];
                pDetailItinerary.driverName = [ pTmpNode leafForKey:@"e" ];
                pDetailItinerary.driverPhone = [ pTmpNode leafForKey:@"f" ];
                pDetailItinerary.city = [ pTmpNode leafForKey:@"i" ];
                pDetailItinerary.meal = [ pTmpNode leafForKey:@"j" ]; //it means traffic time, 2012.05.29
                pDetailItinerary.room = [ pTmpNode leafForKey:@"k" ];
                pDetailItinerary.detailDesc = [[ pTmpNode objectForKey:@"t" ] leafForKey:@"c" ];
                pDetailItinerary.localTravelAgencyName = [ pTmpNode leafForKey:@"r" ];
                pDetailItinerary.localGuide = [ pTmpNode leafForKey:@"g" ];
                pDetailItinerary.localGuidePhone = [ pTmpNode leafForKey:@"h" ];
                pDetailItinerary.serialNumber = pstrItineraryNumber;
                   //<j></j> traffic time
                //<t><c>desc</c></t>
                
                [ pDBAccess_ insertDetailItinerary: pDetailItinerary ];
                nIndex++;
               
            }
            [ pDetailItinerary release ];
                                 
            return YES;
        }
        else
        {
            return NO;
        }
        
    }
    return NO;
}

- (BOOL)syncItineraryInfo:(NSMutableDictionary *)pDictSyncItineraryInfo
{
    NSMutableString *pstrLocalItineraryInfo = [[[ NSMutableString alloc ] init ] autorelease ];
    NSEnumerator *pEnumerator = [ pDictSyncItineraryInfo keyEnumerator ];
    NSString *pstrKey = nil, *pstrValue = nil;
    pstrKey = [ pEnumerator nextObject ];
    while ( pstrKey )
    {
        pstrValue = [ pDictSyncItineraryInfo objectForKey:pstrKey ];
        [ pstrLocalItineraryInfo appendFormat:@"%@|%@", pstrKey, pstrValue ];
        pstrKey = [ pEnumerator nextObject ];
        if ( pstrKey )
        {
            [ pstrLocalItineraryInfo appendString: @"," ];
        }
    }
    NSString *pCurDay = [ self getYYYYMMddhh ];
    NSString *pstrSource = [[[ NSString alloc ] initWithFormat:@"%@%@%@%@", pstrLocalItineraryInfo,
                             pCurDay, self.icCardNumber,
                             self.guidePhone ] autorelease ];
    NSString *pstrMD5 = [ self getMD5: pstrSource ];
    NSString *pstrLoginInfo = [[[ NSString alloc ] initWithFormat:
                                @"<IsDataSync xmlns=\"http://service.tourhelper.pubinfo.zj.cn/\"> \
                                <arg0 xmlns=\"\">%@</arg0> \
                                <arg1 xmlns=\"\">%@</arg1> \
                                <arg2 xmlns=\"\">%@</arg2> \
                                <arg3 xmlns=\"\">%@</arg3> \
                                <arg4 xmlns=\"\">%@</arg4> \
                                <arg5 xmlns=\"\">1</arg5> \
                                </IsDataSync>", pstrLocalItineraryInfo,
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
                    case ITINERARY_STATE_MODIFY:
                        [ self getItineraryInfo:pItineraryNumber timeStamp:@"0" ];
                        [ self getGroupMember:pItineraryNumber timeStamp:@"0" ];
                        break;
                        

                    case ITINERARY_STATE_DEL:
                        [ self.dbAccess deleteItineraryBySerialNumber:pItineraryNumber ];
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
                               @"<UserLogin xmlns=\"http://service.tourhelper.pubinfo.zj.cn/\"> \
                               <arg0 xmlns=\"\">%@</arg0> \
                               <arg1 xmlns=\"\">%@</arg1> \
                               <arg2 xmlns=\"\">0</arg2> \
                               <arg3 xmlns=\"\">%@</arg3> \
                               </UserLogin>", self.icCardNumber,
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
                if ( [ pXMLRoot leafForKey:@"ErrInfo" ] ) 
                {
                    *ppstrRetErrInfo = [[[ NSString alloc ] initWithString: 
                                         [ pXMLRoot leafForKey:@"ErrInfo" ] ] autorelease ];
                }
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
        if ( NSNotFound == uIndex )
        {
            return nil;
        }
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

- (uint32_t)getTickCount
{
    struct timeval tv;
    gettimeofday( &tv, NULL );
    return (uint32_t)( tv.tv_sec * 1000 + tv.tv_usec / 1000 );
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
                          [ pstrMD5 substringWithRange: NSMakeRange( 2, 10 ) ] ] autorelease ];
    [ pstrMD5 release ];
    return pstrRet;
}

@end













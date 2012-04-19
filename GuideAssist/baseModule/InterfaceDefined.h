//
//  InterfaceDefine.h
//  WebServiceTest
//
//  Created by Titaro on 12-3-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#ifndef WebServiceTest_InterfaceDefined_h
#define WebServiceTest_InterfaceDefined_h

#import "DialogUIAlertView.h"
#import "HttpRequest.h"
#import "XMLParser.h"
#import "IniFileManager.h"

#define OUT_PUT_LOG

#ifdef OUT_PUT_LOG
void LogStr(NSString*, ...);
#else
#define LogStr(str, ...)
#endif


FOUNDATION_EXPORT NSInteger _toInt(NSString* pstrInteger);
FOUNDATION_EXPORT BOOL validString(NSString* pstrValue);
FOUNDATION_EXPORT BOOL validEquelString(NSString* pstrValue, NSString* pstrEquelValue);
FOUNDATION_EXPORT void _doRelease(id* pId);
FOUNDATION_EXPORT void _doAutoRelease(id* pId);
FOUNDATION_EXPORT void _setMString(NSMutableString** ppstrTarget, NSString* pstrVal);
FOUNDATION_EXPORT void _setString(NSString** ppstrTarget, NSString* pstrVal);

#define toInt(pstrInteger) _toInt(pstrInteger)
#define intToString(intVal) [NSString stringWithFormat:@"%d", intVal]
#define uIntToString(uIntVal) [NSString stringWithFormat:@"%d", uIntVal]
#define long64ToString(long64Val) [NSString stringWithFormat:@"%lld", long64Val]

#define setString(strTarget, strVal) _setString(&(strTarget), strVal)
#define setMString(strTarget, strVal) _setMString(&(strTarget), strVal);
#define doRelease(id) _doRelease(&(id))
#define doAutoRelease(id) _doAutoRelease(&(id))


#define xmlNodeStringVal(pXmlNode, ...) \
[pXmlNode leafForKeys:[NSArray arrayWithObjects: __VA_ARGS__, nil]]

#define xmlNodeIntVal(pXmlNode, ...) \
toInt(xmlNodeStringVal(pXmlNode, __VA_ARGS__))

#define xmlNodeUIntVal(pXmlNode, ...) \
(NSUInteger)toInt(xmlNodeStringVal(pXmlNode, __VA_ARGS__))


#define xmlNodeGetSubPath(pXmlNode, ...) \
[pXmlNode objectForKeys:[NSArray arrayWithObjects: __VA_ARGS__, nil]]




FOUNDATION_EXTERN NSString* generalBodyArgs(NSString* pstrInterfaceName, ...);


#define ServerURL @"http://60.191.115.39:8080/tvlsys/TourHelperService/tourHelper"

#define BodyHead @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"><soap:Body>"
#define BodyInterfaceStringHead @"<%@ xmlns=\"http://service.travelsys.pubinfo.zj.cn/\">"
#define BodyInterfaceStringTail @"</%@>"
#define BodyArgString @"<arg%u xmlns=\"\">%@</arg%u>"
#define BodyTail @"</soap:Body></soap:Envelope>"

#define InterfaceBody(interfaceName, ...) \
[NSString stringWithFormat:@"%@%@%@", BodyHead, generalBodyArgs(interfaceName, __VA_ARGS__, nil), BodyTail]




#endif

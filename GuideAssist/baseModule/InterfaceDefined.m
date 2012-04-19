//
//  InterfaceDefined.c
//  WebServiceTest
//
//  Created by Titaro on 12-3-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "InterfaceDefined.h"

#ifdef OUT_PUT_LOG
void LogStr(NSString* pstrFormat, ...)
{
    va_list argList = nil;
    va_start(argList, pstrFormat);
    NSLogv(pstrFormat, argList);
    va_end(argList);
}
#endif

#define _validString(str) \
(str && ![str isEqualToString:[NSString string]])

BOOL validString(NSString* pstrValue)
{
    return _validString(pstrValue)?TRUE:FALSE;
}

BOOL validEquelString(NSString* pstrValue, NSString* pstrEquelValue)
{
    if (validString(pstrValue))
    {
        if ([pstrValue isEqualToString:pstrEquelValue])
        {
            return TRUE;
        }
    }
    return FALSE;
}

NSInteger _toInt(NSString* pstrInteger)
{
    if (!pstrInteger)
    {
        return 0;
    }
    else if ([pstrInteger isEqualToString:@""])
    {
        return 0;
    }
    else
    {
        return [pstrInteger integerValue];
    }
}

void _doRelease(id* pId)
{
    if (*pId)
    {
        [*pId release];
        *pId = nil;
    }
}

void _doAutoRelease(id* pId)
{
    if (*pId)
    {
        [*pId autorelease];
        *pId = nil;
    }
}

void _setMString(NSMutableString** ppstrTarget, NSString* pstrVal)
{
    if (!pstrVal)
    {
        doRelease(*ppstrTarget);
        return;
    }
    if (*ppstrTarget)
    {
        if (*ppstrTarget == pstrVal)
        {
            return;
        }
        [*ppstrTarget setString:pstrVal];
    }
    else
    {
        *ppstrTarget = [[NSMutableString alloc] initWithCapacity:0];
        [*ppstrTarget setString:pstrVal];
    }
}

void _setString(NSString** ppstrTarget, NSString* pstrVal)
{
    if (!*ppstrTarget)
    {
        if (!pstrVal)
        {
            return;
        }
        else
        {
            *ppstrTarget = [pstrVal retain];
        }
    }
    else if (pstrVal)
    {
        if ([*ppstrTarget isEqualToString:pstrVal])
        {
            return;
        }
        else
        {
            doRelease(*ppstrTarget);
            *ppstrTarget = [pstrVal retain];
        }
    }
    else
    {
        doRelease(*ppstrTarget);
    }
}



NSString* generalBodyArgs(NSString* pstrInterfaceName, ...)
{
    va_list argList;
    va_start(argList, pstrInterfaceName);
    NSString* pstrArgs = [NSString stringWithFormat:BodyInterfaceStringHead, pstrInterfaceName];
    NSUInteger uArgCount = 0;
    NSString* pstrArgValue = nil;
    while ((pstrArgValue = va_arg(argList, NSString*)))
    {
        pstrArgs = [pstrArgs stringByAppendingFormat:BodyArgString, uArgCount, pstrArgValue, uArgCount];
        uArgCount++;
    }
    va_end(argList);
    pstrArgs = [pstrArgs stringByAppendingFormat:BodyInterfaceStringTail, pstrInterfaceName];
    return pstrArgs;
}
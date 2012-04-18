//
//  IniFileManager.m
//  IniFileManager
//
//  Created by Titaro on 11-11-19.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "IniFileManager.h"
#import <COmmoncrypto/CommonHMAC.h>

#define IniStrVal(str) (str)?(str):([NSString string])


@implementation IniKeyInfo

@synthesize keyName = mpstrKeyName;
@synthesize keyValue = mpstrKeyValue;
@synthesize isNUllKeyName;
@synthesize isNullKeyValue;


- (void) dealloc
{
    self.keyName = nil;
    self.keyValue = nil;
    [super dealloc];
}

- (NSString*) getKeyName
{
    return IniStrVal(mpstrKeyName);
}

- (NSString*) getKeyValue
{
    return IniStrVal(mpstrKeyValue);
}

- (BOOL) isNullKeyName
{
    if (!mpstrKeyName)
    {
        return TRUE;
    }
    else if (![mpstrKeyName length])
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}

- (BOOL) isNullKeyValue
{
    if (!mpstrKeyValue)
    {
        return TRUE;
    }
    else if (![mpstrKeyValue length])
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}

- (NSInteger) toLong
{
    return [self toLongWithDefaultValue:0];
}

- (NSInteger) toLongWithDefaultValue:(NSInteger) iDefault
{
    if (self.isNullKeyValue)
    {
        return iDefault;
    }
    else
    {
        return [self.keyValue intValue];
    }
}

- (NSUInteger) toULong
{
    return [self toULongWithDefaultValue:0];
}

- (NSUInteger) toULongWithDefaultValue:(NSUInteger) uDefault
{
    if (self.isNullKeyValue)
    {
        return uDefault;
    }
    else
    {
        return [self.keyValue longLongValue];
    }
}

- (NSInteger) toHex
{
    return [self toHexWithDefaultValue:0];
}

- (NSInteger) toHexWithDefaultValue:(NSInteger) iDefault
{
    if (self.isNullKeyValue)
    {
        return iDefault;
    }
    else
    {
        NSScanner* pScanner = [NSScanner scannerWithString:self.keyValue];
        NSInteger iValue = 0;
        NSUInteger uValue = 0;
        if ([pScanner scanHexInt:&uValue])
        {
            return iValue = uValue;
        }
        else
        {
            return 0;
        }
    }
}

- (NSUInteger) toUHex
{
    return [self toUHexWithDefaultValue:0];
}

- (NSUInteger) toUHexWithDefaultValue:(NSUInteger) uDefault
{
    if (self.isNullKeyValue)
    {
        return uDefault;
    }
    else
    {
        NSScanner* pScanner = [NSScanner scannerWithString:self.keyValue];
        NSUInteger uValue = 0;
        if ([pScanner scanHexInt:&uValue])
        {
            return uValue;
        }
        else
        {
            return 0;
        }
    }
}

- (NSString*) toString
{
    return [self toStringWithDefaultValue:[NSString string]];
}

- (NSString*) toStringWithDefaultValue:(NSString*) pstrDefault
{
    if (self.isNullKeyValue)
    {
        return IniStrVal(pstrDefault);
    }
    else
    {
        return self.keyValue;
    }
}


- (NSString*) toMultiLineString
{
    return [self toMultiLineStringWithDefaultValue:[NSString string]];
}

- (NSString*) toMultiLineStringWithDefaultValue:(NSString*) pstrDefault
{
    if (self.isNullKeyValue)
    {
        return IniStrVal(pstrDefault);
    }
    else
    {
        return [self.keyValue stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\r\n"];
    }
}

- (CGFloat) toFloat
{
    return [self toFloatWithDefaultValue:0];
}

- (CGFloat) toFloatWithDefaultValue:(CGFloat) fDefault
{
    if (self.isNullKeyValue)
    {
        return fDefault;
    }
    else
    {
        return [self.keyValue floatValue];
    }
}

- (void) setLong:(NSInteger) iValue
{
    self.keyValue = [NSString stringWithFormat:@"%d", iValue];
}

- (void) setULong:(NSUInteger) uValue
{
    self.keyValue = [NSString stringWithFormat:@"%u", uValue];
}

- (void) setHex:(NSInteger) iValue
{
    self.keyValue = [NSString stringWithFormat:@"%X", iValue];
}

- (void) setUHex:(NSUInteger) uValue
{
    self.keyValue = [NSString stringWithFormat:@"%X", uValue];
}

- (void) setString:(NSString*) pstrValue
{
    self.keyValue = pstrValue;
}

- (void) setMultiLineString:(NSString*) pstrValue
{
    self.keyValue = [pstrValue stringByReplacingOccurrencesOfString:@"\r\n" withString:@"<br/>"];
}

- (void) setFloat:(CGFloat) fValue
{
    self.keyValue = [NSString stringWithFormat:@"%f", fValue];
}

- (NSString*) getText
{
    if (self.isNUllKeyName)
    {
        return self.keyValue;
    }
    else
    {
        return [NSString stringWithFormat:@"%@=%@", self.keyName, self.keyValue];
    }
}

- (NSString*) getTextEx
{
    if (self.isNUllKeyName)
    {
        if (self.isNullKeyValue)
        {
            return self.keyValue;
        }
        else
        {
            return [NSString stringWithFormat:@"\r\n%@", self.keyValue];
        }
    }
    else
    {
        return [NSString stringWithFormat:@"\r\n%@=%@", self.keyName, self.keyValue];
    }
}

@end

@interface IniSectionInfo (InternalMethod)

- (IniKeyInfo*) parseData:(NSString*) pstrData;

@end


@implementation IniSectionInfo

@synthesize sectionName = mpstrSectionName;


- (IniKeyInfo*) parseData:(NSString*) pstrData
{
    IniKeyInfo* pIniKeyInfo = [self addKey:nil];
    if (![pstrData length])
    {
        return pIniKeyInfo;
    }
    NSRange range = [pstrData rangeOfString:@":"];
    if (!range.location)
    {
        pIniKeyInfo.keyValue = pstrData;
        return pIniKeyInfo;
    }
    range = [pstrData rangeOfString:@"="];
    if (range.location == NSNotFound || !range.location)
    {
        pIniKeyInfo.keyValue = pstrData;
        return pIniKeyInfo;
    }
    pIniKeyInfo.keyName = [pstrData substringToIndex:range.location];
    pIniKeyInfo.keyValue = [pstrData substringFromIndex:range.location + 1];
    return pIniKeyInfo;
}

- (void) dealloc
{
    self.sectionName = nil;
    [super dealloc];
}

- (IniKeyInfo*) addKey:(NSString*) pstrKeyName
{
    IniKeyInfo* pKeyInfo = [[IniKeyInfo alloc] init];
    pKeyInfo.keyName = pstrKeyName;
    [self appendData:pKeyInfo];
    return [pKeyInfo autorelease];
}

- (IniKeyInfo*) getKey:(NSString*) pstrKeyName
{
    return [self getKey:pstrKeyName addWhenNotExist:FALSE];
}

- (IniKeyInfo*) getKey:(NSString *)pstrKeyName addWhenNotExist:(BOOL) bAdd
{
    IniKeyInfo* pKeyInfo = nil;
    LoopListNode* pNode = nil;
    NSUInteger uEnumed = 0;
    NSUInteger uTotal = self.listCount;
    for (pNode = self.current; uEnumed < uTotal; [self moveNext]) 
    {
        if (self.notHead) 
        {
            if ([[self.currentData getKeyName] isEqualToString:pstrKeyName])
            {
                return self.currentData;
            }
            uEnumed++;
        }
    }
    
//    for ([self moveBegin]; self.notHead; [self moveNext]) 
//    {
//        if ([[self.currentData getKeyName] isEqualToString:pstrKeyName])
//        {
//            return self.currentData;
//        }
//    }
    if (!pKeyInfo)
    {
        if (bAdd)
        {
            pKeyInfo = [self addKey:pstrKeyName];
        }
    }
    return pKeyInfo;
}

- (NSInteger) toLong:(NSString*) pstrKeyName
{
    return [self toLong:pstrKeyName withDefaultValue:0];
}

- (NSInteger) toLong:(NSString *) pstrKeyName withDefaultValue:(NSInteger) iDefault
{
    IniKeyInfo* pKeyInfo = [self getKey:pstrKeyName];
    if (pKeyInfo)
    {
        return [pKeyInfo toLongWithDefaultValue:iDefault];
    }
    else
    {
        return iDefault;
    }
}

- (NSUInteger) toULong:(NSString*) pstrKeyName
{
    return [self toULong:pstrKeyName withDefaultValue:0];
}

- (NSUInteger) toULong:(NSString *) pstrKeyName withDefaultValue:(NSUInteger) uDefault
{
    IniKeyInfo* pKeyInfo = [self getKey:pstrKeyName];
    if (pKeyInfo)
    {
        return [pKeyInfo toULongWithDefaultValue:uDefault];
    }
    else
    {
        return uDefault;
    }
}

- (NSInteger) toHex:(NSString*) pstrKeyName
{
    return [self toHex:pstrKeyName withDefaultValue:0];
}

- (NSInteger) toHex:(NSString *) pstrKeyName withDefaultValue:(NSInteger) iDefault
{
    IniKeyInfo* pKeyInfo = [self getKey:pstrKeyName];
    if (pKeyInfo)
    {
        return [pKeyInfo toHexWithDefaultValue:iDefault];
    }
    else
    {
        return iDefault;
    }
}

- (NSUInteger) toUHex:(NSString*) pstrKeyName
{
    return [self toUHex:pstrKeyName withDefaultValue:0];
}

- (NSUInteger) toUHex:(NSString *) pstrKeyName withDefaultValue:(NSUInteger) uDefault
{
    IniKeyInfo* pKeyInfo = [self getKey:pstrKeyName];
    if (pKeyInfo)
    {
        return [pKeyInfo toUHexWithDefaultValue:uDefault];
    }
    else
    {
        return uDefault;
    }
}

- (NSString*) toString:(NSString*) pstrKeyName
{
    return [self toString:pstrKeyName withDefaultValue:[NSString string]];
}

- (NSString*) toString:(NSString *) pstrKeyName withDefaultValue:(NSString*) pstrDefault
{
    IniKeyInfo* pKeyInfo = [self getKey:pstrKeyName];
    if (pKeyInfo)
    {
        return [pKeyInfo toStringWithDefaultValue:pstrDefault];
    }
    else
    {
        return pstrDefault;
    }
}

- (NSString*) toMultiLineString:(NSString*) pstrKeyName
{
    return [self toMultiLineString:pstrKeyName withDefaultValue:[NSString string]];
}

- (NSString*) toMultiLineString:(NSString*) pstrKeyName withDefaultValue:(NSString*) pstrDefault
{
    IniKeyInfo* pKeyInfo = [self getKey:pstrKeyName];
    if (pKeyInfo)
    {
        return [pKeyInfo toMultiLineStringWithDefaultValue:pstrDefault];
    }
    else
    {
        return pstrDefault;
    }
}

- (CGFloat) toFloat:(NSString*) pstrKeyName
{
    return [self toFloat:pstrKeyName withDefaultValue:0];
}

- (CGFloat) toFloat:(NSString *)pstrKeyName withDefaultValue:(CGFloat) fDefault
{
    IniKeyInfo* pKeyInfo = [self getKey:pstrKeyName];
    if (pKeyInfo)
    {
        return [pKeyInfo toFloatWithDefaultValue:fDefault];
    }
    else
    {
        return fDefault;
    }
}


- (void) setLong:(NSString*) pstrKeyName andValue:(NSInteger) iValue
{
    [[self getKey:pstrKeyName addWhenNotExist:TRUE] setLong:iValue];
}

- (void) setULong:(NSString*) pstrKeyName andValue:(NSUInteger) uValue
{
    [[self getKey:pstrKeyName addWhenNotExist:TRUE] setULong:uValue];
}

- (void) setHex:(NSString*) pstrKeyName andValue:(NSInteger) iValue
{
    [[self getKey:pstrKeyName addWhenNotExist:TRUE] setHex:iValue];
}

- (void) setUHex:(NSString*) pstrKeyName andValue:(NSUInteger) uValue
{
    [[self getKey:pstrKeyName addWhenNotExist:TRUE] setUHex:uValue];
}

- (void) setString:(NSString*) pstrKeyName andValue:(NSString*) pstrValue
{
    [[self getKey:pstrKeyName addWhenNotExist:TRUE] setString:pstrValue];
}

- (void) setMultiLineString:(NSString*) pstrKeyName andValue:(NSString*) pstrValue
{
    [[self getKey:pstrKeyName addWhenNotExist:TRUE] setMultiLineString:pstrValue];
}

- (void) setFloat:(NSString*) pstrKeyName andValue:(CGFloat) fValue
{
    [[self getKey:pstrKeyName addWhenNotExist:TRUE] setFloat:fValue];
}

- (NSString*) getSectionName
{
    return IniStrVal(mpstrSectionName);
}

- (BOOL) isNullSectionName
{
    if (!mpstrSectionName)
    {
        return TRUE;
    }
    else if (![mpstrSectionName length])
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }

}

- (NSString*) getText
{
    NSMutableString* pstrText = [NSMutableString stringWithCapacity:1024];
    if (self.isNullSectionName)
    {
        for ([self moveBegin]; self.notHead; [self moveNext]) 
        {
            [pstrText appendString:[self.currentData getText]];
            if (self.current != self.end)
            {
                [pstrText appendString:@"\r\n"];
            }
        }
    }
    else
    {
        [pstrText appendString:@"["];
        [pstrText appendString:self.sectionName];
        [pstrText appendString:@"]"];
        for ([self moveBegin]; self.notHead; [self moveNext])
        {
            [pstrText appendString:@"\r\n"];
            [pstrText appendString:[self.currentData getText]];
        }
    }
    return pstrText;
}

- (NSString*) getTextEx
{
    if (self.isNullSectionName)
    {
        return [NSString string];
    }
    NSMutableString* pstrText = [NSMutableString stringWithCapacity:1024];
    [pstrText appendString:@"["];
    [pstrText appendString:self.sectionName];
    [pstrText appendString:@"]"];
    for ([self moveBegin]; self.notHead; [self moveNext])
    {
        [pstrText appendString:[self.currentData getTextEx]];
    }
    return pstrText;
}

- (void) joinTo:(IniSectionInfo*) pIniSectionInfo
{
    for ([self moveBegin]; self.notHead; [self moveNext])
    {
        [pIniSectionInfo getKey:[self.currentData getKeyName] addWhenNotExist:TRUE].keyValue = [self.currentData getKeyValue];
    }
}
@end

@interface IniFileManager (InternalMethod)

- (BOOL) parseSectionName:(NSString*) pstrData withResultSectionName:(NSString**) ppstrRecultSectionName;
- (IniSectionInfo*) parseLine:(NSString*) pstrData;

@end

@implementation IniFileManager

@synthesize filename = mpstrFilename;
@synthesize fullFilePath;
@synthesize text;
@synthesize textEx;

- (void) dealloc
{
    self.filename = nil;
    [super dealloc];
}

- (BOOL) parseSectionName:(NSString*) pstrData withResultSectionName:(NSString**) ppstrRecultSectionName
{
    if (![pstrData length])
    {
        return FALSE;
    }
    if (([pstrData length] > 2) && ([pstrData characterAtIndex:0] == '[') && ([pstrData characterAtIndex:[pstrData length] - 1] == ']'))
    {
        NSRange rangeSectionName = { 1, [pstrData length] - 2 };
        *ppstrRecultSectionName = [pstrData substringWithRange:rangeSectionName];
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}

- (IniSectionInfo*) parseLine:(NSString*) pstrData
{
    NSString* pstrSectionName = nil;
    if ([self parseSectionName:pstrData withResultSectionName:&pstrSectionName])
    {
        [self getSection:pstrSectionName addWhenNotExist:TRUE];
    }
    else
    {
        if (!self.listCount)
        {
            if (!self.head.data)
            {
                self.head.data = [[[IniSectionInfo alloc] init] autorelease];
            }
        }
        [(IniSectionInfo*)self.currentData parseData:pstrData];
    }
    return self.currentData;
}

- (NSString*) getFilename
{
    NSString* pstrFullPath = self.fullFilePath;
    NSRange rangeSet = { '/', 1 };
    NSRange range = [pstrFullPath rangeOfCharacterFromSet:[NSCharacterSet characterSetWithRange:rangeSet] options:NSBackwardsSearch];
    if ((range.location == NSNotFound) || ([pstrFullPath length] <= (range.location + 1)))
    {
        return [NSString string];
    }
    else if ([pstrFullPath length] > range.location + 1)
    {
        return [pstrFullPath substringFromIndex:range.location + 1];
    }
    return [NSString string];
}

- (NSString*) getFullFilePath
{
    if (!mpstrFilename || ![mpstrFilename length])
    {
        return IniStrVal(mpstrFilename);
    }
    if ([mpstrFilename characterAtIndex:0] == '/')
    {
        return mpstrFilename;
    }
    else
    {
        return [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), mpstrFilename];
    }
}

- (NSString*) getFileDirectory
{
    NSString* pstrFullPath = self.fullFilePath;
    NSRange rangeSet = { '/', 1 };
    NSRange range = [pstrFullPath rangeOfCharacterFromSet:[NSCharacterSet characterSetWithRange:rangeSet] options:NSBackwardsSearch];
    if (range.location == NSNotFound)
    {
        return [NSString string];
    }
    else if (!range.location)
    {
        return @"/";
    }
    else
    {
        return [pstrFullPath substringToIndex:range.location];
    }
    return [NSString string];
}

+ (id) iniFileManager
{
    IniFileManager* pIniFileManager = [[IniFileManager alloc] init];
    return [pIniFileManager autorelease];
}

+ (id) parseFromFile:(NSString*) pstrFilename
{
    IniFileManager* pIniFileManager = [[IniFileManager alloc] init];
    [pIniFileManager parseFromFile:pstrFilename];
    return [pIniFileManager autorelease];
}

+ (id) parseFromData:(NSString*) pstrData
{
    IniFileManager* pIniFileManager = [[IniFileManager alloc] init];
    [pIniFileManager parseData:pstrData];
    return [pIniFileManager autorelease];
}

- (BOOL) parseFromFile:(NSString*) pstrFilename
{
    self.filename = pstrFilename;
    //检查文件是否存在
    NSFileManager* pFileManager = [NSFileManager defaultManager];
    if (![pFileManager fileExistsAtPath:self.fullFilePath])
    {
        //文件不存在，返回
        return FALSE;
    }
    //文件存在，解析
    NSString* pstrData = [NSString stringWithContentsOfFile:self.fullFilePath encoding:NSUTF8StringEncoding error:nil];
    BOOL bRet = [self parseData:pstrData];
    return bRet;
}

- (void) getSpliterRange:(NSRange*) range withString:(NSString*) pstrData
{
    unichar uch = [pstrData characterAtIndex:range->location];
    if (uch == '\r')
    {
        if (range->location + 1 < [pstrData length])
        {
            if ([pstrData characterAtIndex:range->location + 1] == '\n')
            {
                range->length = 2;
            }
        }
    }
}

- (BOOL) parseData:(NSString*) pstrData
{
    if (!pstrData)
    {
        return FALSE;
    }
    if ([pstrData isEqualToString:[NSString string]])
    {
        return TRUE;
    }
    else
    {
        [self clearList];
        NSRange findRange = { 0, [pstrData length] };
        NSRange lastRange = { 0, [pstrData length] };
        NSRange subRange = { 0, [pstrData length] };

        NSString* pstrLine = nil;
        NSCharacterSet* pCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"\r\n"];
        while (TRUE) 
        {
            lastRange = [pstrData rangeOfCharacterFromSet:pCharacterSet options:0 range:findRange];
            if (lastRange.location == NSNotFound)
            {
                pstrLine = [pstrData substringFromIndex:findRange.location];
                [self parseLine:pstrLine];
                return TRUE;
            }
            else
            {
                [self getSpliterRange:&lastRange withString:pstrData];
                subRange.location = findRange.location;
                subRange.length = lastRange.location - findRange.location;
                pstrLine = [pstrData substringWithRange:subRange];
                [self parseLine:pstrLine];
                findRange.location += (lastRange.length + [pstrLine length]);
                findRange.length = [pstrData length] - findRange.location;
            }
        }
        return TRUE;
    }
}


- (IniSectionInfo*) addSection:(NSString*) pstrSectionName
{
    IniSectionInfo* pSection = [[[IniSectionInfo alloc] init] autorelease];
    pSection.sectionName = pstrSectionName;
    self.current = [self appendData:pSection];
    return pSection;
}

- (IniSectionInfo*) getSection:(NSString*) pstrSectionName
{
    return [self getSection:pstrSectionName addWhenNotExist:FALSE];
}

- (IniSectionInfo*) getSection:(NSString *)pstrSectionName addWhenNotExist:(BOOL) bAdd
{
    IniSectionInfo* pSectionInfo = nil;
    for ([self moveBegin]; self.notHead; [self moveNext]) 
    {
        if ([[self.currentData getSectionName] isEqualToString:IniStrVal(pstrSectionName)])
        {
            return self.currentData;
        }
    }
    if (!pSectionInfo)
    {
        if (bAdd)
        {
            pSectionInfo = [self addSection:pstrSectionName];
        }
    }
    return pSectionInfo;
}



- (BOOL) saveFile
{
    return [self saveFileWithFilename:self.fullFilePath];
}

- (NSString*) getFullFilePath:(NSString*) pstrFilename
{
    if (!pstrFilename || ![pstrFilename length])
    {
        return IniStrVal(pstrFilename);
    }
    if ([pstrFilename characterAtIndex:0] == '/')
    {
        return pstrFilename;
    }
    else
    {
        return [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), pstrFilename];
    }
}

- (BOOL) saveFileWithFilename:(NSString*) pstrFilename
{
    NSFileManager* pFileManager = [NSFileManager defaultManager];
    NSString* pstrFileFullPath = [self getFullFilePath:pstrFilename];
    NSString* pstrFileDirectory = [pstrFileFullPath directory];
    //NSLog(@"%@", pstrFileFullPath);
    //NSLog(@"%@", self.filename);
    //检查文件目录是否存在，如果不存在则创建相关目录
    BOOL bIsDirectory = FALSE;
    if (![pFileManager fileExistsAtPath:pstrFileDirectory isDirectory:&bIsDirectory])
    {
        //目录不存在，创建目录
        [pFileManager createDirectoryAtPath:pstrFileDirectory withIntermediateDirectories:TRUE attributes:nil error:nil];
    }
    else if (!bIsDirectory)
    {
        //存在同路径的同名文件，无法创建目录
        return FALSE;
    }
    if ([pFileManager fileExistsAtPath:pstrFileFullPath])
    {
        //删除原有文件
        [pFileManager removeItemAtPath:pstrFileFullPath error:nil];
    }
    char chHead[3] = { 0xEF, 0xBB, 0xBF };
    FILE* pFile = fopen([pstrFileFullPath UTF8String], "w+");
    if (!pFile)
    {
        return FALSE;
    }
    //写入头
    fseek(pFile, 0, SEEK_END);
    fwrite(chHead, sizeof(chHead), 1, pFile);
    //写入内容
    NSData* pData = [self.text dataUsingEncoding:NSUTF8StringEncoding];
    fwrite(pData.bytes, [pData length], 1, pFile);
    fclose(pFile);
    return TRUE;
}

- (BOOL) saveFileEx
{
    return [self saveFileExWithFilename:self.fullFilePath];
}

- (BOOL) saveFileExWithFilename:(NSString*) pstrFilename
{
    NSFileManager* pFileManager = [NSFileManager defaultManager];
    NSString* pstrFilePath = [self getFullFilePath:pstrFilename];
    NSString* pstrFileDirectory = [pstrFilePath directory];

    //检查文件目录是否存在，如果不存在则创建相关目录
    BOOL bIsDirectory = FALSE;
    if (![pFileManager fileExistsAtPath:pstrFileDirectory isDirectory:&bIsDirectory])
    {
        //目录不存在，创建目录
        [pFileManager createDirectoryAtPath:pstrFileDirectory withIntermediateDirectories:TRUE attributes:nil error:nil];
    }
    else if (!bIsDirectory)
    {
        //存在同路径的同名文件，无法创建目录
        return FALSE;
    }

    if ([pFileManager fileExistsAtPath:pstrFilePath])
    {
        //删除原有文件
        [pFileManager removeItemAtPath:pstrFilePath error:nil];
    }
    char chHead[3] = { 0xEF, 0xBB, 0xBF };
    FILE* pFile = fopen([pstrFilePath UTF8String], "w+");
    if (!pFile)
    {
        return FALSE;
    }
    //写入头
    fseek(pFile, 0, SEEK_END);
    fwrite(chHead, sizeof(chHead), 1, pFile);
    //写入内容
    NSData* pData = [self.textEx dataUsingEncoding:NSUTF8StringEncoding];
    fwrite(pData.bytes, [pData length], 1, pFile);
    fclose(pFile);
    return TRUE;
}

- (NSInteger) toLong:(NSString*) pstrSectionName withKeyName:(NSString*) pstrKeyName
{
    return [self toLong:pstrSectionName withKeyName:pstrKeyName withDefaultValue:0];
}

- (NSInteger) toLong:(NSString *) pstrSectionName withKeyName:(NSString *)pstrKeyName withDefaultValue:(NSInteger) iDefault
{
    IniSectionInfo* pSectionInfo = [self getSection:pstrSectionName];
    if (pSectionInfo)
    {
        return [pSectionInfo toLong:pstrKeyName withDefaultValue:iDefault];
    }
    else
    {
        return iDefault;
    }
}

- (NSUInteger) toULong:(NSString*) pstrSectionName withKeyName:(NSString*) pstrKeyName
{
    return [self toULong:pstrSectionName withKeyName:pstrKeyName withDefaultValue:0];
}

- (NSUInteger) toULong:(NSString *)pstrSectionName withKeyName:(NSString *)pstrKeyName withDefaultValue:(NSUInteger) uDefault
{
    IniSectionInfo* pSectionInfo = [self getSection:pstrSectionName];
    if (pSectionInfo)
    {
        return [pSectionInfo toULong:pstrKeyName withDefaultValue:uDefault];
    }
    else
    {
        return uDefault;
    }
}

- (NSInteger) toHex:(NSString*) pstrSectionName withKeyName:(NSString*) pstrKeyName
{
    return [self toHex:pstrSectionName withKeyName:pstrKeyName withDefaultValue:0];
}

- (NSInteger) toHex:(NSString *) pstrSectionName withKeyName:(NSString *)pstrKeyName withDefaultValue:(NSInteger) iDefault
{
    IniSectionInfo* pSectionInfo = [self getSection:pstrSectionName];
    if (pSectionInfo)
    {
        return [pSectionInfo toHex:pstrKeyName withDefaultValue:iDefault];
    }    
    else
    {
        return iDefault;
    }
}

- (NSUInteger) toUHex:(NSString*) pstrSectionName withKeyName:(NSString*) pstrKeyName
{
    return [self toUHex:pstrSectionName withKeyName:pstrKeyName withDefaultValue:0];
}

- (NSUInteger) toUHex:(NSString *) pstrSectionName withKeyName:(NSString *)pstrKeyName withDefaultValue:(NSUInteger) uDefault
{
    IniSectionInfo* pSectionInfo = [self getSection:pstrSectionName];
    if (pSectionInfo)
    {
        return [pSectionInfo toUHex:pstrKeyName withDefaultValue:uDefault];
    }
    else
    {
        return uDefault;
    }
}

- (NSString*) toString:(NSString*) pstrSectionName withKeyName:(NSString*) pstrKeyName
{
    return [self toString:pstrSectionName withKeyName:pstrKeyName withDefaultValue:[NSString string]];
}

- (NSString*) toString:(NSString *) pstrSectionName withKeyName:(NSString *)pstrKeyName withDefaultValue:(NSString*) pstrDefault
{
    IniSectionInfo* pSectionInfo = [self getSection:pstrSectionName];
    if (pSectionInfo)
    {
        return [pSectionInfo toString:pstrKeyName withDefaultValue:pstrDefault];
    }
    else
    {
        return pstrDefault;
    }
}

- (NSString*) toMultiLineString:(NSString*) pstrSectionName withKeyName:(NSString*) pstrKeyName
{
    return [self toMultiLineString:pstrSectionName withKeyName:pstrKeyName withDefaultValue:[NSString string]];
}

- (NSString*) toMultiLineString:(NSString *) pstrSectionName withKeyName:(NSString *)pstrKeyName withDefaultValue:(NSString*) pstrDefault
{
    IniSectionInfo* pSectionInfo = [self getSection:pstrSectionName];
    if (pSectionInfo)
    {
        return [pSectionInfo toMultiLineString:pstrKeyName withDefaultValue:pstrDefault];
    }
    else
    {
        return pstrDefault;
    }
}

- (CGFloat) toFloat:(NSString*) pstrSectionName withKeyName:(NSString*) pstrKeyName
{
    return [self toFloat:pstrSectionName withKeyName:pstrKeyName withDefaultValue:0];
}

- (CGFloat) toFloat:(NSString*) pstrSectionName withKeyName:(NSString*) pstrKeyName withDefaultValue:(CGFloat) fDefault
{
    IniSectionInfo* pSectionInfo = [self getSection:pstrSectionName];
    if (pSectionInfo)
    {
        return [pSectionInfo toFloat:pstrKeyName withDefaultValue:fDefault];
    }
    else
    {
        return fDefault;
    }
}

- (void) setLong:(NSString*) pstrSectionName withKeyName:(NSString*) pstrKeyName andValue:(NSInteger) iValue
{
    [[self getSection:pstrSectionName addWhenNotExist:TRUE] setLong:pstrKeyName andValue:iValue];
}

- (void) setULong:(NSString*) pstrSectionName withKeyName:(NSString*) pstrKeyName andValue:(NSUInteger) uValue
{
    [[self getSection:pstrSectionName addWhenNotExist:TRUE] setULong:pstrKeyName andValue:uValue];
}

- (void) setHex:(NSString*) pstrSectionName withKeyName:(NSString*) pstrKeyName andValue:(NSInteger) iValue
{
    [[self getSection:pstrSectionName addWhenNotExist:TRUE] setHex:pstrKeyName andValue:iValue];
}

- (void) setUHex:(NSString*) pstrSectionName withKeyName:(NSString*) pstrKeyName andValue:(NSUInteger) uValue
{
    [[self getSection:pstrSectionName addWhenNotExist:TRUE] setUHex:pstrKeyName andValue:uValue];
}

- (void) setString:(NSString*) pstrSectionName withKeyName:(NSString*) pstrKeyName andValue:(NSString*) pstrValue
{
    [[self getSection:pstrSectionName addWhenNotExist:TRUE] setString:pstrKeyName andValue:pstrValue];
}

- (void) setMultiLineString:(NSString*) pstrSectionName withKeyName:(NSString*) pstrKeyName andValue:(NSString*) pstrValue
{
    [[self getSection:pstrSectionName addWhenNotExist:TRUE] setMultiLineString:pstrKeyName andValue:pstrValue];
}

- (void) setFloat:(NSString*) pstrSectionName withKeyName:(NSString*) pstrKeyName andValue:(CGFloat) fValue
{
    [[self getSection:pstrSectionName addWhenNotExist:TRUE] setFloat:pstrKeyName andValue:fValue];
}

- (NSString*) getText
{
    NSMutableString* pstrText = (NSMutableString*)[self.head.data getText];
    if (!pstrText)
    {
        pstrText = [NSMutableString stringWithCapacity:1024];
    }
    if (![pstrText length])
    {
        [self moveBegin];
        if (self.notHead)
        {
            [pstrText appendString:[self.currentData getText]];
        }
        else
        {
            return pstrText;
        }
        while (![pstrText length]) 
        {
            [self moveNext];
            if (self.notHead)
            {
                [pstrText appendString:[self.currentData getText]];
            }
            else
            {
                return pstrText;
            }
        }
        for ([self moveNext]; self.notHead; [self moveNext]) 
        {
            if (![[pstrText rightString:2] isEqualToString:@"\r\n"])
            {
                [pstrText appendString:@"\r\n\r\n"];                
            }
            else
            {
                [pstrText appendFormat:@"\r\n"];
            }
            [pstrText appendString:[self.currentData getText]];
        }
    }
    else
    {
        for ([self moveBegin]; self.notHead; [self moveNext]) 
        {
            if (![[pstrText rightString:2] isEqualToString:@"\r\n"])
            {
                [pstrText appendString:@"\r\n\r\n"];                
            }
            else
            {
                [pstrText appendFormat:@"\r\n"];
            }
            [pstrText appendString:[self.currentData getText]];
        }
    }
    return pstrText;
}

- (NSString*) getTextEx
{
    NSMutableString* pstrText = [NSMutableString stringWithCapacity:1024];
    [self moveBegin];
    if (self.notHead)
    {
        [pstrText appendString:[self.currentData getTextEx]];
    }
    else
    {
        return pstrText;
    }
    while (![pstrText length]) 
    {
        [self moveNext];
        if (self.notHead)
        {
            [pstrText appendString:[self.currentData getTextEx]];
        }
        else
        {
            return pstrText;
        }
    }
    for ([self moveNext]; self.notHead; [self moveNext]) 
    {
        [pstrText appendString:@"\r\n\r\n"];
        [pstrText appendString:[self.currentData getTextEx]];
    }
    return pstrText;
}

- (void) joinTo:(IniFileManager*) pIniFileManager
{
    for ([self moveBegin]; self.notHead; [self moveNext])
    {
        [self.currentData joinTo:[pIniFileManager getSection:[self.currentData getSectionName] addWhenNotExist:TRUE]]; 
    }
}

@end


@implementation NSString (SubStringOperator)

- (NSString*) leftString:(NSUInteger) uLength
{
    if (![self length])
    {
        return [NSString string];
    }
    if (uLength > [self length])
    {
        uLength = [self length];
    }
    return [self substringToIndex:uLength];
}

- (NSString*) rightString:(NSUInteger) uLength
{
    if (![self length])
    {
        return [NSString string];
    }
    if (uLength > [self length])
    {
        uLength = [self length];
    }
    NSRange range = { [self length] - uLength, uLength };
    return [self substringWithRange:range];
}

- (NSString*) midString:(NSUInteger) uStart
{
    if (![self length])
    {
        return [NSString string];
    }
    if (uStart >= [self length])
    {
        return [NSString string];
    }
    return [self substringFromIndex:uStart];
}

- (NSString*) midString:(NSUInteger)uStart withLength:(NSUInteger) uLength
{
    if (![self length])
    {
        return [NSString string];
    }
    if (uStart >= [self length])
    {
        return [NSString string];
    }
    if (uStart + uLength > [self length])
    {
        uLength = [self length] - uStart;
    }
    NSRange range = { uStart, uLength };
    return [self substringWithRange:range];
}

- (NSUInteger) findString:(NSString*) pstrFind
{
    return [self findString:pstrFind withStartLocation:0];
}

- (NSUInteger) findString:(NSString *)pstrFind withStartLocation:(NSUInteger) uStart
{
    return [self findString:pstrFind withStartLocation:uStart witCompareNoCase:FALSE];
}

- (NSUInteger) findString:(NSString *)pstrFind withStartLocation:(NSUInteger) uStart witCompareNoCase:(BOOL) bNoCase
{
    if (![self length] || ![pstrFind length])
    {
        return NSNotFound;
    }
    if (uStart >= [self length])
    {
        return NSNotFound;
    }
    if ((uStart + [pstrFind length]) > [self length])
    {
        return NSNotFound;
    }
    NSRange range = { uStart, [self length] - uStart };
    return [self rangeOfString:pstrFind options:bNoCase?NSCaseInsensitiveSearch:0 range:range].location;
}

- (NSUInteger) findStringReverse:(NSString*) pstrFind
{
    return [self findStringReverse:pstrFind withStartLocationReverse:0];
}

- (NSUInteger) findStringReverse:(NSString *)pstrFind withStartLocationReverse:(NSUInteger) uStartReverse
{
    return [self findStringReverse:pstrFind withStartLocationReverse:uStartReverse withCompareNoCase:FALSE];
}

- (NSUInteger) findStringReverse:(NSString *)pstrFind withStartLocationReverse:(NSUInteger) uStartReverse withCompareNoCase:(BOOL) bNoCase
{
    if (![self length] || ![pstrFind length])
    {
        return NSNotFound;
    }
    if (uStartReverse >= [self length])
    {
        return NSNotFound;
    }
    if ((uStartReverse + [pstrFind length]) > [self length])
    {
        return NSNotFound;
    }
    NSRange range = { 0, [self length] - uStartReverse };
    return [self rangeOfString:pstrFind options:bNoCase?NSBackwardsSearch|NSCaseInsensitiveSearch:NSBackwardsSearch range:range].location;
}

- (NSUInteger) findCharacter:(unichar) uChar
{
    return [self findCharacter:uChar withStartLocation:0];
}

- (NSUInteger) findCharacter:(unichar)uChar withStartLocation:(NSUInteger) uStart
{
    return [self findCharacter:uChar withStartLocation:uStart withCompareNoCase:FALSE];
}

- (NSUInteger) findCharacter:(unichar)uChar withStartLocation:(NSUInteger) uStart withCompareNoCase:(BOOL) bNoCase
{
    return [self findString:[NSString stringWithCharacters:&uChar length:1] withStartLocation:uStart witCompareNoCase:bNoCase];    
}

- (NSUInteger) findCharacterReverse:(unichar)uChar
{
    return [self findCharacterReverse:uChar withStartLocationReverse:0];
}

- (NSUInteger) findCharacterReverse:(unichar)uChar withStartLocationReverse:(NSUInteger) uStartReverse
{
    return [self findCharacterReverse:uChar withStartLocationReverse:uStartReverse withCompareNoCase:FALSE];
}

- (NSUInteger) findCharacterReverse:(unichar)uChar withStartLocationReverse:(NSUInteger) uStartReverse withCompareNoCase:(BOOL) bNoCase
{
    return [self findStringReverse:[NSString stringWithCharacters:&uChar length:1] withStartLocationReverse:uStartReverse withCompareNoCase:bNoCase];    
}

- (NSComparisonResult) timeCompare:(NSString*) pstrTime
{
    NSDateFormatter* pFormater = [[NSDateFormatter alloc] init];
    [pFormater setLocale:[NSLocale currentLocale]];
    [pFormater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* pTargetDate = [pFormater dateFromString:pstrTime];
    NSDate* pSelfDate = [pFormater dateFromString:self];
    return [pSelfDate compare:pTargetDate];
}

- (NSString*) filename
{
    NSUInteger uIndex = [self findCharacterReverse:'/'];
    if (uIndex != NSNotFound)
    {
        return [self rightString:self.length - uIndex - 1];
    }
    else
    {
        return nil;
    }
}

- (NSString*) filenamePrefix
{
    NSString* pstrFilename = [self filename];
    if (!pstrFilename)
    {
        return nil;
    }
    NSUInteger uIndex = [pstrFilename findCharacter:'.'];
    if (uIndex != NSNotFound)
    {
        return [pstrFilename leftString:uIndex];
    }
    else
    {
        return pstrFilename;
    }
}

- (NSString*) filenamePrefixWithDot
{
    NSString* pstrFilename = [self filename];
    if (!pstrFilename)
    {
        return nil;
    }
    NSUInteger uIndex = [pstrFilename findCharacter:'.'];
    if (uIndex != NSNotFound)
    {
        return [pstrFilename leftString:uIndex + 1];
    }
    else
    {
        return pstrFilename;
    }
}

- (NSString*) filenameSuffix
{
    NSString* pstrFilename = [self filename];
    if (!pstrFilename)
    {
        return nil;
    }
    NSUInteger uIndex = [pstrFilename findCharacter:'.'];
    if (uIndex != NSNotFound)
    {
        return [pstrFilename rightString:pstrFilename.length - uIndex - 1];
    }
    else
    {
        return pstrFilename;
    }
}

- (NSString*) filenameSuffixWithDot
{
    NSString* pstrFilename = [self filename];
    if (!pstrFilename)
    {
        return nil;
    }
    NSUInteger uIndex = [pstrFilename findCharacter:'.'];
    if (uIndex != NSNotFound)
    {
        return [pstrFilename rightString:pstrFilename.length - uIndex];
    }
    else
    {
        return pstrFilename;
    }
}

- (NSString*) directory
{
    //NSLog(@"%@", self);
    NSUInteger uIndex = [self findCharacterReverse:'/'];
    if (uIndex != NSNotFound)
    {
        return [self leftString:uIndex];      
    }
    else
    {
        return nil;
    }
}

- (BOOL) createDirectory
{
    NSFileManager* pFileManager = [NSFileManager defaultManager];
    return [pFileManager createDirectoryAtPath:self withIntermediateDirectories:TRUE attributes:nil error:nil];
}

- (BOOL) isDirectory
{
    NSFileManager* pFileManager = [NSFileManager defaultManager];
    BOOL bRet = FALSE;
    [pFileManager fileExistsAtPath:self isDirectory:&bRet];
    return bRet;
}



- (BOOL) isPathExist
{
    return [self isPathExist:FALSE];
}

- (BOOL) isPathExist:(BOOL) bAddOrDelete
{
    NSFileManager* pFileManager = [NSFileManager defaultManager];
    BOOL bIsDir = FALSE;
    BOOL bFind = [pFileManager fileExistsAtPath:self isDirectory:&bIsDir];
    if (bAddOrDelete)
    {
        if (!bFind)
        {
            //只创建路径，不创建文件
            if (bIsDir)
            {
                [pFileManager createDirectoryAtPath:self withIntermediateDirectories:TRUE attributes:nil error:nil];
            }
        }
        else
        {
            //找到了，需要反向操作，删除
            [pFileManager removeItemAtPath:self error:nil];
        }
    }
    return bFind;
}

- (BOOL) isPathExistWithAdd
{
    NSFileManager* pFileManager = [NSFileManager defaultManager];
    BOOL bFind = [pFileManager fileExistsAtPath:self];
    if (!bFind)
    {
        [pFileManager createDirectoryAtPath:self withIntermediateDirectories:TRUE attributes:nil error:nil];
    }
    return bFind;
}

- (BOOL) isPathExistWithDelete
{
    NSFileManager* pFileManager = [NSFileManager defaultManager];
    BOOL bFind = [pFileManager fileExistsAtPath:self];
    if (bFind)
    {
        [pFileManager removeItemAtPath:self error:nil];
    }
    return TRUE;
}


- (BOOL) deletePath
{
    NSFileManager* pFileManager = [NSFileManager defaultManager];
    return [pFileManager removeItemAtPath:self error:nil];
}

- (BOOL) rename:(NSString*) pstrNewName
{
    NSFileManager* pFileManager = [NSFileManager defaultManager];
    return [pFileManager moveItemAtPath:self toPath:pstrNewName error:nil];
}

-(NSString *) md5String

{
    
    const char *original_str = [self UTF8String];
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(original_str, strlen(original_str), result);
    
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2],
            result[3], result[4], result[5],
            result[6], result[7], result[8],
            result[9], result[10], result[11],
            result[12], result[13], result[14],
            result[15]];
    
}

@end

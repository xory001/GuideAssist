//
//  IniFileManager.h
//  IniFileManager
//
//  Created by Titaro on 11-11-19.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoopList.h"

@interface IniKeyInfo : NSObject 
{
    NSString* mpstrKeyName;
    NSString* mpstrKeyValue;
}

@property (nonatomic, retain, getter = getKeyName) NSString* keyName;
@property (nonatomic, retain, getter = getKeyValue) NSString* keyValue;
@property (nonatomic, readonly, getter = isNullKeyName) BOOL isNUllKeyName;
@property (nonatomic, readonly, getter = isNullKeyValue) BOOL isNullKeyValue;
@property (nonatomic, readonly, getter = getText) NSString* text;
@property (nonatomic, readonly, getter = getTextEx) NSString* textEx;

- (NSInteger) toLong;
- (NSInteger) toLongWithDefaultValue:(NSInteger) iDefault;
- (NSUInteger) toULong;
- (NSUInteger) toULongWithDefaultValue:(NSUInteger) uDefault;
- (NSInteger) toHex;
- (NSInteger) toHexWithDefaultValue:(NSInteger) iDefault;
- (NSUInteger) toUHex;
- (NSUInteger) toUHexWithDefaultValue:(NSUInteger) uDefault;
- (NSString*) toString;
- (NSString*) toStringWithDefaultValue:(NSString*) pstrDefault;
- (NSString*) toMultiLineString;
- (NSString*) toMultiLineStringWithDefaultValue:(NSString*) pstrDefault;
- (CGFloat) toFloat;
- (CGFloat) toFloatWithDefaultValue:(CGFloat) fDefault;

- (void) setLong:(NSInteger) iValue;
- (void) setULong:(NSUInteger) uValue;
- (void) setHex:(NSInteger) iValue;
- (void) setUHex:(NSUInteger) uValue;
- (void) setString:(NSString*) pstrValue;
- (void) setMultiLineString:(NSString*) pstrValue;
- (void) setFloat:(CGFloat) fValue;

- (NSString*) getText;
- (NSString*) getTextEx;

@end

@interface IniSectionInfo : LoopList
{
    NSString* mpstrSectionName;
}

@property (nonatomic, retain, getter = getSectionName) NSString* sectionName;
@property (nonatomic, readonly, getter = isNullSectionName) BOOL isNullSectionName;
@property (nonatomic, readonly, getter = getText) NSString* text;
@property (nonatomic, readonly, getter = getTextEx) NSString* textEx;

- (IniKeyInfo*) addKey:(NSString*) pstrKeyName;
- (IniKeyInfo*) getKey:(NSString*) pstrKeyName;
- (IniKeyInfo*) getKey:(NSString *)pstrKeyName addWhenNotExist:(BOOL) bAdd;

- (NSInteger) toLong:(NSString*) pstrKeyName;
- (NSInteger) toLong:(NSString *) pstrKeyName withDefaultValue:(NSInteger) iDefault;
- (NSUInteger) toULong:(NSString*) pstrKeyName;
- (NSUInteger) toULong:(NSString *) pstrKeyName withDefaultValue:(NSUInteger) uDefault;
- (NSInteger) toHex:(NSString*) pstrKeyName;
- (NSInteger) toHex:(NSString *) pstrKeyName withDefaultValue:(NSInteger) iDefault;
- (NSUInteger) toUHex:(NSString*) pstrKeyName;
- (NSUInteger) toUHex:(NSString *) pstrKeyName withDefaultValue:(NSUInteger) uDefault;
- (NSString*) toString:(NSString*) pstrKeyName;
- (NSString*) toString:(NSString *) pstrKeyName withDefaultValue:(NSString*) pstrDefault;
- (NSString*) toMultiLineString:(NSString*) pstrKeyName;
- (NSString*) toMultiLineString:(NSString*) pstrKeyName withDefaultValue:(NSString*) pstrDefault;
- (CGFloat) toFloat:(NSString*) pstrKeyName;
- (CGFloat) toFloat:(NSString *)pstrKeyName withDefaultValue:(CGFloat) fDefault;

- (void) setLong:(NSString*) pstrKeyName andValue:(NSInteger) iValue;
- (void) setULong:(NSString*) pstrKeyName andValue:(NSUInteger) uValue;
- (void) setHex:(NSString*) pstrKeyName andValue:(NSInteger) iValue;
- (void) setUHex:(NSString*) pstrKeyName andValue:(NSUInteger) uValue;
- (void) setString:(NSString*) pstrKeyName andValue:(NSString*) pstrValue;
- (void) setMultiLineString:(NSString*) pstrKeyName andValue:(NSString*) pstrValue;
- (void) setFloat:(NSString*) pstrKeyName andValue:(CGFloat) fValue;

- (NSString*) getText;
- (NSString*) getTextEx;

- (void) joinTo:(IniSectionInfo*) pIniSectionInfo;
@end

@interface IniFileManager : LoopList
{
    NSString* mpstrFilename;
}

@property (nonatomic, retain, getter = getFilename) NSString* filename;
@property (nonatomic, readonly, getter = getFullFilePath) NSString* fullFilePath;
@property (nonatomic, readonly, getter = getFileDirectory) NSString* fileDirectory;
@property (nonatomic, readonly, getter = getText) NSString* text;
@property (nonatomic, readonly, getter = getTextEx) NSString* textEx;

+ (id) iniFileManager;
+ (id) parseFromFile:(NSString*) pstrFilename;
+ (id) parseFromData:(NSString*) pstrData;

- (BOOL) parseFromFile:(NSString*) pstrFilename;
- (BOOL) parseData:(NSString*) pstrData;


- (IniSectionInfo*) addSection:(NSString*) pstrSectionName;
- (IniSectionInfo*) getSection:(NSString*) pstrSectionName;
- (IniSectionInfo*) getSection:(NSString *)pstrSectionName addWhenNotExist:(BOOL) bAdd;

- (BOOL) saveFile;
- (BOOL) saveFileWithFilename:(NSString*) pstrFilename;
- (BOOL) saveFileEx;
- (BOOL) saveFileExWithFilename:(NSString*) pstrFilename;

- (NSInteger) toLong:(NSString*) pstrSectionName withKeyName:(NSString*) pstrKeyName;
- (NSInteger) toLong:(NSString *) pstrSectionName withKeyName:(NSString *)pstrKeyName withDefaultValue:(NSInteger) iDefault;
- (NSUInteger) toULong:(NSString*) pstrSectionName withKeyName:(NSString*) pstrKeyName;
- (NSUInteger) toULong:(NSString *)pstrSectionName withKeyName:(NSString *)pstrKeyName withDefaultValue:(NSUInteger) uDefault;
- (NSInteger) toHex:(NSString*) pstrSectionName withKeyName:(NSString*) pstrKeyName;
- (NSInteger) toHex:(NSString *) pstrSectionName withKeyName:(NSString *)pstrKeyName withDefaultValue:(NSInteger) iDefault;
- (NSUInteger) toUHex:(NSString*) pstrSectionName withKeyName:(NSString*) pstrKeyName;
- (NSUInteger) toUHex:(NSString *) pstrSectionName withKeyName:(NSString *)pstrKeyName withDefaultValue:(NSUInteger) uDefault;
- (NSString*) toString:(NSString*) pstrSectionName withKeyName:(NSString*) pstrKeyName;
- (NSString*) toString:(NSString *) pstrSectionName withKeyName:(NSString *)pstrKeyName withDefaultValue:(NSString*) pstrDefault;
- (NSString*) toMultiLineString:(NSString*) pstrSectionName withKeyName:(NSString*) pstrKeyName;
- (NSString*) toMultiLineString:(NSString *) pstrSectionName withKeyName:(NSString *)pstrKeyName withDefaultValue:(NSString*) pstrDefault;
- (CGFloat) toFloat:(NSString*) pstrSectionName withKeyName:(NSString*) pstrKeyName;
- (CGFloat) toFloat:(NSString*) pstrSectionName withKeyName:(NSString*) pstrKeyName withDefaultValue:(CGFloat) fDefault;

- (void) setLong:(NSString*) pstrSectionName withKeyName:(NSString*) pstrKeyName andValue:(NSInteger) iValue;
- (void) setULong:(NSString*) pstrSectionName withKeyName:(NSString*) pstrKeyName andValue:(NSUInteger) uValue;
- (void) setHex:(NSString*) pstrSectionName withKeyName:(NSString*) pstrKeyName andValue:(NSInteger) iValue;
- (void) setUHex:(NSString*) pstrSectionName withKeyName:(NSString*) pstrKeyName andValue:(NSUInteger) uValue;
- (void) setString:(NSString*) pstrSectionName withKeyName:(NSString*) pstrKeyName andValue:(NSString*) pstrValue;
- (void) setMultiLineString:(NSString*) pstrSectionName withKeyName:(NSString*) pstrKeyName andValue:(NSString*) pstrValue;
- (void) setFloat:(NSString*) pstrSectionName withKeyName:(NSString*) pstrKeyName andValue:(CGFloat) fValue;

- (NSString*) getText;
- (NSString*) getTextEx;

- (void) joinTo:(IniFileManager*) pIniFileManager;


@end

@interface NSString (SubStringOperator) 

- (NSString*) leftString:(NSUInteger) uLength;
- (NSString*) rightString:(NSUInteger) uLength;
- (NSString*) midString:(NSUInteger) uStart;
- (NSString*) midString:(NSUInteger)uStart withLength:(NSUInteger) uLength;

- (NSUInteger) findString:(NSString*) pstrFind;
- (NSUInteger) findString:(NSString *)pstrFind withStartLocation:(NSUInteger) uStart;
- (NSUInteger) findString:(NSString *)pstrFind withStartLocation:(NSUInteger) uStart witCompareNoCase:(BOOL) bNoCase;

- (NSUInteger) findStringReverse:(NSString*) pstrFind;
- (NSUInteger) findStringReverse:(NSString *)pstrFind withStartLocationReverse:(NSUInteger) uStartReverse;
- (NSUInteger) findStringReverse:(NSString *)pstrFind withStartLocationReverse:(NSUInteger) uStartReverse withCompareNoCase:(BOOL) bNoCase;

- (NSUInteger) findCharacter:(unichar) uChar;
- (NSUInteger) findCharacter:(unichar)uChar withStartLocation:(NSUInteger) uStart;
- (NSUInteger) findCharacter:(unichar)uChar withStartLocation:(NSUInteger) uStart withCompareNoCase:(BOOL) bNoCase;
- (NSUInteger) findCharacterReverse:(unichar)uChar;
- (NSUInteger) findCharacterReverse:(unichar)uChar withStartLocationReverse:(NSUInteger) uStartReverse;
- (NSUInteger) findCharacterReverse:(unichar)uChar withStartLocationReverse:(NSUInteger) uStartReverse withCompareNoCase:(BOOL) bNoCase;

- (NSComparisonResult) timeCompare:(NSString*) pstrTime;

- (NSString*) filename;
- (NSString*) filenamePrefix;
- (NSString*) filenamePrefixWithDot;
- (NSString*) filenameSuffix;
- (NSString*) filenameSuffixWithDot;
- (NSString*) directory;
- (BOOL) createDirectory;
- (BOOL) isDirectory;
- (BOOL) isPathExist;
- (BOOL) isPathExist:(BOOL) bAddOrDelete;
- (BOOL) isPathExistWithAdd;
- (BOOL) isPathExistWithDelete;
- (BOOL) deletePath;
- (BOOL) rename:(NSString*) pstrNewName;

-(NSString *) md5String;
@end

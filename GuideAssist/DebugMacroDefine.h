//
//  DebugMacroDefind.h
//  GuideAssist
//
//  Created by 朱 起伟 on 11-8-28.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#ifndef DebugMacroDefind_H
#define DebugMacroDefind_H

#ifdef TARGET_IPHONE_SIMULATOR
#define Log(...) NSLog(__VA_ARGS__)
#else
#define Log(...) {}

#endif

#endif
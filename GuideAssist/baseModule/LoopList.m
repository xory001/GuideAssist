//
//  LoopList.m
//  LoveFilm
//
//  Created by Titaro on 11-10-17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "LoopList.h"

@implementation LoopListNode

@synthesize data = mpData;
@synthesize prev = mpPrev;
@synthesize next = mpNext;


- (id) init
{
    self = [super init];
    if (self)
    {
        self.prev = nil;
        self.data = nil;
        self.next = nil;
    }
    return self;
}

- (id) initWithData:(id) data
{
    self = [super init];
    if (self)
    {
        self.prev = nil;
        self.data = data;
        self.next = nil;
    }
    return self;
}

- (void) dealloc
{
    self.data = nil;
    self.prev = nil;
    self.next = nil;
    [super dealloc];
}

+ (id) node
{
    LoopListNode* pNode = [[LoopListNode alloc] init];
    return [pNode autorelease];
}

+ (id) nodeWithData:(id) data;
{
    LoopListNode* pNode = [[LoopListNode alloc] initWithData:data];
    return [pNode autorelease];
}

@end

static LoopList* mpCurrentLoopList = nil;;



LoopListNode* getLoopListItem(NSUInteger uIndex)
{
    return [mpCurrentLoopList getItemAtIndex:uIndex];
}

LoopListNode* getLoopListItemReverse(NSUInteger uIndex)
{
    return [mpCurrentLoopList getItemAtIndexReverse:uIndex];
}

id getLoopListData(NSUInteger uIndex)
{
    return [mpCurrentLoopList getDataAtIndex:uIndex];
}
id getLoopListDataReverse(NSUInteger uIndex)
{
    return [mpCurrentLoopList getDataAtIndexReverse:uIndex];
}

LoopListNode* doLoopListMoveHead(void)
{
    return [mpCurrentLoopList moveHead];
}

LoopListNode* doLoopListMoveBegin(void)
{
    return [mpCurrentLoopList moveBegin];
}

LoopListNode* doLoopListMoveEnd(void)
{
    return [mpCurrentLoopList moveEnd];
}

LoopListNode* doLoopListMoveNext(void)
{
    return [mpCurrentLoopList moveNext];
}

LoopListNode* doLoopListMovePrev(void)
{
    return [mpCurrentLoopList movePrev];
}

@implementation LoopList

@synthesize current = mpCurrent;
@synthesize listCount = muCount;
//@synthesize gotoHead;
//@synthesize gotoBegin;
//@synthesize gotoEnd;
//@synthesize gotoNext;
//@synthesize gotoPrev;


- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        mpHead = [[LoopListNode alloc] init];
        mpHead.prev = mpHead;
        mpHead.next = mpHead;
        mpCurrent = mpHead;
        muCount = 0;
    }
    
    return self;
}

- (void) dealloc
{
    if (muCount)
    {
        [self clearList];
    }
    [mpHead release];
    mpHead = nil;
    mpCurrent = nil;
    muCount = 0;
    [super dealloc];
}

+ (id) list
{
    LoopList* pList = [[LoopList alloc] init];
    return [pList autorelease];
}



- (LoopListNode*) getHead
{
    return mpHead;
}

- (LoopListNode*) getBegin
{
    return mpHead.next;
}

- (LoopListNode*) getEnd
{
    return mpHead.prev;
}

- (LoopListNode*) getItemAtIndex:(NSUInteger) uIndex
{
    if (!muCount)
    {
        return mpHead;
    }
    else if (uIndex > muCount)
    {
        uIndex = uIndex % muCount;
    }
    if(!uIndex)
    {
        uIndex = muCount;
    }
    LoopListNode* pNode = mpHead;
    while (uIndex)
    {
        pNode = pNode.next;
        uIndex--;
    }
    return pNode;
}

- (LoopListNode*) getItemAtIndexReverse:(NSUInteger)uIndex
{
    if (!muCount)
    {
        return mpHead;
    }
    else if (uIndex > muCount)
    {
        uIndex = uIndex % muCount;
    }
    if(!uIndex)
    {
        uIndex = muCount;
    }
    LoopListNode* pNode = mpHead;
    while (uIndex)
    {
        pNode = pNode.prev;
        uIndex--;
    }
    return pNode;
}

- (id) getDataAtIndex:(NSUInteger) uIndex
{
    return [self getItemAtIndex:uIndex].data;
}

- (id) getDataAtIndexReverse:(NSUInteger)uIndex
{
    return [self getItemAtIndexReverse:uIndex].data;
}



- (FnGetLoopListItem) getFnItemAtIndex
{
    mpCurrentLoopList = self;
    return getLoopListItem;
}

- (FnGetLoopListItemReverse) getFnItemAtIndexReverse
{
    mpCurrentLoopList = self;
    return getLoopListItemReverse;
}

- (FnGetLoopListData) getFnDataAtIndex
{
    mpCurrentLoopList = self;
    return getLoopListData;
}

- (FnGetLoopListDataReverse) getFnDataAtIndexReverse
{
    mpCurrentLoopList = self;
    return getLoopListDataReverse;
}


- (LoopListNode*) moveBegin
{
    return mpCurrent = mpHead.next;
}

- (LoopListNode*) moveEnd
{
    return mpCurrent = mpHead.prev;
}

- (LoopListNode*) moveHead
{
    return mpCurrent = mpHead;
}

- (LoopListNode*) moveNext
{
    return mpCurrent = mpCurrent.next;
}

- (LoopListNode*) movePrev
{
    return mpCurrent = mpCurrent.prev;
}


- (FnWithoutParam) getFnMoveHead
{
    mpCurrentLoopList = self;
    return (FnWithoutParam)(doLoopListMoveHead);
}

- (FnWithoutParam) getFnMoveBegin
{
    mpCurrentLoopList = self;
    return doLoopListMoveBegin;
}

- (FnWithoutParam) getFnMoveEnd
{
    mpCurrentLoopList = self;
    return doLoopListMoveEnd;
}

- (FnWithoutParam) getFnMoveNext
{
    mpCurrentLoopList = self;
    return doLoopListMoveNext;
}

- (FnWithoutParam) getFnMovePrev
{
    return doLoopListMovePrev;
}


- (id) currentData
{
    return mpCurrent.data;
}

- (void) setCurrentData:(id) data
{
    mpCurrent.data = data;
}

- (BOOL) notHead
{
    return (mpCurrent != mpHead);
}


- (LoopListNode*) appendData:(id) data
{
    return [self appendData:data withPrevNode:mpHead.prev];
}

- (LoopListNode*) appendData:(id)data withPrevNode:(LoopListNode*) pPrevNode
{
    LoopListNode* pNode = [LoopListNode nodeWithData:data];
    return [self appendNode:pNode withPrevNode:pPrevNode];
}

- (LoopListNode*) appendNode:(LoopListNode*) pNode
{
    return [self appendNode:pNode withPrevNode:mpHead.prev];
}

- (LoopListNode*) appendNode:(LoopListNode *)pNode withPrevNode:(LoopListNode*) pPrevNode
{
    if (!pNode)
    {
        return nil;
    }
    [pNode retain];
    pNode.prev = pPrevNode;
    pNode.next = pPrevNode.next;
    pPrevNode.next.prev = pNode;
    pPrevNode.next = pNode;
    muCount++;
    return pNode;
}

- (LoopListNode*) prevAppendData:(id) data
{
    return [self prevAppendData:data withNextNode:mpHead.next];
}

- (LoopListNode*) prevAppendData:(id) data withNextNode:(LoopListNode*) pNextNode
{
    LoopListNode* pNode = [LoopListNode nodeWithData:data];
    return [self preAppendNode:pNode withNextNode:pNextNode];
}

- (LoopListNode*) prevAppendNode:(LoopListNode*) pNode
{
    return [self preAppendNode:pNode withNextNode:mpHead.next];
}

- (LoopListNode*) preAppendNode:(LoopListNode*) pNode withNextNode:(LoopListNode*) pNextNode
{
    if (!pNode)
    {
        return nil;
    }
    [pNode retain];
    pNode.prev = pNextNode.prev;
    pNode.next = pNextNode;
    pNextNode.prev.next = pNode;
    pNextNode.prev = pNode;
    muCount++;
    return pNode;
}

- (LoopListNode*) insertData:(id) data atIndex:(NSUInteger) uIndex;
{
    LoopListNode* pNode = [LoopListNode nodeWithData:data];
    return [self insertNode:pNode atIndex:uIndex];
}

- (LoopListNode*) insertNode:(LoopListNode*) pNode atIndex:(NSUInteger) uIndex
{
    if (!uIndex)
    {
        uIndex = 1;
    }
    else if (uIndex > muCount)
    {
        uIndex = muCount + 1;
    }
    LoopListNode* pNextNode = [self getItemAtIndex:uIndex];
    return [self preAppendNode:pNode withNextNode:pNextNode];
}

- (LoopListNode*) removeNodeWithData:(id) data
{
    for ([self moveBegin]; self.notHead; [self moveNext])
    {
        if (self.currentData == data)
        {
            return [self removeNode:self.current];
        }
    }
    return nil;
}

- (LoopListNode*) removeNode:(LoopListNode*) pNode
{
    if (!pNode)
    {
        pNode = mpCurrent;
    }
    if (pNode != mpHead)
    {
        pNode.prev.next = pNode.next;
        pNode.next.prev = pNode.prev;
        if (mpCurrent.next != mpHead)
        {
            mpCurrent = mpCurrent.next;
        }
        else
        {
            mpCurrent = mpCurrent.prev;
        }
        muCount--;
        return [pNode autorelease];
    }
    else
    {
        return nil;
    }
}

- (LoopListNode*) destroyNode:(LoopListNode*) pNode
{
    if (!pNode)
    {
        pNode = mpCurrent;
    }
    if (pNode != mpHead)
    {
        pNode.prev.next = pNode.next;
        pNode.next.prev = pNode.prev;
        if (mpCurrent.next != mpHead)
        {
            mpCurrent = mpCurrent.next;
        }
        else
        {
            mpCurrent = mpCurrent.prev;
        }
        muCount--;
        [pNode release];
    }
    return mpCurrent;
}

- (void) clearList
{
    while (muCount) {
        [self destroyNode:mpHead.next];
    }
    return;
}

@end

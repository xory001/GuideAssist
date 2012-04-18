//
//  LoopList.h
//  LoveFilm
//
//  Created by Titaro on 11-10-17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LoopListNode : NSObject
{
    LoopListNode* mpPrev;
    id mpData;
    LoopListNode* mpNext;
}
@property (nonatomic, retain) id data;
@property (nonatomic, assign) LoopListNode* prev;
@property (nonatomic, assign) LoopListNode* next;
 

+ (id) node;
+ (id) nodeWithData:(id) data;
- (id) initWithData:(id) data;
@end



typedef LoopListNode* (*FnGetLoopListItem)(NSUInteger);
typedef LoopListNode* (*FnGetLoopListItemReverse)(NSUInteger);
typedef id (*FnGetLoopListData)(NSUInteger);
typedef id (*FnGetLoopListDataReverse)(NSUInteger);
typedef LoopListNode* (*FnWithoutParam)(void);


LoopListNode* getLoopListItem(NSUInteger uIndex);
LoopListNode* getLoopListItemReverse(NSUInteger uIndex);
id getLoopListData(NSUInteger uIndex);
id getLoopListDataReverse(NSUInteger uIndex);
LoopListNode* doLoopListMoveHead(void);
LoopListNode* doLoopListMoveBegin(void);
LoopListNode* doLoopListMoveEnd(void);
LoopListNode* doLoopListMoveNext(void);
LoopListNode* doLoopListMovePrev(void);


@interface LoopList : NSObject
{
    LoopListNode* mpHead;
    LoopListNode* mpCurrent;
    NSUInteger muCount;
}

@property (nonatomic, readonly, getter = getHead) LoopListNode* head;
@property (nonatomic, readonly, getter = getBegin) LoopListNode* begin;
@property (nonatomic, readonly, getter = getEnd) LoopListNode* end;
//@property (nonatomic, readonly, getter = getFnMoveHead) FnWithoutParam gotoHead;
//@property (nonatomic, readonly, getter = getFnMoveBegin) FnWithoutParam gotoBegin;
//@property (nonatomic, readonly, getter = getFnMoveEnd) FnWithoutParam gotoEnd;
//@property (nonatomic, readonly, getter = getFnMoveNext) FnWithoutParam gotoNext;
//@property (nonatomic, readonly, getter = getFnMovePrev) FnWithoutParam gotoPrev;
@property (nonatomic, readonly, getter = notHead) BOOL notHead;
@property (nonatomic, assign) LoopListNode* current;
@property (nonatomic, retain, getter = currentData, setter = setCurrentData:) id currentData;
@property (nonatomic, readonly) NSUInteger listCount;
//@property (nonatomic, readonly, getter = getFnItemAtIndex) FnGetLoopListItem getItem;
//@property (nonatomic, readonly, getter = getFnItemAtIndexReverse) FnGetLoopListItemReverse getItemReverse;
//@property (nonatomic, readonly, getter = getFnDataAtIndex) FnGetLoopListData getItemData;
//@property (nonatomic, readonly, getter = getFnDataAtIndexReverse) FnGetLoopListDataReverse getItemDataReverse;


+ (id) list;

- (LoopListNode*) getHead;
- (LoopListNode*) getBegin;
- (LoopListNode*) getEnd;
- (LoopListNode*) getItemAtIndex:(NSUInteger) uIndex;
- (LoopListNode*) getItemAtIndexReverse:(NSUInteger)uIndex;
- (id) getDataAtIndex:(NSUInteger) uIndex;
- (id) getDataAtIndexReverse:(NSUInteger)uIndex;

- (FnGetLoopListItem) getFnItemAtIndex;
- (FnGetLoopListItemReverse) getFnItemAtIndexReverse;
- (FnGetLoopListData) getFnDataAtIndex;
- (FnGetLoopListDataReverse) getFnDataAtIndexReverse;

- (LoopListNode*) moveBegin;
- (LoopListNode*) moveEnd;


- (LoopListNode*) moveHead;
- (LoopListNode*) moveNext;
- (LoopListNode*) movePrev;

- (FnWithoutParam) getFnMoveHead;
- (FnWithoutParam) getFnMoveBegin;
- (FnWithoutParam) getFnMoveEnd;
- (FnWithoutParam) getFnMoveNext;
- (FnWithoutParam) getFnMovePrev;

- (id) currentData;
- (void) setCurrentData:(id) data;
- (BOOL) notHead;

- (LoopListNode*) appendData:(id) data;
- (LoopListNode*) appendData:(id)data withPrevNode:(LoopListNode*) pPrevNode;

- (LoopListNode*) appendNode:(LoopListNode*) pNode;
- (LoopListNode*) appendNode:(LoopListNode *)pNode withPrevNode:(LoopListNode*) pPrevNode;

- (LoopListNode*) prevAppendData:(id) data;
- (LoopListNode*) prevAppendData:(id) data withNextNode:(LoopListNode*) pNextNode;

- (LoopListNode*) prevAppendNode:(LoopListNode*) pNode;
- (LoopListNode*) preAppendNode:(LoopListNode*) pNode withNextNode:(LoopListNode*) pNextNode;

- (LoopListNode*) insertData:(id) data atIndex:(NSUInteger) uIndex;
- (LoopListNode*) insertNode:(LoopListNode*) pNode atIndex:(NSUInteger) uIndex;

- (LoopListNode*) removeNodeWithData:(id) data;
- (LoopListNode*) removeNode:(LoopListNode*) pNode;
- (LoopListNode*) destroyNode:(LoopListNode*) pNode;
- (void) clearList;
@end

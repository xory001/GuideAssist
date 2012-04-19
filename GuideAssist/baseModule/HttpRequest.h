//
//  HttpRequest.h
//  LoveFilm
//
//  Created by Titaro on 11-10-9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//开始下载的时候调用
void doStartInitHttpError();
//下载成功的时候调用
void doHttpRequestSucceeded();

//下载失败的时候调用
//返回TRUE表示重试
//返回FALSE表示不重试
BOOL doTipHttpError();

//获得当前的网络模式
NSUInteger getNetworkTipMode();
//设置当前的网络提示模式
void setNetworkTipMode(NSUInteger uMode);

@interface HttpErrorTiper :NSObject
{
    BOOL mbTipReturnValue;
}
- (NSInteger) doTipError;
+ (NSInteger) doTipError;
+ (BOOL) doTipHttpError;

@property(nonatomic, readonly) BOOL tipReturnValue;
@end

typedef NSString* (*FnGetResponsValue)(NSString*);

@class HttpDownloadHelper;

@protocol HttpDownloadHelperDelegate <NSObject>
- (void)didFinishDownload:(HttpDownloadHelper*) pResult;
@end


#define InfiniteTime ((NSUInteger)(NSInteger)(-1))
#define MaxBlockRequestErrorTimes 20
#define BlockRequestErrorTimeOut 20

#pragma mark -
#pragma mark HttpDownloadHelper member variables define
@interface HttpDownloadHelper : NSObject
{
@protected
    NSURLConnection* mpUrlConnection;
    NSMutableData* mpReceivedData;
    NSString* mpstrResult;
    NSMutableURLRequest* mpUrlRequest;
    NSHTTPURLResponse* mpHttpUrlResponse;
    NSError* mpError;
    id mpDelegate;
    id mpOldDelegate;
    SEL mpDelegateSelector;
    BOOL mbIsDownloading;
    BOOL mbCanceled;
    BOOL mbHasError;
    BOOL mbHasTipError;
    BOOL mbIsBlockRequest;
    NSUInteger muBlockRequestErrorTimes; //阻塞调用错误次数
    NSTimeInterval mErrorStartTime; //阻塞调用时使用
    NSUInteger muTipErrorMode; //暂时没有使用
    BOOL mbLastDownloadSucceeded;
    NSUInteger muTotalDownloadCount;
    NSUInteger muTotalDownloadCompletedCount;
}

#pragma mark -
#pragma mark HttpDownloadHelper propertys by synthesize

@property (nonatomic, readonly) BOOL isDownloading;
@property (nonatomic, readonly) BOOL hasCanceled;
@property (nonatomic, readonly) BOOL hasError;
@property (nonatomic, readwrite) NSUInteger tipErrorMode;
@property (nonatomic, readonly, assign) NSError* lastError;
@property (nonatomic, readonly) NSUInteger totalDownloadCount;
@property (nonatomic, readonly) NSUInteger totalDownloadCompletedCount;
@property (nonatomic, assign, setter = setDelegate:) id delegate;
@property (nonatomic, assign) SEL delegateSelector;
@property (nonatomic, readonly) BOOL didLastDownloadSucceeded;
@property (nonatomic, readonly, getter = getResponseHeaders) NSDictionary* responseHeaders;
@property (nonatomic, readonly, getter = getFnResponseValue) FnGetResponsValue responseValue;

#pragma mark -
#pragma mark HttpDownloadHelper propertys by "getter="
@property (nonatomic, readonly, getter = getResultString) NSString* resultString;
@property (nonatomic, readonly, getter = getResultData) NSData* resultData;

#pragma mark -
#pragma mark HttpDownloadHelper initialize

- (void) reinit;

#pragma mark -
#pragma mark HttpDownloadHelper download controls

- (BOOL) startDownload;
- (BOOL) startDownloadWithBlockTime:(NSUInteger) uBlockTime; //millisecond
- (BOOL) doCancel;
- (void) doRetryDownload;
#pragma mark -
#pragma mark HttpDownloadHelper Setting before download

- (BOOL) setUrl:(NSString*) pstrTargetUrl;
- (BOOL) setHTTPMethod:(NSString*) pstrMethod;
- (BOOL) setHTTPHeaders:(NSDictionary*) pHeaders;
- (BOOL) setHTTPHeaderValue:(NSString*) pstrValue forKey:(NSString*) pstrKey;
- (BOOL) setHttpBody:(NSData*) pData;
- (BOOL) setHttpBody:(NSString*)strHttpBody withEncoding:(NSStringEncoding) encoding;
- (void) resetDownloadCompeletedCount;
- (NSString*) getResponseValue:(NSString*) pstrCode;

- (FnGetResponsValue) getFnResponseValue;
#pragma mark -
#pragma mark HttpDownloadHelper get result after download

- (NSString*) getResultString:(NSStringEncoding) encoding;

@end

typedef HttpDownloadHelper HttpRequest;
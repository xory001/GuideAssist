//
//  HttpRequest.m
//  LoveFilm
//
//  Created by Titaro on 11-10-9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "HttpRequest.h"
#import "DialogUIAlertView.h"
HttpDownloadHelper* mpCurrentDownloadHelper = nil;

//连续出现指定次数的网络错误显示网络错误提示
#define HttpErrorTipMaxCount 10
//连续出现网络错误并且网络加载时间超过最大值(秒)显示网络错误提示
#define HttpErrorTipMaxTime 30.0

#define TipModeDefault 0 //超时或网络错误次数达到最大值时提醒
#define TipModeOnce 1 //在网络请求成功前不再提醒，请求成功后按照TipDefault模式提醒一次
#define TipModeNoneWithRetry 2 //不再提醒，总是后台重试
#define TipModeNone 3 //不再提醒，不后台重试

#define HttpDoNextTip 0 //用户旋转下次提醒
#define HttpDoRetry 1 //用户选择重试
#define HttpDoBackgroundRetryOnce 2 //用户选择后台重试
#define HttpDoBackgroundRetryAlways 3 //用户选择总是后台重试
#define HttpDoTipNoe 4 //用户旋转不再提醒

NSTimeInterval mHttpErrorStartTime = 0;
NSUInteger muHttpErrorCount = 0;
BOOL mbLastHttpRequestHasError = FALSE;
BOOL mbHttpErrorLock = FALSE;
NSUInteger muTipMode = 0;
BOOL mbIsDoTipError = FALSE;

//调用TipModeNoneWithRetry的提醒
BOOL doTipHttpErrorWithRetry();
//调用TipModeNone的提醒
BOOL doTipHttpErrorWithNone();
//调用TipModeOnce的提醒
BOOL doTipHttpErrorWithOnce();
//调用默认模式的提醒
BOOL doTipHttpErrorWithDefault();
//获得当前是否需要提醒，与提醒模式无关
BOOL getHttpNeedTip();
//显示提示窗口并进行相关处理
BOOL doDisplayTip();

//获得当前的网络提示模式
NSUInteger getNetworkTipMode()
{
    return muTipMode;
}

//设置当前的网络提示模式
void setNetworkTipMode(NSUInteger uMode)
{
    muTipMode = uMode;
}

//开始下载的时候调用
void doStartInitHttpError()
{
    if (mbIsDoTipError)
    {
        return;
    }
    while (mbHttpErrorLock) 
    {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
    }
    mbHttpErrorLock = TRUE;
    if (!mbLastHttpRequestHasError && !mHttpErrorStartTime)
    {
        //如果前次调用没有错误并且没有设置过startTime
        mHttpErrorStartTime = CFAbsoluteTimeGetCurrent();
    }
    mbHttpErrorLock = FALSE;
}

//下载成功的时候调用
void doHttpRequestSucceeded()
{
    if (mbIsDoTipError)
    {
        return;
    }
    while (mbHttpErrorLock) 
    {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
    }
    mbHttpErrorLock = TRUE;
    //清空所有信息
    mbLastHttpRequestHasError = FALSE;
    mHttpErrorStartTime = 0;
    muHttpErrorCount = 0;
    mbHttpErrorLock = FALSE;
}

//获得当前是否需要提醒，与提醒模式无关
BOOL getHttpNeedTip()
{
    return TRUE;
    if (muHttpErrorCount >= HttpErrorTipMaxCount)
    {
        return TRUE;
    }
    else
    {
        NSTimeInterval timeNow = CFAbsoluteTimeGetCurrent();
        if ((timeNow - mHttpErrorStartTime) >= HttpErrorTipMaxTime)
        {
            return TRUE;
        }
        return FALSE;
    }
}

//显示提示窗口并进行相关处理
BOOL doDisplayTip()
{
    NSInteger iTipRet = [HttpErrorTiper doTipError];
    if (iTipRet == HttpDoNextTip)
    {
        //选择下次提醒
        setNetworkTipMode(TipModeDefault);
        //不进行重试
        return FALSE;
    }
    else if (iTipRet == HttpDoRetry)
    {
        //选择重试
        setNetworkTipMode(TipModeDefault);
        //进行重试
        return TRUE;
    }
    else if (iTipRet == HttpDoBackgroundRetryOnce)
    {
        //选择后台重试
        setNetworkTipMode(TipModeOnce);
        //进行重试
        return TRUE;
    }
    else if (iTipRet == HttpDoBackgroundRetryAlways)
    {
        //选择总是后台重试
        setNetworkTipMode(TipModeNoneWithRetry);
        //进行重试
        return TRUE;
    }
    else if (iTipRet == HttpDoTipNoe)
    {
        //选择不再提醒
        setNetworkTipMode(TipModeNone);
        //不进行重试
        return FALSE;
    }
    else
    {
        //默认不进行重试
        //此种情况逻辑上不存在
        return FALSE;
    }
}


//调用TipModeNoneWithRetry的提醒
BOOL doTipHttpErrorWithRetry()
{
    mHttpErrorStartTime = 0;
    muHttpErrorCount = 0;
    mbLastHttpRequestHasError = TRUE;
    return TRUE;
}

//调用TipModeNone的提醒
BOOL doTipHttpErrorWithNone()
{
    mHttpErrorStartTime = 0;
    muHttpErrorCount = 0;
    mbLastHttpRequestHasError = TRUE;
    //不进行重试
    return FALSE;
}

//调用TipModeOnce的提醒
BOOL doTipHttpErrorWithOnce()
{
    BOOL bNeedTip = getHttpNeedTip();
    mHttpErrorStartTime = 0;
    muHttpErrorCount = 0;
    if (!bNeedTip)
    {
        return TRUE;
    }
    if (mbLastHttpRequestHasError)
    {
        //一直存在错误，不再提醒，不再重试
        return TRUE;
    }
    else
    {
        mbLastHttpRequestHasError = TRUE;
        return doDisplayTip();
    }
}


//调用默认模式的提醒
BOOL doTipHttpErrorWithDefault()
{
    BOOL bNeedTip = getHttpNeedTip();
    mHttpErrorStartTime = 0;
    muHttpErrorCount = 0;
    mbLastHttpRequestHasError = TRUE;
    if (!bNeedTip)
    {
        return TRUE;
    }
    else
    {
        return doDisplayTip();
    }
}

//下载失败的时候调用
//返回TRUE表示重试
//返回FALSE表示不重试
BOOL doTipHttpError()
{
    if (mbIsDoTipError)
    {
        //正在显示提示的时候默认重试
        return TRUE;
    }
    else
    {
        mbIsDoTipError = TRUE;
    }
    while (mbHttpErrorLock)
    {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
    }
    mbHttpErrorLock = TRUE;
    
    BOOL bRet = TRUE;
    NSUInteger uCurrentTipMode = getNetworkTipMode();
    muHttpErrorCount++;
    
    if (uCurrentTipMode == TipModeDefault)
    {
        bRet = doTipHttpErrorWithDefault();
    }
    else if (uCurrentTipMode == TipModeOnce)
    {
        bRet = doTipHttpErrorWithOnce();
    }
    else if (uCurrentTipMode == TipModeNoneWithRetry)
    {
        bRet = doTipHttpErrorWithRetry();
    }
    else if (uCurrentTipMode == TipModeNone)
    {
        bRet = doTipHttpErrorWithNone();
    }
    mbHttpErrorLock = FALSE;
    mbIsDoTipError = FALSE;
    return bRet;
}

NSString* _getDownloaderResponsValue(NSString* pstrCode);


NSString* _getDownloaderResponsValue(NSString* pstrCode)
{
    return [mpCurrentDownloadHelper getResponseValue:pstrCode];
}

@implementation HttpErrorTiper
@synthesize tipReturnValue = mbTipReturnValue;

+ (NSInteger) doTipError
{
    HttpErrorTiper* pErrorTiper = [[HttpErrorTiper alloc] init];
    if ([NSThread currentThread].isMainThread)
    {
        //当前线程是主线程
        //直接调用提示函数
        [pErrorTiper doTipError];
    }
    else
    {
        //当前线程不是主线程
        //在主线程中调用提示函数知道函数结束
        [pErrorTiper performSelector:@selector(doTipError) onThread:[NSThread mainThread] withObject:nil waitUntilDone:TRUE];
    }
    NSInteger iRet = pErrorTiper.tipReturnValue;
    [pErrorTiper release];
    return iRet;
}

+ (BOOL) doTipHttpError
{
    
}


- (NSInteger) doTipError
{
    //    NSInteger iRet = msgBox(@"网络错误", @"请检测您的设备是否连接网络。", @"下次提醒", @"重试", @"后台重试", @"总是后台重试", @"不再提醒", nil);
    NSInteger iRet = msgBox(@"网络错误", @"请检测您的设备是否连接网络", @"确定", nil);
    mbTipReturnValue = iRet;
    return mbTipReturnValue;
}

@end

@implementation HttpDownloadHelper

#pragma mark -
#pragma mark HttpDownloadHelper propertys by synthesize
@synthesize isDownloading = mbIsDownloading;
@synthesize hasCanceled = mbCanceled;
@synthesize hasError = mbHasError;
@synthesize tipErrorMode = muTipErrorMode;
@synthesize lastError = mpError;
@synthesize totalDownloadCount = muTotalDownloadCount;
@synthesize totalDownloadCompletedCount = muTotalDownloadCompletedCount;
@synthesize delegate = mpDelegate;
@synthesize delegateSelector = mpDelegateSelector;
@synthesize didLastDownloadSucceeded = mbLastDownloadSucceeded;
@synthesize responseValue;
#pragma mark -
#pragma mark HttpDownloadHelper propertys by "gerter="
- (NSString*) getResultString
{
    return [self getResultString:NSUTF8StringEncoding];
}

- (NSData*) getResultData
{
    if (self.didLastDownloadSucceeded)
    {
        return mpReceivedData;
    }
    else
    {
        return nil;
    }
}

- (void) setDelegate:(id)delegate
{
    mpDelegate = delegate;
    mpOldDelegate = nil;
}

#pragma mark -
#pragma mark HttpDownloadHelper initialize and dealloc
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        [self reinit];
    }
    
    return self;
}

- (void) reinit
{
    mpDelegate = nil;
    mpOldDelegate = nil;
    if (mpUrlConnection)
    {
        [mpUrlConnection release];
        mpUrlConnection = nil;
    }
    if (mpReceivedData)
    {
        [mpReceivedData release];
        mpReceivedData = nil;
    }
    if (mpstrResult)
    {
        [mpstrResult release];
        mpstrResult = nil;
    }
    if (mpUrlRequest)
    {
        [mpUrlRequest release];
        mpUrlRequest = nil;
    }
    if (mpError)
    {
        [mpError release];
        mpError = nil;
    }
    if (mpUrlConnection)
    {
        [mpUrlConnection release];
        mpUrlConnection = nil;
    }
    if (mpHttpUrlResponse)
    {
        [mpHttpUrlResponse release];
        mpHttpUrlResponse = nil;
    }
    mbIsDownloading = FALSE;
    mbCanceled = FALSE;
    mbHasError = FALSE;
    muTotalDownloadCount = 0;
    muTotalDownloadCompletedCount = 0;
    mbLastDownloadSucceeded = FALSE;
    return;
}

- (void)dealloc
{
    [self reinit];
    [super dealloc];
}

#pragma mark -
#pragma mark HttpDownloadHelper download controls

- (BOOL) startDownload
{
    mbIsBlockRequest = FALSE;
    if (mpUrlConnection)
    {
        return FALSE;
    }
    if (mpOldDelegate)
    {
        mpDelegate = mpOldDelegate;
        mpOldDelegate = nil;
    }
    mbCanceled = FALSE;
    mbIsDownloading = TRUE;
    mbHasError = FALSE;
    mbHasTipError = FALSE;
    muTotalDownloadCount++;
    if (mpError)
    {
        [mpError release];
        mpError = nil;
    }
    doStartInitHttpError();
    mpUrlConnection = [[NSURLConnection alloc] initWithRequest:mpUrlRequest delegate:self];
    if (!mpUrlConnection)
    {
        return FALSE;
    }
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    return TRUE;
}

- (BOOL) startDownloadWithBlockTime:(NSUInteger) uBlockTime
{
    BOOL bRet = [self startDownload];
    mbIsBlockRequest = TRUE;
    muBlockRequestErrorTimes = 0;
    if (!bRet)
    {
        return FALSE;
    }
    else
    {
        if (uBlockTime == InfiniteTime)
        {
            while (self.isDownloading)
            {
                //此处runUntilDate使用以避免run loop无法退出的情况
                [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
                //                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            }
        }
        else
        {
            CFTimeInterval endTime = CFAbsoluteTimeGetCurrent() + (CFTimeInterval)uBlockTime / 1000;
            while (self.isDownloading && CFAbsoluteTimeGetCurrent() < endTime)
            {
                //此处runUntilDate使用以避免run loop无法退出的情况
                [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
                //                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            }
        }
        if (self.hasError || self.hasCanceled)
        {
            return FALSE;
        }
        else
        {
            return TRUE;
        }
    }
}


- (BOOL) doCancel
{
    if (self.isDownloading)
    {
        mbCanceled = TRUE;
        mpOldDelegate = mpDelegate;
        mpDelegate = nil;
        [self performSelector:@selector(connectionDidFinishLoading:) withObject:nil];
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}

- (void) internalDoRetryDownload
{
    if (mpUrlConnection)
    {
        [mpUrlConnection cancel];
        [mpUrlConnection release];
        mpUrlConnection = nil;
    }
    mpUrlConnection = [[NSURLConnection alloc] initWithRequest:mpUrlRequest delegate:self];
}

- (void) doRetryDownload
{
    [self performSelector:@selector(internalDoRetryDownload) withObject:nil afterDelay:0];
}


#pragma mark -
#pragma mark HttpDownloadHelper Setting before download

- (BOOL) setUrl:(NSString*) pstrTargetUrl
{
    if (self.isDownloading || !pstrTargetUrl)
    {
        return FALSE;
    }
    else
    {
        if (mpUrlRequest)
        {
            [mpUrlRequest release];
            mpUrlRequest = nil;
        }
        if (!mpUrlRequest)
        {
            mpUrlRequest = [[NSMutableURLRequest alloc] init];
            if (!mpUrlRequest)
            {
                return FALSE;
            }
        }
        NSURL* pUrl = [NSURL URLWithString:pstrTargetUrl];
        if (!pUrl)
        {
            return FALSE;
        }
        [mpUrlRequest setURL:pUrl];
        return TRUE;
    }
}

- (BOOL) setHTTPHeaders:(NSDictionary *) pHeaders 
{
    if (mpUrlRequest)
    {
        if (pHeaders) 
        {
            [mpUrlRequest setAllHTTPHeaderFields:pHeaders];
            
            return TRUE;
        }
        else 
        {
            return FALSE;
        }
    }
    else
    {
        return FALSE;
    }
}

- (BOOL) setHTTPHeaderValue:(NSString*) pstrValue forKey:(NSString*) pstrKey 
{
    if (mpUrlRequest) 
    {
        if ( pstrValue && pstrKey && ![pstrKey isEqualToString:@""] )
        {
            [mpUrlRequest setValue:pstrValue forHTTPHeaderField:pstrKey];
            return TRUE;
        }
        else 
        {
            return FALSE;
        }
    }
    else
    {
        return FALSE;
    }
    
}

- (BOOL) setHTTPMethod:(NSString*) pstrMethod
{
    if (self.isDownloading)
    {
        return FALSE;
    }
    else
    {
        if (!mpUrlRequest)
        {
            mpUrlRequest = [[NSMutableURLRequest alloc] init];
            if (!mpUrlRequest)
            {
                return FALSE;
            }
        }
        [mpUrlRequest setHTTPMethod:pstrMethod];
        if (![mpUrlRequest.HTTPMethod isEqualToString:pstrMethod])
        {
            return FALSE;
        }
        return TRUE;
    }
}

- (BOOL) setHttpBody:(NSData*) pData
{
    if (self.isDownloading || !pData)
    {
        return FALSE;
    }
    else
    {
        if (!mpUrlRequest)
        {
            mpUrlRequest = [[NSMutableURLRequest alloc] init];
            if (!mpUrlRequest)
            {
                return FALSE;
            }
        }
        [mpUrlRequest setHTTPBody:pData];
        return TRUE;
    }
}

- (BOOL) setHttpBody:(NSString*)strHttpBody withEncoding:(NSStringEncoding) encoding
{
    return [self setHttpBody:[strHttpBody dataUsingEncoding:encoding]];
}

- (void) resetDownloadCompeletedCount
{
    muTotalDownloadCompletedCount = 0;
}

- (NSString*) getResponseValue:(NSString*) pstrCode
{
    return [self.getResponseHeaders objectForKey:pstrCode];
}

- (FnGetResponsValue) getFnResponseValue
{
    mpCurrentDownloadHelper = self;
    return _getDownloaderResponsValue;
}

- (NSDictionary*)getResponseHeaders 
{
    if (mpHttpUrlResponse)
    {
        return [mpHttpUrlResponse allHeaderFields];
    }
    return [NSDictionary dictionary];
}

#pragma mark -
#pragma mark HttpDownloadHelper get result after download

- (NSString*) getResultString:(NSStringEncoding) encoding
{
    if (self.didLastDownloadSucceeded )
    {
        if (mpstrResult)
        {
            [mpstrResult release];
            mpstrResult = nil;
        }
        mpstrResult = [[NSString alloc] initWithData:mpReceivedData encoding:encoding];
        return mpstrResult;
    }
    else
    {
        return nil;
    }
    return 0;
}




#pragma mark -
#pragma mark NSURLConnection delegate methods

// -------------------------------------------------------------------------------
//    handleError:error
// -------------------------------------------------------------------------------
- (void)handleError:(NSError *)error
{
    if (mpError) 
    {
        [mpError release];
        mpError = nil;
    }
    mpError = [error retain];
    mbHasError = TRUE;
}

// The following are delegate methods for NSURLConnection. Similar to callback functions, this is how
// the connection object,  which is working in the background, can asynchronously communicate back to
// its delegate on the thread from which it was started - in this case, the main thread.
//

// -------------------------------------------------------------------------------
//    connection:didReceiveResponse:response
// -------------------------------------------------------------------------------
long long llexpectedContentLength = 0;
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //    llexpectedContentLength = [response expectedContentLength];
    //    if ( llexpectedContentLength== NSURLResponseUnknownLength)
    //    {
    //        [self handleError:nil];
    //        return;
    //    }
    if (response) 
    {
        if (mpHttpUrlResponse) 
        {
            [mpHttpUrlResponse release];
            mpHttpUrlResponse = nil;
        }
        mpHttpUrlResponse = (NSHTTPURLResponse*)[response retain];
    }
    
    if (mpReceivedData)
    {
        [mpReceivedData release];
        mpReceivedData = nil;
    }
    mpReceivedData = [[NSMutableData alloc] initWithLength:0];    // start off with new data
    //    NSUInteger uLength = [self.resultData length];
    //    NSLog(@"data len %u, llexpectedContentLength %lld", uLength, llexpectedContentLength);
}

// -------------------------------------------------------------------------------
//    connection:didReceiveData:data
// -------------------------------------------------------------------------------
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //[mpReceivedData increaseLengthBy:[data length]];
    [mpReceivedData appendData:data];  // append incoming data
}

// -------------------------------------------------------------------------------
//    connection:didFailWithError:error
// -------------------------------------------------------------------------------
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    BOOL bTipRet = TRUE;
    if (!mbHasTipError)
    {
        doTipHttpError();
        mbHasTipError = TRUE;
        mErrorStartTime = CFAbsoluteTimeGetCurrent();
    }
    if (mbIsBlockRequest)
    {
        muBlockRequestErrorTimes++;
        if (muBlockRequestErrorTimes >= MaxBlockRequestErrorTimes)
        {
            bTipRet = FALSE;
        }
        if ((CFAbsoluteTimeGetCurrent() - mErrorStartTime) > BlockRequestErrorTimeOut)
        {
            bTipRet = FALSE;
        }
    }
    //    else if (CFAbsoluteTimeGetCurrent() - mErrorStartTime > 20)
    //    {
    //        //错误时间大于30秒，不再重试
    //        bTipRet = FALSE;
    //    }
    if ([error code] == kCFURLErrorNotConnectedToInternet)
    {
        // if we can identify the error, we can present a more precise message to the user.
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"No Connection Error"
                                                             forKey:NSLocalizedDescriptionKey];
        NSError *noConnectionError = [NSError errorWithDomain:NSCocoaErrorDomain
                                                         code:kCFURLErrorNotConnectedToInternet
                                                     userInfo:userInfo];
        if (!bTipRet)
        {
            //无需重试
            [self handleError:noConnectionError];
            [noConnectionError release];
        }
        else
        {
            //需要重试
            [self doRetryDownload];
            return;
        }
    }
    else
    {
        // otherwise handle the error generically
        if (!bTipRet)
        {
            //无需重试
            [self handleError:error];
        }
        else
        {
            //需要重试
            [self doRetryDownload];
            return;
        }
    }
    [self performSelector:@selector(connectionDidFinishLoading:) withObject:nil];
}

// -------------------------------------------------------------------------------
//    connectionDidFinishLoading:connection
// -------------------------------------------------------------------------------
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    //    NSUInteger uLength= [self.resultData length];
    //    NSLog(@"data len %u, llexpectedContentLength %lld", uLength, llexpectedContentLength);
    // release our connection
    //    NSLog(@"%@", [mpUrlRequest allHTTPHeaderFields]);
    //    NSLog(@"%@", [mpHttpUrlResponse allHeaderFields]);
    if (mpUrlConnection)
    {
        [mpUrlConnection release];
        mpUrlConnection = nil;
    }
    mbIsDownloading = FALSE;
    if (!self.hasCanceled && !self.hasError)
    {
        muTotalDownloadCompletedCount++;
        mbLastDownloadSucceeded = TRUE;
        doHttpRequestSucceeded();
    }
    else
    {
        mbLastDownloadSucceeded = FALSE;
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;   
    
    if (mpDelegate)
    {
        if (mpDelegateSelector)
        {
            if ([mpDelegate respondsToSelector:mpDelegateSelector])
            {
                [mpDelegate performSelector:mpDelegateSelector withObject:self];
            }
        }
        else
        {
            if ([mpDelegate respondsToSelector:@selector(didFinishDownload:)])
            {
                [mpDelegate performSelector:@selector(didFinishDownload:) withObject:self];
            }
        }
    }
}


@end

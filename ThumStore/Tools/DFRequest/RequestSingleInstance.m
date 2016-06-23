//
//  RequestSingleInstance.m
//  SanYiBao
//
//  Created by hdf on 16/4/22.
//  Copyright © 2016年 sanweitong. All rights reserved.
//

#import "RequestSingleInstance.h"
#import "AppDelegate.h"
#import "BasicMethod.h"
#import "FDHLoginVc.h"
static RequestSingleInstance * instance;

@implementation RequestSingleInstance{
    
    UIAlertView *warnAlertView;
}

bool isFromSelf;
bool loginoutAlertviewalreadyExist;
AFHTTPRequestOperationManager * manager;

+(id)shareRequestInstance
{
    if (!instance) {
        isFromSelf = YES;
        instance = [[RequestSingleInstance alloc]init];
        isFromSelf = NO;
        /**
         *  初始化AFmanager
         */
//        manager = [AFHTTPRequestOperationManager manager];
//        manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//        manager.requestSerializer = [AFJSONRequestSerializer serializer];
//        manager.responseSerializer = [AFJSONResponseSerializer serializer];
//        manager.requestSerializer.timeoutInterval = 5.f;
        
        
        
        manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.requestSerializer.timeoutInterval = 300;
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager.operationQueue setMaxConcurrentOperationCount:1];

    }
    return instance;
}

+(id)alloc
{
    if (isFromSelf == YES)
    {
        return [super alloc];
    }
    return nil;
}

-(void)POSTRequest:(id)control urlString:(NSString *)urlStr postValue:(NSDictionary *)dict dealWithBlock :(void (^)(NSDictionary *, NSError *))aBlock
{
    [[DFAnimationProgress sharedInstance] show:KEYWINDOW];
    self.flags = @"POST";
    
    tmpControl = control;
    if (!tmpPostValueDict) {
        tmpPostValueDict = [[NSMutableDictionary alloc]init];
    }
    if ([[tmpPostValueDict allKeys] count] ) {
        [tmpPostValueDict removeAllObjects];
    }
    for(NSString * key in [dict allKeys])
    {
        [tmpPostValueDict setObject:[dict objectForKey:key] forKey:key];
    }
    tmpRequestURL = urlStr;
    tmpBlock = aBlock ;
    
   
    [manager POST:urlStr parameters:dict success:^(AFHTTPRequestOperation * operation ,id responseObject)
    {
        [self judgeStatus:responseObject];
        
        if (aBlock) {
            aBlock([NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil], nil);
        }
        [[DFAnimationProgress sharedInstance] dismiss];
    } failure:^(AFHTTPRequestOperation * operation ,NSError * error){
        
        if (aBlock) {
            aBlock([NSDictionary dictionary], error);
        }
        [[DFAnimationProgress sharedInstance] dismiss];
    }];
}

-(void)GETRequest:(UIViewController*)viewController With:(NSString *)urlStr dealWithBlock :(void (^)(NSDictionary *, NSError *))aBlock
{
    self.flags = @"GET";

    tmpControl = viewController;
    tmpRequestURL = urlStr;
    tmpBlock = aBlock ;
    
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self judgeStatus:responseObject];
        if (aBlock) {
            aBlock([NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil], nil);
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (aBlock) {
            aBlock([NSDictionary dictionary], error);
        }
    }];
}

-(void)PUTRequest:(UIViewController*)viewController With:(NSString *)urlStr andPostValue:(NSDictionary *)dict dealWithBlock :(void (^)(NSDictionary *dict, NSError *error))aBlock
{
    self.flags = @"PUT";
    
    tmpControl = viewController;
    if (!tmpPostValueDict) {
        tmpPostValueDict = [[NSMutableDictionary alloc]init];
    }
    if ([[tmpPostValueDict allKeys] count] ) {
        [tmpPostValueDict removeAllObjects];
    }
    for(NSString * key in [dict allKeys])
    {
        [tmpPostValueDict setObject:[dict objectForKey:key] forKey:key];
    }
    tmpRequestURL = urlStr;
    tmpBlock = aBlock ;
    
    [manager PUT:urlStr parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self judgeStatus:responseObject];
        
        if (aBlock) {
            aBlock([NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil],nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (aBlock) {
            aBlock([NSDictionary dictionary], error);
        }
    }];
}

-(void)DELETERequest:(UIViewController*)viewController With:(NSString *)urlStr andPostValue:(NSDictionary *)dict dealWithBlock :(void (^)(NSDictionary *dict, NSError *error))aBlock
{
    self.flags = @"DELETE";
    
    tmpControl = viewController;
    if (!tmpPostValueDict) {
        tmpPostValueDict = [[NSMutableDictionary alloc]init];
    }
    if ([[tmpPostValueDict allKeys] count] ) {
        [tmpPostValueDict removeAllObjects];
    }
    for(NSString * key in [dict allKeys])
    {
        [tmpPostValueDict setObject:[dict objectForKey:key] forKey:key];
    }
    tmpRequestURL = urlStr;
    tmpBlock = aBlock ;
    
    [manager DELETE:urlStr parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self judgeStatus:responseObject];
        
        if (aBlock) {
            aBlock([NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil],nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        if (aBlock) {
            aBlock([NSDictionary dictionary], error);
        }
    }];
}

-(void)judgeStatus:(id)responseObject
{
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        if ([responseObject containsObject:@"status"]) {
            
            switch ([[responseObject objectForKey:@"status"] intValue]) {
                case 0:
                    
                    break;
                case 1:
                    
                    break;
                case 2:
                    
                    break;
                case 3:
                    
                    break;
                case 4:
                    
                    break;
                default:
                    break;
            }

        }
    }
}
#pragma refreshToken
/*
 
 */
#pragma 重新登录
-(void)warnloginAgain
{
    if (!warnAlertView) {
        warnAlertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该帐号已在另一台设备登录，若不是本人操作，则密码可能泄漏，建议立即修改密码。" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [warnAlertView show];
    }
}
@end

//
//  RequestSingleInstance.h
//  SanYiBao
//
//  Created by hdf on 16/4/22.
//  Copyright © 2016年 sanweitong. All rights reserved.
//

/**
 *  类说明:网络请求类，实现了对AFnetWorking 的外层封装，增加一些返回结果状态的判断，和一些数据的存储，token的active状态的保持和免登陆操作，以及异地登陆判断等。。
 */

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "BasicMethod.h"
#import "DFAnimationProgress.h"
@interface RequestSingleInstance : NSObject
{
    //保存请求的viewController
    id tmpControl;
    
    //保存请求地址
    NSString * tmpRequestURL;
    
    //保存请求体参数
    NSMutableDictionary * tmpPostValueDict;
    
    //保存block回调
    void (^tmpBlock)(NSDictionary* , NSError * error);
}

//oauthToken
@property (copy) NSString * oauth_token;

//刷新用的refresh_token
@property (copy) NSString * refresh_token;

//用户uid
@property (copy) NSString * uid;

//身份证号
@property (copy) NSString * card_id;

//邮箱
@property (copy) NSString * email;

//邮箱认证状态（1表示已认证）
@property (copy) NSString * email_status;

//实名认证状态（1表示已认证）
@property (copy) NSString * name_status;

//手机号码
@property (copy) NSString * phone;

//真实姓名
@property (copy) NSString * realname;

//用户名
@property (copy) NSString * username;

@property (copy) NSString * flags;

+(id)shareRequestInstance;

/**
 *  请求方法 POST/PUT/GET/DELETE
 *
 *  @param tmpControl 当前调用类
 *  @param urlStr         接口
 *  @param dict           参数
 *  @param aBlock         回调方法
 */
-(void)POSTRequest:(id)control urlString:(NSString *)urlStr postValue:(NSDictionary *)dict dealWithBlock :(void (^)(NSDictionary *, NSError *))aBlock;

-(void)GETRequest:(UIViewController*)viewController With:(NSString *)urlStr dealWithBlock :(void (^)(NSDictionary *, NSError *))aBlock;

-(void)PUTRequest:(UIViewController*)viewController With:(NSString *)urlStr andPostValue:(NSDictionary *)dict dealWithBlock :(void (^)(NSDictionary *dict, NSError *error))aBlock;

-(void)DELETERequest:(UIViewController*)viewController With:(NSString *)urlStr andPostValue:(NSDictionary *)dict dealWithBlock :(void (^)(NSDictionary *dict, NSError *error))aBlock;
@end

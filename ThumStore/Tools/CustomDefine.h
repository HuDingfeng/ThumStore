//
//  Header.h
//  SanYiBao
//
//  Created by hdf on 16/4/21.
//  Copyright © 2016年 sanweitong. All rights reserved.
//

#ifndef Header_h
#define Header_h
#define APPDELEGATE (AppDelegate *)[UIApplication sharedApplication].delegate
#define IS_IOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7
#define IS_IOS6 [[[UIDevice currentDevice] systemVersion] floatValue] >= 6
#define IS_IOS8 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8

#define APPFRAME [UIScreen mainScreen].bounds
#define Main_Screen_Width  [UIScreen mainScreen].bounds.size.width
#define Main_Screen_Height [UIScreen mainScreen].bounds.size.height
#endif /* Header_h */


#ifdef __OBJC__
#import <EasyIOS/Easy.h>

#import "BaseNavController.h"
#import "UIView+FLKAutoLayout.h"
#import "RACEXTScope.h"
#import "RequestSingleInstance.h"
#import "FDHLoginVc.h"
#import "DFAnimationProgress.h"
#import "DFProgressHUD.h"
#import "UIColor+StringToColor.h"
#endif

#define KEYWINDOW [UIApplication sharedApplication].keyWindow
#define FONT(i) [UIFont systemFontOfSize:i]

#undef	DF_SINGLETON
#define DF_SINGLETON( __class ) \
- (__class *)sharedInstance; \
+ (__class *)sharedInstance;
#undef	DEFOK_SINGLETON
#define DEFOK_SINGLETON( __class ) \
- (__class *)sharedInstance \
{ \
return [__class sharedInstance]; \
} \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[[self class] alloc] init]; } ); \
return __singleton__; \
}

#define SHOW_ALERT(title, msg ,SEL,cancel_msg ,sure_msg,x)\
UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:msg delegate:SEL cancelButtonTitle:cancel_msg otherButtonTitles:sure_msg, nil];\
alert.tag = (NSInteger)x;\
[alert show];\
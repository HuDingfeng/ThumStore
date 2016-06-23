//
//  UserInfo.m
//  XinHehan
//
//  Created by hdf on 14-7-19.
//  Copyright (c) 2014年 Hdf. All rights reserved.
//

#import "UserInfo.h"
#import "AppDelegate.h"
@implementation UserInfo
+ (UserInfo *) sharedInstance
{
    static  UserInfo *sharedInstance = nil ;
    static  dispatch_once_t onceToken;  // 锁
    dispatch_once (& onceToken, ^ {     // 最多调用一次
        sharedInstance = [[self  alloc] init];
    });
    return  sharedInstance;
}


- (id)init
{
    self = [super init];
    
    if (self) {
    }
    return self;
}
@end

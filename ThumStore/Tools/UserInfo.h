//
//  UserInfo.h
//  XinHehan
//
//  Created by hdf on 14-7-19.
//  Copyright (c) 2014年 Hdf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

+ (UserInfo *)sharedInstance;

@property(nonatomic,copy)NSString *token;
@property(nonatomic,copy)NSString *userId;
@end

//
//  DFProgressHUD.h
//  QDBN
//
//  Created by 胡定锋Mac on 15/8/27.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "MBProgressHUD.h"

@interface DFProgressHUD : MBProgressHUD

+(UIWindow*)getWindow;
+(void)showHudAfterHidden:(NSString*)aString;
+(void)showWithCustomView:(NSString*)aString view:(UIView*)selfView;

@end

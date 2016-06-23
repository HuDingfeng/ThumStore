//
//  DFProgressHUD.m
//  QDBN
//
//  Created by 胡定锋Mac on 15/8/27.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "DFProgressHUD.h"
#import "AppDelegate.h"
#import <MBProgressHUD/MBProgressHUD.h>
@implementation DFProgressHUD

+(UIWindow*)getWindow{
    AppDelegate *aDelegate=[UIApplication sharedApplication].delegate;
    
    return aDelegate.window;
}
+(void)showHudAfterHidden:(NSString*)aString
{
    
    MBProgressHUD  *hud = [[MBProgressHUD alloc ]initWithWindow:[DFProgressHUD getWindow]];
    [[DFProgressHUD getWindow]addSubview:hud];
    hud.mode = MBProgressHUDModeText;
    hud.labelText =aString;
    hud.margin = 10.f;
    hud.yOffset = 100.f;
    [hud show:YES];
    [hud showWhileExecuting:@selector(hide) onTarget:self withObject:nil animated:YES];
}
+(void)hide{
    sleep(3);
}
+(void)showWithCustomView:(NSString*)aString view:(UIView*)selfView {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:selfView animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = aString;
    hud.margin = 10.f;
    hud.yOffset = 40.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
    
}
@end

//
//  FDHTabbarVC.m
//  ThumStore
//
//  Created by 胡定锋Mac on 16/6/21.
//  Copyright © 2016年 胡定锋/IOS blog:http://hudingfeng.github.io   github:HuDingfeng. All rights reserved.
//

#import "FDHTabbarVC.h"
#import "BaseNavController.h"
#import "FDHLoginVC.h"
@interface FDHTabbarVC ()

@end

@implementation FDHTabbarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    NSUInteger index = [tabBarController.viewControllers indexOfObject:viewController];
    if (index == 2) {
        if (![[NSUserDefaults standardUserDefaults] objectForKey:@"token"]) {
            
            FDHLoginVC *loginVc = [[FDHLoginVC alloc]init];
            BaseNavController *loginNav = [[BaseNavController alloc]initWithRootViewController:loginVc];
            loginVc.title = @"登录";
            [self presentViewController:loginNav animated:YES completion:nil];
            return NO;
        }else{
            return YES;
        }
    }else{
        
        return YES;
    }
}

@end

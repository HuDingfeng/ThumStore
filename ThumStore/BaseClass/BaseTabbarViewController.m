//
//  BaseTabbarViewController.m
//  ThumStore
//
//  Created by 胡定锋Mac on 16/6/21.
//  Copyright © 2016年 胡定锋/IOS blog:hudingfeng.github.io   github:HuDingfeng. All rights reserved.
//

#import "BaseTabbarViewController.h"
#import "FDHGoodsVC.h"
#import "FDHmyOrdersVc.h"
#import "FDHShoppingCartVC.h"
#import "BaseNavController.h"
@interface BaseTabbarViewController ()

@end

@implementation BaseTabbarViewController

{ NSArray *arr_imageNor; NSArray *arr_imageSelect; NSArray *titles;}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setup];
}

-(void)setup
{
    self.tabBar.barStyle = UIBarStyleDefault;
    arr_imageNor= [NSArray arrayWithObjects:@"home_nor",@"touzi_nor",@"more_nor",nil];//third_askquest_nor@2x
    arr_imageSelect = [NSArray arrayWithObjects:@"home_pre",@"touzi_pre",@"more_pre",nil];//third_askquest_pre@2x
    titles = @[@"商品", @"购物车", @"订单"];
    self.tabBar.translucent = NO;
    self.viewControllers = @[
                             [self getNav:[FDHGoodsVC new] withTitle:titles[0]],
                             [self getNav:[FDHShoppingCartVC new] withTitle:titles[1]],
                             [self getNav:[FDHmyOrdersVc new] withTitle:titles[2]]];
    
    [self.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem *item, NSUInteger idx, BOOL *stop) {
        [item setTitle:titles[idx]];
        [item setTag:idx];
        [item setImage:[UIImage imageNamed:arr_imageNor[idx]]];
        [item setSelectedImage:[UIImage imageNamed:arr_imageSelect[idx]]];
    }];
}

/**
 *  获取tabbar的viewcontrollers
 *
 *  @param VC    rootvc
 *  @param title 标题
 *
 *  @return nav
 */
-(UINavigationController *)getNav:(UIViewController *)VC withTitle:(NSString *)title
{
    BaseNavController *rootNav = [[BaseNavController alloc]initWithRootViewController:VC];
    VC.title = title;
    
    return rootNav;
}
@end

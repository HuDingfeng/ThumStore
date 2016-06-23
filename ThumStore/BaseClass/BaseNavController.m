//
//  BaseNavController.m
//  ThumStore
//
//  Created by 胡定锋Mac on 16/6/21.
//  Copyright © 2016年 胡定锋/IOS blog:hudingfeng.github.io   github:HuDingfeng. All rights reserved.
//

#import "BaseNavController.h"

@interface BaseNavController ()

@end

@implementation BaseNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationBar.barTintColor = [UIColor colorWithHue:0.56 saturation:0.73 brightness:0.98 alpha:1];
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.translucent = NO;
    NSDictionary * dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    self.navigationBar.titleTextAttributes = dict;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    self.navigationItem.titleView = label;

}


@end

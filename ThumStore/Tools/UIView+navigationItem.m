//
//  UIView+navigationItem.m
//  XinHehan
//
//  Created by bigpig on 14-8-6.
//  Copyright (c) 2014年 Hdf. All rights reserved.
//

#import "UIView+navigationItem.h"

@implementation UIView (navigationItem)

+ (UILabel*)navigationForTitle:(NSString *)titleString
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 21)];
    title.backgroundColor = [UIColor clearColor];
    title.text = titleString;
    title.font = [UIFont systemFontOfSize:20];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    return title;
}

+ (UIButton*)navigationForBack
{
    UIImage *imageNormal = [UIImage imageNamed:@"bar_back_normal"];
    UIImage *imagePress = [UIImage imageNamed:@"bar_back_pressed"];
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, imageNormal.size.width,imageNormal.size.height)];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn setImage:imageNormal forState:UIControlStateNormal];
    [backBtn setImage:imagePress forState:UIControlStateSelected];
    return backBtn;
}

+ (UIButton*)nextBtn:(CGRect)buttonFrame title:(NSString*)title
{
    UIButton *button = [[UIButton alloc] initWithFrame:buttonFrame];
    button.layer.cornerRadius = 5.f;
    [button setBackgroundColor:[UIColor colorWithRed:0.98 green:0 blue:0 alpha:1]];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}

+ (UIButton*)buttonArrow
{
    UIButton *buttonArrow = [[UIButton alloc] initWithFrame:CGRectMake(290, 12, 20, 20)];
    [buttonArrow setImage:[UIImage imageNamed:@"arrow_right"] forState:UIControlStateNormal];
    return buttonArrow;
}
@end

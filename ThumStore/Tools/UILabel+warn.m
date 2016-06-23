//
//  UILabel+warn.m
//  XinHehan
//
//  Created by hdf on 14-8-4.
//  Copyright (c) 2014年 Hdf. All rights reserved.
//

#import "UILabel+warn.h"
#import "CustomDefine.h"
@implementation UILabel (warn)

+(UILabel *)creatWarnLabelWithText:(NSString *)text
{
    UILabel *labelwarn = [[UILabel alloc]init];
    labelwarn.frame = CGRectMake((-80)/2, Main_Screen_Height-64-49-20, 80, 20);

    labelwarn.textColor = [UIColor whiteColor];
    labelwarn.font = [UIFont systemFontOfSize:14];
    labelwarn.textAlignment = NSTextAlignmentCenter;
    labelwarn.backgroundColor = [UIColor colorWithRed:36/255.0 green:36/255.0 blue:36/255.0 alpha:1.0];
    labelwarn.layer.cornerRadius = 5.0f;
    labelwarn.layer.opacity = 0.0f;
    
    labelwarn.text = text;
    CABasicAnimation *animationShow = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animationShow.fromValue = [NSNumber numberWithFloat:0.0];
    animationShow.toValue = [NSNumber numberWithFloat:1.0];
    animationShow.removedOnCompletion = YES;
    
    CABasicAnimation *animationHide = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animationHide.fromValue = [NSNumber numberWithFloat:1.0];
    animationHide.toValue = [NSNumber numberWithFloat:0.0];
    animationHide.removedOnCompletion = YES;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = [NSArray arrayWithObjects:animationShow,animationHide, nil];
    group.duration = 2.f;
    [labelwarn.layer addAnimation:group forKey:nil];

    return labelwarn;
}

//+(UILabel *)fitLabel:(NSString *)str
//{
//    UILabel *label = [[UILabel alloc]init];
//    label.text = str;
//    CGSize size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(MAXFLOAT, label.frame.size.height)];
//    label.frame = CGRectMake(320-30-size.width, 5, size.width, 35);
//    return label;
//}

@end

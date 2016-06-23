//
//  UIView+navigationItem.h
//  XinHehan
//
//  Created by bigpig on 14-8-6.
//  Copyright (c) 2014年 Hdf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (navigationItem)

+ (UILabel*)navigationForTitle:(NSString*)titleString;

+ (UIButton*)navigationForBack;

+ (UIButton*)nextBtn:(CGRect)buttonFrame title:(NSString*)title;

+ (UIButton*)buttonArrow;

@end

//
//  DFAnimationProgress.h
//  SanYiBao
//
//  Created by hdf on 16/4/22.
//  Copyright © 2016年 sanweitong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomDefine.h"
@interface DFAnimationProgress : UIView
AS_SINGLETON(DFAnimationProgress)

@property (nonatomic, assign) CGFloat windowAlpha;
@property (nonatomic, strong)  NSArray *animationArray;
@property (nonatomic, assign)  BOOL isloadWithWindow;

-(void)show:(UIView *)aView;
-(void)dismiss;
@end

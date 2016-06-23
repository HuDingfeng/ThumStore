
//  DFAnimationProgress.m
//  SanYiBao
//
//  Created by hdf on 16/4/22.
//  Copyright © 2016年 sanweitong. All rights reserved.
//

#import "DFAnimationProgress.h"
#import "CustomDefine.h"
@implementation DFAnimationProgress
{
    UIImageView *animationImageView;
   
    UIView *animationWindow;
    
    NSTimer *timer;
}
DEF_SINGLETON(DFAnimationProgress)

-(void)show:(UIView *)aView
{
    _animationArray = [NSArray array];
    _animationArray = @[@"guide01",@"guide02",@"guide03",@"guide04"];
    animationWindow  = [[UIView alloc]initWithFrame:aView.bounds];
    animationWindow.backgroundColor = [UIColor colorWithRed:45.f/255 green:45.f/255 blue:45.f/255 alpha:.6f];
    animationWindow =[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    animationImageView =[[UIImageView alloc]init];
    [animationWindow addSubview:animationImageView];
    [animationImageView alignCenterWithView:animationImageView.superview];
    [animationImageView constrainWidth:@"53" height:@"60"];
    [aView addSubview:animationWindow];
    self.alpha = 1;

    timer = [NSTimer scheduledTimerWithTimeInterval:0.10 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
}

-(void)onTimer
{
    static int count = 0;
    count++;
    NSString* strImageName = [NSString stringWithFormat:@"guide%02d.png",count];
    UIImage* image = [UIImage imageNamed:strImageName];
    animationImageView.image = image;
    if(count == _animationArray.count)
    {
        count = 0;
    }
}
-(void)dismiss
{
    
    CABasicAnimation *animationShow = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animationShow.fromValue = [NSNumber numberWithFloat:0.0];
    animationShow.toValue = [NSNumber numberWithFloat:.5f];
    animationShow.removedOnCompletion = YES;
    
    CABasicAnimation *animationHide = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animationHide.fromValue = [NSNumber numberWithFloat:1.0];
    animationHide.toValue = [NSNumber numberWithFloat:.5f];
    animationHide.removedOnCompletion = YES;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = [NSArray arrayWithObjects:animationShow,animationHide, nil];
    group.duration = 1.f;
    [animationImageView.layer addAnimation:group forKey:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        animationWindow.alpha = 0;
        animationImageView.alpha = 0;
        self.hidden = YES;
        [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:.5f];
        [animationWindow performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:.5f];
        [timer invalidate];
    });
    
    
}

@end

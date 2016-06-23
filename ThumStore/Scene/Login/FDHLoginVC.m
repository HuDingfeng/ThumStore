//
//  FDHLoginVC.m
//  ThumStore
//
//  Created by 胡定锋Mac on 16/6/21.
//  Copyright © 2016年 胡定锋/IOS blog: http://hudingfeng.github.io   github:HuDingfeng. All rights reserved.
//

#import "FDHLoginVC.h"
#import "CustomDefine.h"
#import "AppDelegate.h"
@interface FDHLoginVC ()
//@property (nonatomic,strong)LoginSceneModel *loginSceneModel;
@end

@implementation FDHLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self showBarButton:NAV_LEFT title:@"取消" fontColor:[UIColor whiteColor]];
    [self layoutSubViews];
}

-(void)layoutSubViews
{
    //new
    UIView *inputView = [[UIView alloc]init];
    inputView.layer.borderWidth = 1.f;
    inputView.layer.borderColor = [UIColor hexStringToColor:@"#dcdcdc"].CGColor;
    
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.text = @"用户名:";
    nameLabel.textAlignment = NSTextAlignmentLeft;
    
    UITextField *texf_name =[[UITextField alloc]init];
    texf_name.font = FONT(14);
    texf_name.placeholder = @"请输入用户名";
    texf_name.textAlignment = NSTextAlignmentCenter;
    
    UILabel *lab_line = [[UILabel alloc]init];
    lab_line.backgroundColor = [UIColor hexStringToColor:@"#dcdcdc"];
    
    
    UILabel *psdLabel = [[UILabel alloc]init];
    psdLabel.text = @"密码:";
    psdLabel.textAlignment = NSTextAlignmentLeft;
    
    UITextField *texf_passWord =[[UITextField alloc]init];
    texf_passWord.placeholder = @"请输入密码";
    texf_passWord.font = FONT(14);
    texf_passWord.textAlignment = NSTextAlignmentCenter;
    
    [inputView addSubview:nameLabel];
    [inputView addSubview:psdLabel];
    [inputView addSubview:texf_name];
    [inputView addSubview:lab_line];
    [inputView addSubview:texf_passWord];
    [self.view addSubview:inputView];
    
    
    UIButton *loginButton = [[UIButton alloc]init];
    loginButton.backgroundColor = [UIColor colorWithHue:0.56 saturation:0.77 brightness:0.99 alpha:1];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    loginButton.layer.cornerRadius = 5.0f;
    [self.view addSubview:loginButton];
    
    //constrains
    [inputView alignCenterXWithView:inputView.superview predicate:nil];
    [inputView alignTop:@"50" leading:@"20" toView:inputView.superview];
    [inputView constrainHeight:@"100"];
    
    [nameLabel alignTop:@"0" leading:@"5" toView:nameLabel.superview];
    [nameLabel constrainHeight:@"44"];
    
    [texf_name alignCenterXWithView:inputView.superview predicate:nil];
    [texf_name alignTop:@"0.5" leading:@"50" toView:texf_name.superview];
    [texf_name constrainHeight:@"44"];
    
    [lab_line alignCenterXWithView:inputView.superview predicate:nil];
    [lab_line alignTop:@"50" leading:@"0" toView:lab_line.superview];
    [lab_line constrainHeight:@"1"];
    
    [psdLabel alignTop:@"53" leading:@"5" toView:nameLabel.superview];
    [psdLabel constrainHeight:@"44"];
    
    [texf_passWord alignCenterXWithView:inputView.superview predicate:nil];
    [texf_passWord alignTop:@"53" leading:@"50" toView:texf_passWord.superview];
    [texf_passWord constrainHeight:@"44"];
    
    [loginButton alignCenterXWithView:loginButton.superview predicate:nil];
    [loginButton alignTop:@"200" leading:@"0" toView:inputView];
    [loginButton constrainHeight:@"44"];
    
    [[loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [self login];
    }];
    
}

-(void)login
{
//    _loginSceneModel = [LoginSceneModel SceneModel];
//    
//    [[RACObserve(self.loginSceneModel.userinfo, token)
//      filter:^BOOL(NSNumber *state) {
//          
//          return self.loginSceneModel.userinfo.token;
//      }]
//     subscribeNext:^(id x) {
//         
//         NSLog(@"%@",self.loginSceneModel.userinfo.token);
//         if (self.loginSceneModel.request.requestSatatus == YES) {
//             
//             [DFProgressHUD showWithCustomView:@"登录成功" view:KEYWINDOW];
//             [self dismissViewControllerAnimated:YES completion:nil];
//             NSLog(@"%@",self.loginSceneModel.userinfo.token);
//         }
//     }];
//    SHOW_ALERT(@"提示", @"用户名密码有误", nil, nil, @"确定", 0);
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"登录成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    [alert show];
    [[NSUserDefaults standardUserDefaults] setObject:@"hudingfeng_haha" forKey:@"token"];
    [DFProgressHUD showWithCustomView:@"登录成功" view:APPDELEGATE.window];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)leftButtonTouch
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

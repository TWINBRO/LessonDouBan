//
//  LoginViewController.m
//  LessonDouBan
//
//  Created by lanou3g on 16/6/29.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginRequest.h"
#import "RegisterViewController.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (assign, nonatomic) BOOL isLogin;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)loginButtonClicked:(id)sender {
    // 登录
    [self login];
    
    
}
- (IBAction)registerButtonClicked:(UIButton *)sender {
    UIStoryboard *mainSb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    RegisterViewController *registerVC = [mainSb instantiateViewControllerWithIdentifier:@"RegisterViewController"];
    [self presentViewController:registerVC animated:YES completion:^{
        
    }];
}

- (void)login {

    // 验证,判断用户名密码
    if ([self.usernameTextField.text length] == 0) {
        NSLog(@"用户名为空");
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名不能为空" delegate:self cancelButtonTitle:@"请重新输入" otherButtonTitles: nil];
        [alertView show];
        [self.view addSubview:alertView];
    }else if ([self.passwordTextField.text length] == 0){
        NSLog(@"密码为空");
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码不能为空" delegate:self cancelButtonTitle:@"请重新输入" otherButtonTitles: nil];
        [alertView show];
        [self.view addSubview:alertView];
        
    }else{
    LoginRequest *request = [[LoginRequest alloc]init];
    [request loginRequestWithUsername:self.usernameTextField.text password:self.passwordTextField.text success:^(NSDictionary *dic) {
        NSLog(@"login success = %@",dic);
        long code = [[dic objectForKey:@"code"] longValue];
//        NSString *code = [[dic objectForKey:@"code"] stringValue];
        if (code == 1103) {
            
            _isLogin = YES;
            
            NSString *login = [NSString stringWithFormat:@"%d",_isLogin];
            NSString *avatar = [[dic objectForKey:@"data"] objectForKey:@"avatar"];
            NSString *userId = [[dic objectForKey:@"data"]objectForKey:@"userId"];
            // 保存头像和id以及是否登录到本地
            [[NSUserDefaults standardUserDefaults]setObject:avatar forKey:@"avatar"];
            [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"userId"];
            [[NSUserDefaults standardUserDefaults]setObject:login forKey:@"isLogin"];
            
            [[NSUserDefaults standardUserDefaults]setObject:self.usernameTextField.text forKey:userId];
            [[NSUserDefaults standardUserDefaults]setObject:self.usernameTextField.text forKey:@"userName"];
            // 立即保存
            [[NSUserDefaults standardUserDefaults] synchronize];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"登录成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
            [self.view addSubview:alertView];
            // 登录成功之后消失
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"login failure = %@",error);
    }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  RegisterViewController.m
//  LessonDouBan
//
//  Created by lanou3g on 16/6/29.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterRequest.h"
@interface RegisterViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *avatorImagView;

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (nonatomic, strong) UIImagePickerController *imagePicker; // 图片选择器
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    
    self.avatorImagView.userInteractionEnabled = YES;
    
    
}
// 点击注册按钮
- (IBAction)registerButtonClicked:(UIButton *)sender {
    
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
    
    RegisterRequest *request = [[RegisterRequest alloc]init];
//    request registerWithName: password:<#(NSString *)#> avator:[UIImage imageNamed:@"person.png"] success:<#^(NSDictionary *dic)success#> failure:<#^(NSError *error)failure#>
    
    [request registerWithName:self.usernameTextField.text password:self.passwordTextField.text avator:self.avatorImagView.image success:^(NSDictionary *dic) {
        NSLog(@"register success = %@",dic);
        
        NSString *code = [[dic objectForKey:@"code"] stringValue];
        if ([code isEqualToString:@"1005"]) {
            NSString *avatar = [[dic objectForKey:@"data"] objectForKey:@"avatar"];
            NSString *userId = [[dic objectForKey:@"data"]objectForKey:@"userId"];
            // 保存头像和id到本地
            [[NSUserDefaults standardUserDefaults]setObject:avatar forKey:@"avatar"];
            [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"userId"];
            // 立即保存
            [[NSUserDefaults standardUserDefaults] synchronize];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"注册成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
            [self.view addSubview:alertView];
            // 界面消失
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"register failure = %@",error);
    }];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    // 显示头像
    self.avatorImagView.image = image;
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(saveImage), nil);
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    // 隐藏图片选择页面
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)saveImage {
    
    NSLog(@"存储图片");
    
}
// 点击头像的方法
- (IBAction)tapAvatarImage:(id)sender {
    
    // 添加alertsheet
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 指定图片来源
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        _imagePicker.allowsEditing = YES;
        [self presentViewController:_imagePicker animated:YES completion:^{
            
        }];
    }];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        _imagePicker.allowsEditing = YES;
        [self presentViewController:_imagePicker animated:YES completion:nil];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:photoAction];
    [alert addAction:cameraAction];
    [alert addAction:cancelAction];
    // 显示alertController
    [self presentViewController:alert animated:YES completion:nil];
}

/**
 * 点击空白处执行此方法
 */
- (IBAction)tapEmpty:(id)sender {
    
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

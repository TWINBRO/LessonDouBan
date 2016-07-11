//
//  MyViewController.m
//  LessonDouBan
//
//  Created by lanou3g on 16/6/28.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "MyViewController.h"
#import "LoginViewController.h"
#import "MyHeaderTableViewCell.h"
#import "MyTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "MyActivityTableViewController.h"

@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *MyTableView;
@property (nonatomic, strong) NSArray *titles;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titles = @[@"我的活动",@"我的电影",@"清除缓存",@"退出登录"];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addRightNavigationItem];
    self.MyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.MyTableView registerNib:[UINib nibWithNibName:@"MyHeaderTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:MyHeaderTableViewCell_Identify];
    
    [self.MyTableView registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:MyTableViewCell_Identify];
}

- (void)addRightNavigationItem {

    // 自定义rightBarButton
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"登录" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:38.0/255 green:217.0/255 blue:165.0/255 alpha:1] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 40, 30);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btn addTarget:self action:@selector(rightBarItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)rightBarItemClicked:(UIButton *)btn {

    
    //NSLog(@"..");
    // 跳转到登录页面
    UIStoryboard *mainSb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    LoginViewController *loginVC = [mainSb instantiateViewControllerWithIdentifier:@"LoginViewController"];
    
    [self presentViewController:loginVC animated:YES completion:^{
        
    }];
    
}
// 计算缓存
-(float)getFilePath{
    
    //文件管理
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //缓存路径
    
    NSArray *cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
    
    NSString *cacheDir = [cachePaths objectAtIndex:0];
    
    NSArray *cacheFileList;
    
    NSEnumerator *cacheEnumerator;
    
    NSString *cacheFilePath;
    
    unsigned long long cacheFolderSize = 0;
    
    cacheFileList = [fileManager subpathsOfDirectoryAtPath:cacheDir error:nil];
    
    cacheEnumerator = [cacheFileList objectEnumerator];
    
    while (cacheFilePath = [cacheEnumerator nextObject]) {
        
        NSDictionary *cacheFileAttributes = [fileManager attributesOfItemAtPath:[cacheDir stringByAppendingPathComponent:cacheFilePath] error:nil];
        
        cacheFolderSize += [cacheFileAttributes fileSize];
        
    }
    
    //单位KB
    return cacheFolderSize/1024;
    
}

// 清除缓存
- (void)removeCache {

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    
    NSString *path = [paths lastObject];
    NSString *str = [NSString stringWithFormat:@"缓存已清除%.1fK", [self getFilePath]];
    NSLog(@"%@",str);
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"缓存已清除" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
    [self.view addSubview:alertView];
    
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:path];
    
    for (NSString *p in files) {
        
        NSError *error;
        
        NSString *Path = [path stringByAppendingPathComponent:p];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:Path]) {
            
            [[NSFileManager defaultManager] removeItemAtPath:Path error:&error];
            
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        return 170;
    }
    return 40;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 5;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        MyHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyHeaderTableViewCell_Identify];
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin"]) {
            NSString *avatarUrl = [[NSUserDefaults standardUserDefaults] objectForKey:@"avatar"];
            [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",USER_AVATAR_LOCAL_URL,avatarUrl]]];
            cell.usernameLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
        }
        
        
        return cell;
    }
    else{
    
        MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyTableViewCell_Identify];
        
        cell.contentLabel.text = self.titles[indexPath.row - 1];
        if (indexPath.row == 3) {
            cell.subcontentLabel.text = [NSString stringWithFormat:@"%.1fK",[self getFilePath]];
        }
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 3) {
        [self removeCache];
        [self.MyTableView reloadData];
    }
    
    if (indexPath.row == 1) {
        MyActivityTableViewController *myActivityVC = [MyActivityTableViewController new];
        myActivityVC.username = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
        [self.navigationController pushViewController:myActivityVC animated:YES];
    }
    
    if (indexPath.row == 4) {
        NSString *lastUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
        [[NSUserDefaults standardUserDefaults] setObject:lastUserID forKey:@"lastUserID"];
        [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isLogin"];
        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"avatar"];
        [[NSUserDefaults standardUserDefaults] setObject:@"未登录" forKey:@"userName"];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已退出登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        [self.view addSubview:alertView];
        
        [self.MyTableView reloadData];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {

    [self.MyTableView reloadData];
    
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

//
//  RootViewController.m
//  LessonDouBan
//
//  Created by lanou3g on 16/6/28.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "RootViewController.h"
#import "DouBanTabBar.h"
#import "ActivityViewController.h"
#import "MovieViewController.h"
#import "TheaterViewController.h"
#import "MyViewController.h"
@interface RootViewController ()<DouBanTabBarDelegate>
@property (nonatomic, strong) DouBanTabBar *dbTabBar;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.hidden = YES;
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];

    [btn1 setImage:[UIImage imageNamed:@"paper.png"] forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"paperH.png"] forState:UIControlStateSelected];
    btn1.imageEdgeInsets = UIEdgeInsetsMake(5,13,21,btn1.titleLabel.bounds.size.width);//设置image在button上的位置（上top，左left，下bottom，右right）这里可以写负值，对上写－5，那么image就象上移动5个像素
    [btn1 setTitle:@"活动" forState:UIControlStateNormal];//设置button的title
    btn1.titleLabel.font = [UIFont systemFontOfSize:13];//title字体大小
    btn1.titleLabel.textAlignment = NSTextAlignmentCenter;//设置title的字体居中
    [btn1 setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];//设置title在一般情况下为白色字体
    [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];//设置title在button被选中情况下为灰色字体
    btn1.titleEdgeInsets = UIEdgeInsetsMake(30, -btn1.titleLabel.bounds.size.width-50, 0, 0);//设置title在button上的位置（上top，左left，下bottom，右right）
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setImage:[UIImage imageNamed:@"video.png"] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"videoH.png"] forState:UIControlStateSelected];
    btn2.imageEdgeInsets = UIEdgeInsetsMake(5,13,21,btn2.titleLabel.bounds.size.width);
    [btn2 setTitle:@"电影" forState:UIControlStateNormal];//设置button的title
    btn2.titleLabel.font = [UIFont systemFontOfSize:13];//title字体大小
    btn2.titleLabel.textAlignment = NSTextAlignmentCenter;//设置title的字体居中
    [btn2 setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];//设置title在一般情况下为白色字体
    [btn2 setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    btn2.titleEdgeInsets = UIEdgeInsetsMake(30, -btn2.titleLabel.bounds.size.width-50, 0, 0);
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn3 setImage:[UIImage imageNamed:@"2image.png"] forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"2imageH.png"] forState:UIControlStateSelected];
    btn3.imageEdgeInsets = UIEdgeInsetsMake(5,13,21,btn3.titleLabel.bounds.size.width);
    [btn3 setTitle:@"影院" forState:UIControlStateNormal];//设置button的title
    btn3.titleLabel.font = [UIFont systemFontOfSize:13];//title字体大小
    btn3.titleLabel.textAlignment = NSTextAlignmentCenter;//设置title的字体居中
    [btn3 setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    btn3.titleEdgeInsets = UIEdgeInsetsMake(30, -btn3.titleLabel.bounds.size.width-50, 0, 0);
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn4 setImage:[UIImage imageNamed:@"person.png"] forState:UIControlStateNormal];
    [btn4 setImage:[UIImage imageNamed:@"personH.png"] forState:UIControlStateSelected];
    btn4.imageEdgeInsets = UIEdgeInsetsMake(5,13,21,btn4.titleLabel.bounds.size.width);
    [btn4 setTitle:@"我的" forState:UIControlStateNormal];//设置button的title
    btn4.titleLabel.font = [UIFont systemFontOfSize:13];//title字体大小
    btn4.titleLabel.textAlignment = NSTextAlignmentCenter;//设置title的字体居中
    [btn4 setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [btn4 setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    btn4.titleEdgeInsets = UIEdgeInsetsMake(30, -btn4.titleLabel.bounds.size.width-50, 0, 0);
    
    self.dbTabBar = [[DouBanTabBar alloc] initWithItems:@[btn1,btn2,btn3,btn4] frame:CGRectMake(0, WindowHeight - 50, WindownWidth, 50)] ;
  
    [self.view addSubview:self.dbTabBar];
    self.dbTabBar.doubanDelegate = self;
    
}

- (void)douBanItemDidClicked:(DouBanTabBar *)tabBar {
    self.selectedIndex = tabBar.currentSelected;
    //self.selectedViewController = [self.viewControllers objectAtIndex:tabBar.currentSelected];
    
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

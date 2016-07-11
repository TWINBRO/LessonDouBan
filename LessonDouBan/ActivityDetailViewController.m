//
//  ActivityDetailViewController.m
//  LessonDouBan
//
//  Created by lanou3g on 16/6/30.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "ActivityDetailViewController.h"

@interface ActivityDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagsLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@property (nonatomic, assign) BOOL isCollect;
@property (weak, nonatomic) IBOutlet UIImageView *activityImageView;

@property (strong, nonatomic) NSMutableArray *urlArray;
@property (assign, nonatomic) NSInteger count;

@end

@implementation ActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.model.title;
    self.titleLabel.text = self.model.title;
    self.timeLabel.text = [NSString stringWithFormat:@"%@--%@",self.model.begin_time,self.model.end_time ];
    self.tagsLabel.text = self.model.tags;
    self.activityTypeLabel.text = self.model.category;
    self.addressLabel.text = self.model.address;
    self.contentTextView.text = self.model.content;
    [self.activityImageView setImageWithURL:[NSURL URLWithString:self.model.image]];
    
    
    [self addRightNavigationItem];
    
}

- (void)addRightNavigationItem {
    
    // 自定义rightBarButton
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];

    
    NSString *string1 = [[NSUserDefaults standardUserDefaults] objectForKey:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"]];
    NSString *string2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    NSString *string3 = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%@",self.model.title,string2]];
    if ([self.model.adapt_url isEqualToString:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:self.model.title]]]&&[[[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin"] isEqualToString:@"1"]&&[string1 isEqualToString:string2]&&[string3 isEqualToString:self.model.title]) {
        
            [button setImage:[UIImage imageNamed:@"ysc"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"yscH"] forState:UIControlStateHighlighted];
            self.isCollect = YES;
       
        
    }else{
    
        [button setImage:[UIImage imageNamed:@"sc"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"scH"] forState:UIControlStateHighlighted];
        self.isCollect = NO;
    }
    button.frame = CGRectMake(0, 0, 40, 30);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    [button addTarget:self action:@selector(rightBarItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)rightBarItemClicked:(UIButton *)button {
    
    if (_isCollect) {
        
        [button setImage:[UIImage imageNamed:@"sc"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"scH"] forState:UIControlStateHighlighted];
        _isCollect = NO;
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:self.model.title];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:self.model.ID];
    }else {
        
        [button setImage:[UIImage imageNamed:@"ysc"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"yscH"] forState:UIControlStateHighlighted];
        _isCollect = YES;
        NSString *collectUrl = self.model.adapt_url;
        NSString *string = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
        NSString *collect = [NSString stringWithFormat:@"%d",self.isCollect];
        
        [[NSUserDefaults standardUserDefaults] setObject:collectUrl forKey:[NSString stringWithFormat:@"%@%ld",string,(long)self.count]];
        [[NSUserDefaults standardUserDefaults] setObject:collectUrl forKey:self.model.title];
        [[NSUserDefaults standardUserDefaults] setObject:collect forKey:self.model.ID];
        [[NSUserDefaults standardUserDefaults] setObject:self.model.title forKey:[NSString stringWithFormat:@"%@%@",self.model.title,string]];
        [[NSUserDefaults standardUserDefaults] synchronize];
        self.count++;
        
    }
    NSLog(@"%ld",self.count);
    
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

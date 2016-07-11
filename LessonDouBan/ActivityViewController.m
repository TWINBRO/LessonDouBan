//
//  ActivityViewController.m
//  LessonDouBan
//
//  Created by lanou3g on 16/6/28.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "ActivityViewController.h"
#import "ActivityTableViewCell.h"
#import "ActivityRequest.h"
#import "ActivityDetailViewController.h"
#import "ActivityModel.h"
@interface ActivityViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *activityTableView;
// 所有活动
@property (nonatomic,strong) NSMutableArray *activities;

@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.activityTableView registerNib:[UINib nibWithNibName:@"ActivityTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ActivityTableViewCell_Identify];
    
    
    [self requestActivityData];
}
#pragma mark - 添加loading信息
- (void)p_setupProgressHud
{
    [GiFHUD setGifWithImageName:@"pika.gif"];
    [GiFHUD show];
    
}
- (NSMutableArray *)activities {

    if (!_activities) {
        _activities = [NSMutableArray array];
    }
    return _activities;
    
}

// 活动
- (void)requestActivityData {
    [self p_setupProgressHud];
    __weak typeof(self) weakSelf = self;
    ActivityRequest *activity = [[ActivityRequest alloc] init];
    [activity activityRequestWithParameter:nil success:^(NSDictionary *dic) {
        
        NSArray *events = [dic objectForKey:@"events"];
        for (NSDictionary *tempDic in events) {
            ActivityModel *model = [[ActivityModel alloc] init];
            [model setValuesForKeysWithDictionary:tempDic];
            [weakSelf.activities addObject:model];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [GiFHUD dismiss];
            [weakSelf reloadAllData];
        });
        
        //NSLog(@"activities = %@",weakSelf.activities);
    } failure:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
    
}
// 刷新数据
- (void) reloadAllData {
    
    [self.activityTableView reloadData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.activities.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 167;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ActivityTableViewCell_Identify];
    ActivityModel *model = self.activities[indexPath.row];
    cell.model = model;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
    ActivityModel *model = self.activities[indexPath.row];
    [self performSegueWithIdentifier:@"activityDetail" sender:model];
    
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"activityDetail"]) {
        ActivityDetailViewController *detailVC = segue.destinationViewController;
        detailVC.model = sender;
    }
    
}


@end

//
//  TheaterViewController.m
//  LessonDouBan
//
//  Created by lanou3g on 16/6/28.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "TheaterViewController.h"
#import "TheaterModel.h"
#import "TheaterRequest.h"
#import "TheaterTableViewCell.h"
#import "TheaterMapViewController.h"
@interface TheaterViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray *cinames;

@property (weak, nonatomic) IBOutlet UITableView *cinameTableView;
@end

@implementation TheaterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.cinameTableView registerNib:[UINib nibWithNibName:@"TheaterTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:TheaterTableViewCell_Identify];
    self.cinames = [NSMutableArray array];
    
    [self requestTheaterData];
    
}

#pragma mark - 添加loading信息
- (void)p_setupProgressHud
{
    [GiFHUD setGifWithImageName:@"pika.gif"];
    [GiFHUD show];
    
}

// 影院
- (void)requestTheaterData {
    [self p_setupProgressHud];
    __weak typeof(self) weakSelf = self;
    TheaterRequest *theatre = [[TheaterRequest alloc] init];
    [theatre theaterRequestWithParameter:nil success:^(NSDictionary *dic) {
        
        NSArray *theaters = [[dic objectForKey:@"result"] objectForKey:@"data"];
        for (NSDictionary *tempDic in theaters) {
            TheaterModel *model = [[TheaterModel alloc] init];
            [model setValuesForKeysWithDictionary:tempDic];
            [weakSelf.cinames addObject:model];
            NSLog(@"success = %@",dic);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [GiFHUD dismiss];
            [weakSelf.cinameTableView reloadData];
        });
    } failure:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.cinames.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 157;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TheaterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TheaterTableViewCell_Identify];
    TheaterModel *model = self.cinames[indexPath.row];
    cell.model = model;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    TheaterMapViewController *mapVC = [[TheaterMapViewController alloc]init];
    mapVC.model = self.cinames[indexPath.row];
    [self.navigationController pushViewController:mapVC animated:YES];
    
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

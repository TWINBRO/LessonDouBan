//
//  MovieViewController.m
//  LessonDouBan
//
//  Created by lanou3g on 16/6/28.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "MovieViewController.h"
#import "MovieRequest.h"
#import "MovieModel.h"
#import <UMSocialSnsService.h>
#import <UMSocial.h>
#import "MovieTableViewCell.h"
#import "MovieDetailViewController.h"
@interface MovieViewController ()<UMSocialUIDelegate,UITableViewDataSource,UITableViewDelegate>
// 所有电影
@property (nonatomic,strong) NSMutableArray *movies;
@property (weak, nonatomic) IBOutlet UITableView *movieTableView;

@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.movieTableView registerNib:[UINib nibWithNibName:@"MovieTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:MovieTableViewCell_Identify];
    self.movies = [NSMutableArray array];
    [self addRightNavigationItem];
    [self requestMovieData];
}

#pragma mark - 添加loading信息
- (void)p_setupProgressHud
{
    [GiFHUD setGifWithImageName:@"pika.gif"];
    [GiFHUD show];
    
}
// 电影
- (void)requestMovieData {
    [self p_setupProgressHud];
    __weak typeof(self) weakSelf= self;
    MovieRequest *movie = [[MovieRequest alloc] init];
    [movie movieRequestWithParameter:nil success:^(NSDictionary *dic) {
        
        //NSLog(@"success = %@",dic);
        NSString *movieTitle = [dic objectForKey:@"title"];
        NSArray *tempMovies = [dic objectForKey:@"entries"];
        for (NSDictionary *tempDic in tempMovies) {
            MovieModel *model = [[MovieModel alloc] init];
            [model setValuesForKeysWithDictionary:tempDic];
            [weakSelf.movies addObject:model];
        }
        // 刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            [GiFHUD dismiss];
            [weakSelf.movieTableView reloadData];
        });
        //NSLog(@"weakSelf movies = %@",weakSelf.movies);
        
    } failure:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
    
}

- (void)addRightNavigationItem {
    
    // 自定义rightBarButton
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"分享" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:38.0/255 green:217.0/255 blue:165.0/255 alpha:1] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 40, 30);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btn addTarget:self action:@selector(rightBarItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)rightBarItemClicked:(UIButton *)btn {
    
    //如果需要分享回调，请将delegate对象设置self，并实现下面的回调方法
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5773af96e0f55a0ed80012a3"
                                      shareText:@"友盟社会化分享让您快速实现分享等社会化功能，http://umeng.com/social" // 分享的内容
                                     shareImage:nil
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone,UMShareToSina]
                                       delegate:self];
    
}

// 实现回调方法
- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response {
    
    // 根据responseCode得到发送的结果
    if (response.responseCode == UMSResponseCodeSuccess) {
        NSLog(@"分享成功");
    }else {
        NSLog(@"%d",response.responseCode);
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.movies.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MovieTableViewCell_Identify];
    MovieModel *model = self.movies[indexPath.row];
    cell.model = model;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 170;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    MovieModel *model = self.movies[indexPath.row];
    
    [self performSegueWithIdentifier:@"movieDetail" sender:model];
    
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"movieDetail"]) {
        MovieDetailViewController *movieVC = segue.destinationViewController;
        
        movieVC.model = sender;
    }
    
}


@end

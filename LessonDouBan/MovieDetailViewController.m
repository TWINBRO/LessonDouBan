//
//  MovieDetailViewController.m
//  LessonDouBan
//
//  Created by lanou3g on 16/6/30.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "MovieDetailModel.h"
#import "MovieDetailRequest.h"

@interface MovieDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationsLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
//@property (strong, nonatomic) MovieDetailModel *detailModel;
@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.model.title;
    NSLog(@"%@",self.model.title);
    [self requestMovieDetailDataWith:self.model.ID];
    
}

#pragma mark - 添加loading信息
- (void)p_setupProgressHud
{
    [GiFHUD setGifWithImageName:@"pika.gif"];
    [GiFHUD show];
    
}
// 电影详情
- (void)requestMovieDetailDataWith:(NSString *)ID {
    [self p_setupProgressHud];
    __weak typeof(self) weakSelf = self;
    MovieDetailRequest *request =  [[MovieDetailRequest alloc] init];
    [request movieDetailRequestWithParameter:@{@"id":ID} success:^(NSDictionary *dic) {
        
       
        MovieDetailModel *detailModel = [[MovieDetailModel alloc] init];
        [detailModel setValuesForKeysWithDictionary:dic];
        // 显示
        dispatch_async(dispatch_get_main_queue(), ^{
            [GiFHUD dismiss];
            [weakSelf showInfoToSubviews:detailModel];
        });
        
    } failure:^(NSError *error) {
        NSLog(@"movie detail error = %@",error);
    }];
    
}

- (void) showInfoToSubviews:(MovieDetailModel *)detailModel {
    
    [self.movieImageView setImageWithURL:[NSURL URLWithString:detailModel.images[@"large"]]];
    
    //
    _ratingLabel.text = [NSString stringWithFormat:@"评分：%@  (%@评论)",detailModel.rating[@"average"],detailModel.comments_count];
    _timeLabel.text = detailModel.pubdate;
    _movieTypeLabel.text = [self getStringWithArray:detailModel.genres];
    _durationsLabel.text = [self getStringWithArray:detailModel.durations];
    _countryLabel.text = [self getStringWithArray:detailModel.countries];
    _contentTextView.text = detailModel.summary;
    
}
// 数组转换为字符串
- (NSString *)getStringWithArray:(NSArray *)array {
    
    NSMutableString *str = [NSMutableString string];
    for (NSString * obj in array) {
        [str appendFormat:@"%@ ",obj];
    }
    return str;
    
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

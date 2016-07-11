//
//  TheaterTableViewCell.h
//  LessonDouBan
//
//  Created by lanou3g on 16/6/30.
//  Copyright © 2016年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TheaterModel.h"
#define TheaterTableViewCell_Identify @"TheaterTableViewCell_Identify"
@interface TheaterTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (strong, nonatomic) TheaterModel *model;
@end

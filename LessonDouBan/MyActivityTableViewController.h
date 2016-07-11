//
//  MyActivityTableViewController.h
//  LessonDouBan
//
//  Created by lanou3g on 16/7/2.
//  Copyright © 2016年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityModel.h"
@interface MyActivityTableViewController : UITableViewController
@property (strong,nonatomic) ActivityModel *model;
@property (copy, nonatomic) NSString *username;
@end

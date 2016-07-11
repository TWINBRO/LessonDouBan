//
//  DouBanTabBar.h
//  LessonDouBan
//
//  Created by lanou3g on 16/6/28.
//  Copyright © 2016年 yu. All rights reserved.
//
@class DouBanTabBar;
@protocol DouBanTabBarDelegate <NSObject>

- (void)douBanItemDidClicked:(DouBanTabBar *)tabBar;

@end

#import <UIKit/UIKit.h>

@interface DouBanTabBar : UITabBar

@property (nonatomic, assign) int currentSelected; // 当前选中的tabbar的下标
@property (nonatomic, strong) UIButton *currentSelectedItem; // 当前选中的item
@property (nonatomic, strong) NSArray *allItems; // tabbar上面所有的item

@property (nonatomic, weak) id<DouBanTabBarDelegate> doubanDelegate;

- (id)initWithItems:(NSArray *)items frame:(CGRect)frame; // 初始化方法:根据items初始化items

@end

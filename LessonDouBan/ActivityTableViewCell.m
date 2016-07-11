//
//  ActivityTableViewCell.m
//  LessonDouBan
//
//  Created by lanou3g on 16/6/30.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "ActivityTableViewCell.h"

@implementation ActivityTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ActivityModel *)model {

    if (_model != model) {
        _model = nil;
    
    _model = model;
    self.titleLabel.text = model.title;
    self.dateLabel.text = [NSString stringWithFormat:@"%@-%@",model.begin_time,model.end_time];
    self.addressLabel.text = model.address;
    self.activityTypeLabel.text = model.category;
    //self.interestingNumberLabel.text = model.wisher_count;
    //self.joinNumberLabel.text = model.participant_count;
    
        self.interestingNumberLabel.text = [NSString stringWithFormat:@"%ld",model.wisher_count];
        self.joinNumberLabel.text = [NSString stringWithFormat:@"%ld",model.participant_count];
        
    [self.activityImageView setImageWithURL:[NSURL URLWithString:model.image]];
    }
}

@end

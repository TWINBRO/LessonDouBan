//
//  TheaterTableViewCell.m
//  LessonDouBan
//
//  Created by lanou3g on 16/6/30.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "TheaterTableViewCell.h"

@implementation TheaterTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(TheaterModel *)model {
    
    if (_model != model) {
        _model = nil;
        _model = model;
        self.titleLabel.text = model.cinemaName;
        self.addressLabel.text = model.address;
        self.phoneNumberLabel.text = model.telephone;
    }
    
}
@end

//
//  MovieTableViewCell.m
//  LessonDouBan
//
//  Created by lanou3g on 16/6/30.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "MovieTableViewCell.h"

@implementation MovieTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(MovieModel *)model {

    if (_model != model) {
        _model = nil;
        _model = model;
        self.titleLabel.text = model.title;
        self.rankLabel.text = model.stars;
        self.timeLabel.text = model.pubdate;
        [self.movieImageView setImageWithURL:[NSURL URLWithString:[model.images valueForKey:@"large"]]];
    }
    
}

@end

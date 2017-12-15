//
//  AudioCell.m
//  MusicPlayerDemo
//
//  Created by shuai pan on 2017/12/15.
//  Copyright © 2017年 BSL. All rights reserved.
//

#import "AudioCell.h"

@implementation AudioCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  AudioCell.h
//  MusicPlayerDemo
//
//  Created by shuai pan on 2017/12/15.
//  Copyright © 2017年 BSL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AudioCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *thumb_img;
@property (strong, nonatomic) IBOutlet UILabel *song_name;
@property (strong, nonatomic) IBOutlet UILabel *songer;

@end

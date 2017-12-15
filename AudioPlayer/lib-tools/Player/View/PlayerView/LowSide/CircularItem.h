//
//  CircularItem.h
//  AudioPlayer
//
//  Created by shuai pan on 2017/2/13.
//  Copyright © 2017年 ClaudeLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircularItem : UIImageView
- (id)initWithFrame:(CGRect)frame circularImages:(NSArray*)arrays;

- (void)addMenuClickActionMethod:(void(^)(NSInteger selectValue))selectBlock;




@end

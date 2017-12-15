//
//  CircularItem.m
//  AudioPlayer
//
//  Created by shuai pan on 2017/2/13.
//  Copyright © 2017年 ClaudeLi. All rights reserved.
//

#import "CircularItem.h"


static NSInteger clickValue;

@interface CircularItem()


@property (nonatomic ,assign)BOOL circularIncrease;
@property(nonatomic, copy)void((^menuClickActionBlock)(NSInteger selectValue));

@property (nonatomic, strong)NSArray *imageArray;


@end
@implementation CircularItem

//@end

- (id)initWithFrame:(CGRect)frame circularImages:(NSArray*)arrays {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageArray = arrays;
        if (self.imageArray) {
            UITapGestureRecognizer *gap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAction)];
            [self addGestureRecognizer:gap];
            self.userInteractionEnabled  = YES;
            self.image = [UIImage imageNamed:arrays[0]];
            self.circularIncrease = YES;
        }
    }
    return self;
}

- (void)addMenuClickActionMethod:(void(^)(NSInteger selectValue))selectBlock{
    self.menuClickActionBlock = selectBlock;
}



#pragma  mark Private Method ************************
- (void)clickAction{
    clickValue++;
    if (clickValue==self.imageArray.count) {
        clickValue = 0;
    }
    self.image = [UIImage imageNamed:self.imageArray[clickValue]];
    if (self.menuClickActionBlock) {
        self.menuClickActionBlock(clickValue);
    }
}












@end

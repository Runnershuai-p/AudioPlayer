//
//  MenuItem.m
//  TestDemo
//
//  Created by shuai pan on 2016/12/15.
//  Copyright © 2016年 BSL. All rights reserved.
//

#import "ItemButton.h"



typedef void(^MenuClickAction)(BOOL);
@interface ItemButton(){
}
@property(nonatomic, copy)MenuClickAction menuClickActionBlock;
@property (nonatomic, strong)NSArray *imageArray;

@end
@implementation ItemButton

- (id)initWithFrame:(CGRect)frame backgroundImage:(NSString*)bgImage selectImage:(NSString*)slImage{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageArray = [self mergeAndCheckArray:bgImage selectImage:slImage];
        UITapGestureRecognizer *gap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAction)];
        [self addGestureRecognizer:gap];
        self.userInteractionEnabled  = YES;
        self.image = [UIImage imageNamed:self.imageArray[0]];

    }
    return self;
}

- (void)addMenuClickActionMethod:(void(^)(BOOL isSelect))selectBlock{
    self.menuClickActionBlock = selectBlock;
}



#pragma  mark Private Method ************************
- (void)clickAction{
    self.itemSelect = !self.itemSelect;
    if (self.menuClickActionBlock) {
        self.menuClickActionBlock(self.itemSelect);
    }
}
- (void)setItemSelect:(BOOL)itemSelect{
    _itemSelect = itemSelect;
    if (!_itemSelect) {
        self.image = [UIImage imageNamed:self.imageArray[0]];
    }
    else{
        self.image = [UIImage imageNamed:self.imageArray[1]];
    }
}
- (NSArray*)mergeAndCheckArray:(NSString*)bgImage selectImage:(NSString*)slImage{
    if (bgImage) {
        if (slImage) {
            return @[bgImage,slImage];
        }else{
            return @[bgImage,bgImage];
        }
    }
    else{
        if (slImage) {
            return @[slImage,slImage];
        }
        else{
            return @[@"",@""];
        }
    }
}





@end

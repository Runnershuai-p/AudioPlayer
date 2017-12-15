//
//  MenuItem.h
//  TestDemo
//
//  Created by shuai pan on 2016/12/15.
//  Copyright © 2016年 BSL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemButton : UIImageView

@property (nonatomic ,assign)BOOL itemSelect;


- (id)initWithFrame:(CGRect)frame backgroundImage:(NSString*)bgImage selectImage:(NSString*)slImage;

- (void)addMenuClickActionMethod:(void(^)(BOOL isSelect))selectBlock;


@end



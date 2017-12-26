//
//  MusicPalyController.m
//  MusicPlayerDemo
//
//  Created by shuai pan on 2017/2/9.
//  Copyright © 2017年 ClaudeLi. All rights reserved.
//

#import "MusicPlayerController.h"
#import "MusicPlayer.h"
#import "MusicModel.h"




@interface MusicPlayerController ()

@property (nonatomic ,strong)MusicPlayer *musicView;



@end
@implementation MusicPlayerController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.musicView];
    self.musicView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.musicView.songsArr = self.musicList;
    __weak typeof(self) weakSelf = self;
    [self.musicView dismissPlayer:^(BOOL dissmiss) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];


}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}









- (MusicPlayer *)musicView{
    if (!_musicView) {
        CGFloat y = 0;//CGRectGetMaxY(self.navigationItem.frame);
        CGFloat w = CGRectGetWidth(self.view.bounds);
        CGFloat h = CGRectGetHeight(self.view.bounds) - y;
        _musicView = [[MusicPlayer alloc]initWithFrame:CGRectMake(0, 0, w,h )];
    }
    return _musicView;
}
@end

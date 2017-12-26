//
//  ViewController.m
//  AudioPlayer
//
//  Created by shuai pan on 2017/12/15.
//  Copyright © 2017年 foreveross. All rights reserved.
//
#define AdjustsScrollViewInsetNever(controller,view) if(@available(iOS 11.0, *)) {view.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;} else if([controller isKindOfClass:[UIViewController class]]) {controller.automaticallyAdjustsScrollViewInsets = false;}


#import "AudionListController.h"
//#import "AudioCell.h"
#import "ClientRequestManger.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MusicModel.h"
#import "MusicPlayerController.h"
@interface AudionListController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)NSMutableArray *dataArray;

@end

@implementation AudionListController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithTitle:@"MusicPlayer" style:UIBarButtonItemStylePlain target:self action:@selector(openMusicPlayer)];
    self.navigationItem.rightBarButtonItem = barItem;
    [barItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    self.tableView.frame = self.view.bounds;
    [self.view addSubview: self.tableView];

    __weak typeof(self) weakSelf = self;
    
    [ClientRequestManger  GET:[APIServiceUrl apiAllAudios] parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([NSJSONSerialization isValidJSONObject:responseObject]) {
            NSArray *array = responseObject[@"data"];
            if (self.dataArray.count > 0) {
                [self.dataArray removeAllObjects];
            }
            for (NSDictionary *dict  in array) {
                MusicModel *model = [[MusicModel alloc] initWithDictionary:dict];
                [weakSelf.dataArray addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
            });
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
 
}
- (void)openMusicPlayer{
    MusicPlayerController *music = [[MusicPlayerController alloc]init];
    music.musicList = self.dataArray;
    [self.navigationController pushViewController:music animated:YES];
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"audioCell"];
    if (!cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"audioCell"];
    }
    MusicModel *model = self.dataArray[indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.album_icon] placeholderImage:[UIImage imageNamed:@"icon-40pt@3x-1"]];
    cell.textLabel.text = model.singer;
    cell.detailTextLabel.text = model.song_name;
    return  cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    MusicModel *model = self.dataArray[indexPath.row];
    MusicPlayerController *music = [[MusicPlayerController alloc]init];
    music.musicList = @[model];
    [self.navigationController pushViewController:music animated:YES];
    
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:2];
    }
    return _dataArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end


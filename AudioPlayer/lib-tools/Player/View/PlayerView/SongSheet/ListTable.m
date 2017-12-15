//
//  ListTable.m
//  AudioPlayer
//
//  Created by shuai pan on 2017/3/6.
//  Copyright © 2017年 ClaudeLi. All rights reserved.
//

#import "ListTable.h"
#import "MusicModel.h"
#import "UIView+POPUPAnimation.h"

@interface ListTable () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UITableView *listTable;
@property (nonatomic ,strong)UIButton *downMenu;
@property (nonatomic ,strong)UILabel *headerTitle;

@property (nonatomic ,strong)NSArray *dataArray;
@property (nonatomic ,assign)BOOL showSongsList;

@property (nonatomic ,copy)void (^closeListTable)();
@property (nonatomic ,copy)void (^selectSongs)(MusicModel *);


@end
@implementation ListTable
#pragma mark Public Methods

- (void)selectSongSheet:(void(^)(MusicModel *model))selectBlock closeList:(void(^)())closeListBlock{
    self.selectSongs = selectBlock;
    self.closeListTable = closeListBlock;
}

- (void)updateSongSheet:(NSArray *)songs{
    self.dataArray = songs;
    if (self.dataArray.count<1) return;
    [self.listTable reloadData];
    self.showSongsList = YES;
}


#pragma mark Private Methods
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self listTableControls];
    }
    return self;
}
- (void)listTableControls{
    self.backgroundColor = [UIColor whiteColor];
//    self.hidden = YES;
    [self addSubview:self.downMenu];
    [self addSubview:self.headerTitle];
    [self addSubview:self.listTable];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat self_w = CGRectGetWidth(self.frame);
    CGFloat self_h = CGRectGetHeight(self.frame);
    self.headerTitle.frame = CGRectMake(0.0f, 0.0f, self_w, 45.f);
    self.downMenu.frame = CGRectMake(0.0f, self_h-35.0f, self_w, 35);
    self.listTable.frame = CGRectMake(0, CGRectGetMaxY(self.headerTitle.frame), self_w, self_h-CGRectGetHeight(self.headerTitle.frame)-CGRectGetHeight(self.downMenu.frame));

}












#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndetifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifier ];
    if (!cell) {
        cell  = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndetifier];
    }
    
//    cell.backgroundColor = [UIColor whiteColor];
    MusicModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.song_name;
    cell.detailTextLabel.text = model.singer;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.selectSongs) {
        MusicModel *model = self.dataArray[indexPath.row];
        self.selectSongs(model);
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self closeAnimationView];
    });

}



- (UITableView*)listTable{
    if (!_listTable) {
        _listTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _listTable.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _listTable.separatorInset = UIEdgeInsetsMake(0, 5, 0, 5);
        _listTable.delegate = self;
        _listTable.dataSource = self;
        _listTable.tableFooterView = [UIView new];
        _listTable.tableHeaderView = [UIView new];

        
    }
    return _listTable;
}


- (UIButton*)downMenu{
    if (!_downMenu) {
        _downMenu = [UIButton buttonWithType:UIButtonTypeCustom];
        [_downMenu setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        [_downMenu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_downMenu setTitle:@"关闭" forState:UIControlStateNormal];
        [_downMenu addTarget:self action:@selector(closeListTableClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _downMenu;
}
- (UILabel*)headerTitle{
    if (!_headerTitle) {
        _headerTitle = [[UILabel alloc]initWithFrame:CGRectZero];
        _headerTitle.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _headerTitle.text = @"歌曲表单";
        _headerTitle.font = [UIFont systemFontOfSize:15];
        _headerTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _headerTitle;
}

- (void)setShowSongsList:(BOOL)showSongsList{
    _showSongsList = showSongsList;
    _showSongsList? [self popUpAnimationView:self.listTableHeight]:[self closeAnimationView];
}


- (void)closeListTableClick{
    [self closeAnimationView];
    if (self.closeListTable) {
        self.closeListTable();
    }

}

- (void)dealloc{
    NSLog(@"listTable dealloc");
}

@end

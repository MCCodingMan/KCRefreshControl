//
//  ViewController.m
//  KCRefreshControl
//
//  Created by wr on 2019/8/9.
//  Copyright © 2019年 wanmengchao. All rights reserved.
//

#import "ViewController.h"
#import "KCRefreshControl.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource,KCRefreshControlDelegate>

@property (nonatomic, strong) UITableView *testTableView;

@property (nonatomic, strong) KCRefreshControl *refreshControl;

@property (nonatomic, assign) NSInteger rowNum;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] init];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"这是第%ld个Cell",indexPath.row + 1];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _rowNum;
}

- (void)initTableView {
    self.rowNum = 15;
    [self.view addSubview:self.testTableView];
    self.refreshControl = [KCRefreshControl registRefreshControlWithScrollView:_testTableView delegate:self];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"左边" style:UIBarButtonItemStylePlain target:self action:@selector(leftClick)];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"右边" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.leftBarButtonItem = leftItem;
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [titleButton setTitle:@"中间" forState:UIControlStateNormal];
    [titleButton addTarget:self action:@selector(titleClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
}

- (void)titleClick {
    self.rowNum = 5;
    [self.testTableView reloadData];
}

- (void)leftClick {
    self.rowNum = 40;
    [self.testTableView reloadData];
}

- (void)rightClick {
    self.rowNum = 20;
    [self.testTableView reloadData];
}

- (void)refreshControlWithControl:(KCRefreshControl *)refreshContrl refreshType:(KCRefreshControlType)refreshType {
    switch (refreshType) {
        case KCRefreshControlBottomWillLose:
            NSLog(@"底部刷新-将要放开");
            break;
        case KCRefreshControlTopWillLose:
            NSLog(@"顶部刷新-将要放开");
            break;
        case KCRefreshControlEnd:
            NSLog(@"刷新结束");
            break;
        case KCRefreshControlStatic:
            NSLog(@"静止状态");
            break;
        case KCRefreshControlTopLoading:
            NSLog(@"顶部刷新-加载中...");
            break;
        case KCRefreshControlTopStartDrap:
            NSLog(@"顶部刷新-开始下拉");
            break;
        case KCRefreshControlBottomLoading:
            NSLog(@"底部刷新-加载中...");
            break;
        case KCRefreshControlTopWillLoading:
            NSLog(@"顶部刷新-将要加载");
            break;
        case KCRefreshControlBottomStartDrap:
            NSLog(@"底部刷新-开始上拉");
            break;
        case KCRefreshControlBottomWillLoading:
            NSLog(@"底部刷新-将要加载");
        default:
            break;
    }
}

- (UITableView *)testTableView {
    if (!_testTableView) {
        _testTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _testTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _testTableView.delegate = self;
        _testTableView.dataSource = self;
        _testTableView.estimatedRowHeight = 40;
        _testTableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _testTableView;
}


@end

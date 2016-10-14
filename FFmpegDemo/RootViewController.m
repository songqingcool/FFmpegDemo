//
//  RootViewController.m
//  FFmpegDemo
//
//  Created by SONGQG on 2016/10/14.
//  Copyright © 2016年 思源. All rights reserved.
//

#import "RootViewController.h"
#import "InfoViewController.h"
#import "DecoderViewController.h"

@interface RootViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"FFmpeg Demos";
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.view addSubview:self.tableView];
    
    
    self.dataArray = @[@"FFmpeg config information",@"Decoder"];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        InfoViewController *info = [[InfoViewController alloc] init];
        [self.navigationController pushViewController:info animated:YES];
    }else if (indexPath.row == 1) {
        DecoderViewController *decoder = [[DecoderViewController alloc] init];
        [self.navigationController pushViewController:decoder animated:YES];
    }
}

@end

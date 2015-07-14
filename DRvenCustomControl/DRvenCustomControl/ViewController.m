//
//  ViewController.m
//  DRvenCustomControl
//
//  Created by rimi on 15/7/13.
//  Copyright © 2015年 RIMI. All rights reserved.
//

#import "ViewController.h"
#import "DRDownMenuViewController.h"
#import "DRBannerViewController.h"

@interface ViewController ()

@end

static NSString * cellIndentifier = @"coustomCell";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"自定义下拉菜单";
    }else if (indexPath.row) {
        cell.textLabel.text = @"自定义广告控件";
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        DRDownMenuViewController * menuC = [[DRDownMenuViewController alloc] init];
        [self.navigationController pushViewController:menuC animated:YES];
    }else if (indexPath.row == 1) {
        DRBannerViewController * banner = [[DRBannerViewController alloc] init];
        [self.navigationController pushViewController:banner animated:YES];
    }
}

@end

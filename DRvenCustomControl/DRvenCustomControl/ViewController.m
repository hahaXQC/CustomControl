//
//  ViewController.m
//  DRvenCustomControl
//
//  Created by rimi on 15/7/13.
//  Copyright © 2015年 RIMI. All rights reserved.
//

#import "ViewController.h"
#import "DRDownMenuViewController.h"

@interface ViewController ()

@end

static NSString * cellIndentifier = @"coustomCell";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.automaticallyAdjustsScrollViewInsets = YES;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"自定义下拉菜单";
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        DRDownMenuViewController * menuC = [[DRDownMenuViewController alloc] init];
        [self.navigationController pushViewController:menuC animated:YES];
    }
}

@end

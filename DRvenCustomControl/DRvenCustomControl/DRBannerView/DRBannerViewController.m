//
//  DRBannerViewController.m
//  DRvenCustomControl
//
//  Created by rimi on 15/7/14.
//  Copyright (c) 2015年 RIMI. All rights reserved.
//

#import "DRBannerViewController.h"
#import "DRBannerView.h"

@interface DRBannerViewController ()

@end

@implementation DRBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    DRBannerView * bannerView = [[DRBannerView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 150)];
    bannerView.type = DRBannerViewImageRequstTypeDefault;
    bannerView.dataContainer = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"];
    [self.view addSubview:bannerView];
}

@end

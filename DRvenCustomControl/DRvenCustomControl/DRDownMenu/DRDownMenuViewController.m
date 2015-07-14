//
//  DRDownMenuViewController.m
//  DRvenCustomControl
//
//  Created by rimi on 15/7/14.
//  Copyright (c) 2015年 RIMI. All rights reserved.
//

#import "DRDownMenuViewController.h"
#import "DRDownMenuControl.h"

@interface DRDownMenuViewController () <DRDownMenuDelegate> {
    UILabel * _label;
}

@end

@implementation DRDownMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    DRDownMenuControl * menu= [[DRDownMenuControl alloc] init];
    menu.frame = CGRectMake(100, 100, 100, 200);
    menu.bordColor = [UIColor blueColor].CGColor;
    menu.cornerWidth = 30;//设置尖角下端宽度
    menu.dataContainer = @[@"0",@"1"];
    menu.delegate = self;
    menu.duration = 1;//设置动画时间
    menu.positionX = 20;//设置尖角位置
    [self.view addSubview:menu];
    
    _label = ({
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(200, 200, 100, 20)];
        label;
    });
    [self.view addSubview:_label];
    
}

- (void)menuSelectedWithIndex:(NSInteger)index menuControl:(id)menu {
    _label.text = [NSString stringWithFormat:@"%ld",(long)index];
    DRDownMenuControl * dr = (DRDownMenuControl *)menu;
    [dr remove];
}

@end

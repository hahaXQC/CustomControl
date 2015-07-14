//
//  DRDownMenuControl.m
//  DRvenCustomControl
//
//  Created by rimi on 15/7/14.
//  Copyright (c) 2015年 RIMI. All rights reserved.
//

#define SELF_WIDTH self.frame.size.width    //宽
#define SELF_HEIGHT self.frame.size.height  //高

#define UIRGBCOLOR(_R,_G,_B,_A) [UIColor colorWithRed:_R / 255.0f green:_G / 255.0f blue:_B / 255.0f alpha:_A]

#import "DRDownMenuControl.h"

@interface DRDownMenuControl () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView * mainTableView;
@property (nonatomic, strong) CAShapeLayer * headerShapeLayer;

@end

static NSString * cellIndentifier = @"cell";

@implementation DRDownMenuControl

#pragma mark - getter
- (CAShapeLayer *)headerShapeLayer {
    if (!_headerShapeLayer) {
        _headerShapeLayer = ({
            CAShapeLayer * layer = [CAShapeLayer layer];
            layer.lineWidth = 2;
            layer.strokeColor = self.bordColor;
            layer.fillColor = UIRGBCOLOR(212, 220, 244, 0.8).CGColor;
            //添加线条
            UIBezierPath * path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(0, 10)];//第一个点
            [path addLineToPoint:CGPointMake(self.positionX, 10)];//第二个点
            [path addLineToPoint:CGPointMake(self.positionX + self.cornerWidth / 2, 0)];//第三个点
            [path addLineToPoint:CGPointMake(self.positionX + self.cornerWidth, 10)];//第四个点
            [path addLineToPoint:CGPointMake(SELF_WIDTH, 10)];//第五个点
            layer.path = path.CGPath;
            layer;
        });
    }
    return _headerShapeLayer;
}
- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = ({
            UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, SELF_WIDTH, 0)];
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.backgroundColor = UIRGBCOLOR(212, 220, 244, 0.8);
            //注册之后可以直接到重用队列去取 纯代码一般用这种方法
            [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIndentifier];
            //tableView registerNib:<#(UINib *)#> forCellReuseIdentifier:<#(NSString *)#> xib一般用这种方法
            //如果是storyBoadr一般不用注册，可以直接到重用队列中取
            
            [UIView animateWithDuration:self.duration animations:^{
                tableView.frame = CGRectMake(0, 10, SELF_WIDTH, SELF_HEIGHT - 10);
            }];
            
            
            tableView;
        });
    }
    return _mainTableView;
}
- (NSTimeInterval)isDuration {
    if (!_duration) {
        _duration = 1.2;
    }
    return _duration;
}

#pragma mark - setter
- (void)setPositionX:(CGFloat)positionX {
    if (positionX > SELF_WIDTH - self.cornerWidth || positionX < 0) {
        _positionX = (SELF_WIDTH - self.cornerWidth) / 2;
    }else {
        _positionX = positionX;
    }
}

#pragma mark ---------
/*
 *!入口
 */
- (void)willMoveToSuperview:(UIView *)newSuperview {
    [self initUserInterface];
}

/*
 *!界面初始化
 */
- (void)initUserInterface {
    self.backgroundColor = [UIColor clearColor];
    [self.layer addSublayer:self.headerShapeLayer];
    [self addSubview:self.mainTableView];
}

#pragma mark - 移除
- (void)remove {
    [UIView animateWithDuration:self.duration animations:^{
        self.mainTableView.frame = CGRectMake(0, 10, SELF_WIDTH, 0);
    } completion:^(BOOL finished) {
        [self.headerShapeLayer removeFromSuperlayer];
        [self removeFromSuperview];
    }];
}

#pragma mark - 更新
- (void)reload {
    [self.mainTableView reloadData];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataContainer.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    cell.textLabel.text = self.dataContainer[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(menuSelectedWithIndex:menuControl:)]) {
        [self.delegate menuSelectedWithIndex:indexPath.row menuControl:self];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.eleHeight) {
        return self.eleHeight;
    }
    return 34;
}

@end

//
//  DRBannerView.m
//  DRvenCustomControl
//
//  Created by rimi on 15/7/14.
//  Copyright (c) 2015年 RIMI. All rights reserved.
//

#define SELF_WIDTH self.frame.size.width
#define SELF_HEIGHT self.frame.size.height

#define IMAGE_WITH_NAME(name) [UIImage imageNamed:name]

#import "DRBannerView.h"
#import "UIImageView+WebCache.h"

@interface DRBannerView () <UIScrollViewDelegate> {
    NSMutableArray * _contentImageContainer;
    NSInteger _currentIndex;
    UIView * _super;
    NSTimer * _timer;
}
@property (nonatomic, strong) UIPageControl * pageControl;

@end

@implementation DRBannerView

#pragma mark - getter
- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = ({
            UIPageControl * page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.origin.y + SELF_HEIGHT - 20, SELF_WIDTH, 20)];
            page.currentPage = _currentIndex;
            page.numberOfPages = self.dataContainer.count;
            page;
        });
    }
    return _pageControl;
}
- (NSTimeInterval)isTimeSep {
    if (!_timeSep) {
        _timeSep = 2.0f;
    }
    return _timeSep;
}

#pragma mark -------
/*
 *!入口
 */
- (void)willMoveToSuperview:(UIView *)newSuperview {
    _currentIndex = 0;
    _super = newSuperview;
    [self initUserInterface];
}
/*
 *!已经添加到视图上，将page提前
 */
- (void)didMoveToSuperview {
    [_super bringSubviewToFront:self.pageControl];
    [self startTimer];
}

/*
 *!界面初始化
 */
- (void)initUserInterface {
    
    self.delegate = self;
    //配置scrollView
    self.frame = CGRectInset(self.frame, -5, 0);
    self.contentSize = CGSizeMake(SELF_WIDTH * 3, SELF_HEIGHT);
    self.contentOffset = CGPointMake(SELF_WIDTH, 0);
    self.pagingEnabled = YES;
    self.backgroundColor = [UIColor blackColor];
    
    _contentImageContainer = [NSMutableArray array];
    
    //添加图片
    for (int i = 0; i < 3; i ++) {
        NSInteger index = [self indexWithCurrentIndex:_currentIndex + i -1 totalCount:[self.dataContainer count]];
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5 + SELF_WIDTH * i,0,SELF_WIDTH - 10,SELF_HEIGHT)];
        if (self.type == DRBannerViewImageRequstTypeDefault) {
            imageView.image = IMAGE_WITH_NAME(self.dataContainer[index]);
        }else if (self.type == DRBannerViewImageRequstTypeURL) {
            [imageView sd_setImageWithURL:self.dataContainer[index] placeholderImage:self.placeholderImage];
        }
        [_contentImageContainer addObject:imageView];
        [self addSubview:imageView];
    }
    [_super addSubview:self.pageControl];
    [self initializeTimer];
}

#pragma mark - timer
- (void)initializeTimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:self.timeSep
                                              target:self
                                            selector:@selector(processTimer)
                                            userInfo:nil
                                             repeats:YES];
}
/*
 *!timer方法
 */
- (void)processTimer {
    [self setContentOffset:CGPointMake(CGRectGetWidth(self.bounds) * 2, 0) animated:YES];
}
- (void)startTimer {
    _timer.fireDate = [NSDate date];
}
- (void)pasueTimer {
    _timer.fireDate = [NSDate distantFuture];
}


#pragma mark - 计算真实索引
- (NSInteger)indexWithCurrentIndex:(NSInteger)currentIndex totalCount:(NSInteger)totalCount {
    
    // 超出最大索引
    if (currentIndex > totalCount - 1) {
        currentIndex = 0;
    }
    // 超出最小索引
    else if (currentIndex < 0) {
        currentIndex = totalCount - 1;
    }
    return currentIndex;
}

#pragma mark - 更新界面
- (void)updateScrollView:(UIScrollView *)scrollView {
    
    // 跟踪是否需要刷新界面
    BOOL shouldUpDate = NO;
    // 判断当前页索引，对横纵scrollview进行分别判断
    // 左滑
    if (scrollView.contentOffset.x >= CGRectGetWidth(scrollView.bounds) * 2) {
        _currentIndex = [self indexWithCurrentIndex:_currentIndex + 1 totalCount:[self.dataContainer count]];
        shouldUpDate = YES;
    }
    // 右滑
    else if (scrollView.contentOffset.x <= 0) {
        _currentIndex = [self indexWithCurrentIndex:_currentIndex - 1 totalCount:[self.dataContainer count]];;
        shouldUpDate = YES;
    }
    // 若不需要刷新页面，则跳出方法
    if (!shouldUpDate) {
        return;
    }
    // 对UIImageView进行刷新
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = (UIImageView *)_contentImageContainer[i];
        NSInteger index = [self indexWithCurrentIndex:_currentIndex + i - 1 totalCount:[self.dataContainer count]];
        if (self.type == DRBannerViewImageRequstTypeDefault) {
            imageView.image = IMAGE_WITH_NAME(self.dataContainer[index]);
        }else if (self.type == DRBannerViewImageRequstTypeURL) {
            [imageView sd_setImageWithURL:self.dataContainer[index] placeholderImage:self.placeholderImage];
        }
    }
    self.pageControl.currentPage = _currentIndex;
    // 复位scrollview
    [self resumeScrollView:scrollView animated:NO];
}

#pragma mark - 复位
- (void)resumeScrollView:(UIScrollView *)scrollView animated:(BOOL)animated {
    [scrollView setContentOffset:CGPointMake(CGRectGetWidth(scrollView.bounds), 0) animated:animated];
}

#pragma mark - UIScrollViewDelegate
//scrollview滚动即会调用该方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self updateScrollView:scrollView];
}
// 用户在开始拖动scrolliew时调用该方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self pasueTimer];
}
// 用户在停止拖动scrolliew时调用该方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self startTimer];
}

#pragma mark - 销毁timer
- (void)dealloc {
    [_timer invalidate];
}

@end

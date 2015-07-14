//
//  DRBannerView.h
//  DRvenCustomControl
//
//  Created by rimi on 15/7/14.
//  Copyright (c) 2015年 RIMI. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DRBannerViewImageRequstType)
{
    DRBannerViewImageRequstTypeDefault = 0,
    DRBannerViewImageRequstTypeURL
};

@interface DRBannerView : UIScrollView

/*
 *!自动滚动时间间隔
 */
@property (nonatomic, assign,getter=isTimeSep) NSTimeInterval timeSep;//default is 2
/*
 *!请求类型
 */
@property (nonatomic, assign) DRBannerViewImageRequstType type;
/*
 *!图片容器
 */
@property (nonatomic, strong) NSArray * dataContainer;
/*
 *!替换图片
 */
@property (nonatomic, strong) UIImage * placeholderImage;



@end

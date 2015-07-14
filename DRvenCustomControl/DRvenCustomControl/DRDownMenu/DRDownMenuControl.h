//
//  DRDownMenuControl.h
//  DRvenCustomControl
//
//  Created by rimi on 15/7/14.
//  Copyright (c) 2015年 RIMI. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DRDownMenuDelegate <NSObject>

/*
 *!代理回调
 *index 当前点击那行
 *menu  自己
 */
- (void)menuSelectedWithIndex:(NSInteger)index menuControl:(id)menu;

@end

@interface DRDownMenuControl : UIView

- (void)remove;//移除
- (void)reload;//更新

@property (nonatomic, assign) id <DRDownMenuDelegate> delegate;

/*
 *!尖角位置
 */
@property (nonatomic, assign) CGFloat positionX;
/*
 *!元素高度
 */
@property (nonatomic, assign) CGFloat eleHeight;
/*
 *!用户数据
 */
@property (nonatomic, strong) NSArray * dataContainer;
/*
 *!header线条颜色
 */
@property (nonatomic, assign) CGColorRef bordColor;
/*
 *!尖角宽度
 */
@property (nonatomic, assign) CGFloat cornerWidth;
/*
 *!动画时间
 */
@property (nonatomic, assign, getter=isDuration) NSTimeInterval duration;

@end

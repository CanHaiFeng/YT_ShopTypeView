//
//  ZhongXiaoTypeView.h
//  WmgsTemplate
//
//  Created by yt on 15/9/15.
//  Copyright © 2015年 Infinite Bussiness Alliance. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TypeViewDelegate <NSObject>

-(void)clickTypeViewBtn:(NSDictionary*)dic;//类型视图点击回调
-(void)clickYanZhanTypeViewBtn:(NSDictionary*)dic;//延展类型视图点击回调
@end

@interface YT_ShopTypeView : UIView

@property(nonatomic,assign)id <TypeViewDelegate> delegate;
//初始化
-(id)initZhongXiaoTypeViewWithPoint:(CGPoint)point AndArray:(NSArray*)array;

//颜色
#define lineColor [UIColor colorWithRed:255.0/255.0 green:235.0/255.0 blue:85.0/255.0 alpha:1]//线的颜色
#define typeViewBgColor [UIColor colorWithRed:0.0/255.0 green:135.0/255.0 blue:225.0/255.0 alpha:1]//类型视图背景色
#define typeViewTitleColor [UIColor whiteColor]//类型视图文字颜色
#define typeViewTitleSelectedColor [UIColor colorWithRed:255.0/255.0 green:235.0/255.0 blue:85.0/255.0 alpha:1]//类型视图文字选中颜色
#define yanZhanTypeViewBgColor [UIColor colorWithRed:0.0/255.0 green:135.0/255.0 blue:225.0/255.0 alpha:1]//延展类型视图背景色
#define yanZhanTypeViewTitleColor [UIColor whiteColor]//延展类型视图文字颜色
#define yanZhanTypeViewTitleSelectedColor [UIColor colorWithRed:255.0/255.0 green:235.0/255.0 blue:85.0/255.0 alpha:1]//延展类型视图文字选中颜色
//字体
#define typeViewFont [UIFont systemFontOfSize:14]//类型视图字体
#define yanZhanTypeViewFont [UIFont systemFontOfSize:14]//延展类型视图字体


@end

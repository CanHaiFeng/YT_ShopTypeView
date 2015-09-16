//
//  ZhongXiaoTypeView.m
//  WmgsTemplate
//
//  Created by yt on 15/9/15.
//  Copyright © 2015年 Infinite Bussiness Alliance. All rights reserved.
//

#import "YT_ShopTypeView.h"

@implementation YT_ShopTypeView
{
    NSMutableArray *_typeViewArray;//数据源
    
    UIScrollView *_scView;//类型滚动视图
    UIButton *_xiaLaBtn;//下拉按钮
    
    UIView *_lineView;//线
    UIView *_yanZhanView;//延展view
    
    CGSize _yanZhanViewSize;//当前延展宽高
    
    NSInteger _typeViewIndex;
}
//初始化视图
-(id)initZhongXiaoTypeViewWithPoint:(CGPoint)point AndArray:(NSArray*)array
{
    if (self=[super init])
    {
        _typeViewArray=[[NSMutableArray alloc] initWithArray:array];
        [self setFrame:CGRectMake(point.x, point.y, [UIScreen mainScreen].bounds.size.width, 45)];
        [self initZhongXiaoTypeViewUI];//绘制UI
    }
    return self;
}

//绘制UI
-(void)initZhongXiaoTypeViewUI
{
    _scView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width-40, 45)];
    _scView.backgroundColor=typeViewBgColor;
    _scView.scrollEnabled = YES;//设置是否支持滚动
    _scView.showsHorizontalScrollIndicator = NO;//设置是否显示水平滚动条
    [self addSubview:_scView];
    
    CGRect rect=CGRectMake(0, 0, 0, 0);
    for (NSInteger i=0;i<_typeViewArray.count;i++)
    {
        NSDictionary *dic=[_typeViewArray objectAtIndex:i];
        
        UIButton *btn=[[UIButton alloc] init];
        btn.tag=100000+i;
        [btn setTitle:[dic objectForKey:@"name"] forState:UIControlStateNormal];
        [btn.titleLabel setFont:typeViewFont];
        [btn setTitleColor:typeViewTitleColor forState:UIControlStateNormal];
        [btn setTitleColor:typeViewTitleSelectedColor forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(typeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setFrame:CGRectMake(rect.origin.x+rect.size.width, 0, [self autoLblWidth:btn.titleLabel]+40, _scView.frame.size.height)];
        btn.selected=NO;
        [_scView addSubview:btn];
        rect=btn.frame;
        
        if (i==0)
        {
            btn.selected=YES;
            _lineView=[[UIView alloc] initWithFrame:CGRectMake(rect.origin.x, rect.size.height-2, rect.size.width, 2)];
            _lineView.backgroundColor=lineColor;
            [_scView addSubview:_lineView];
        }
    }
    _scView.contentSize = CGSizeMake(rect.origin.x+rect.size.width, _scView.frame.size.height);//设置滚动区域大小
    
    
    _xiaLaBtn=[[UIButton alloc] initWithFrame:CGRectMake(_scView.frame.size.width, 0, 40, 45)];
    _xiaLaBtn.backgroundColor=typeViewBgColor;
    [_xiaLaBtn setTitleColor:typeViewTitleColor forState:UIControlStateNormal];
    [_xiaLaBtn setTitle:@"⬇︎" forState:UIControlStateNormal];
    [_xiaLaBtn setTitle:@"⬆︎" forState:UIControlStateSelected];
    [_xiaLaBtn addTarget:self action:@selector(xiaLaBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _xiaLaBtn.selected=NO;
    [self addSubview:_xiaLaBtn];
    
    _yanZhanView=[[UIView alloc] initWithFrame:CGRectMake(0, 45, self.frame.size.width, 0)];
    _yanZhanView.backgroundColor=yanZhanTypeViewBgColor;
    _yanZhanView.alpha=0.6;
    _yanZhanView.layer.masksToBounds = YES;//超出的部分截掉
    _yanZhanView.userInteractionEnabled=YES;
    [self addSubview:_yanZhanView];
}
//绘制延展View
-(void)initYanZhanView:(NSDictionary*)yanZhanDic
{
    for (UIView *view in [_yanZhanView subviews])
    {
        [view removeFromSuperview];
    }
    
    CGRect rect=CGRectMake(0, 0, 0, 0);
    NSInteger typeIndex=0;
    for (NSDictionary *dic in [yanZhanDic objectForKey:@"type"])
    {
        NSString *str=[dic objectForKey:@"name"];
        UIButton *btn=[[UIButton alloc] init];
        btn.tag=200000+typeIndex;
        [btn setTitle:str forState:UIControlStateNormal];
        [btn.titleLabel setFont:yanZhanTypeViewFont];
        [btn setTitleColor:yanZhanTypeViewTitleColor forState:UIControlStateNormal];
        [btn setTitleColor:yanZhanTypeViewTitleSelectedColor forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(yanZhanBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (rect.origin.x+rect.size.width+[self autoLblWidth:btn.titleLabel]+40>_yanZhanView.frame.size.width)
        {
            [btn setFrame:CGRectMake(0, rect.origin.y+_scView.frame.size.height, [self autoLblWidth:btn.titleLabel]+40, _scView.frame.size.height)];
        }
        else
        {
            [btn setFrame:CGRectMake(rect.origin.x+rect.size.width, rect.origin.y, [self autoLblWidth:btn.titleLabel]+40, _scView.frame.size.height)];
        }
        btn.selected=NO;
        [_yanZhanView addSubview:btn];
        rect=btn.frame;
        
        typeIndex++;
    }
    [UIView animateWithDuration:0.5 animations:^{
        [_yanZhanView setFrame:CGRectMake(_yanZhanView.frame.origin.x, _yanZhanView.frame.origin.y, _yanZhanView.frame.size.width, rect.origin.y+rect.size.height)];
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _yanZhanView.frame.origin.y+_yanZhanView.frame.size.height)];
    }];
   
   
}
//点击了类型btn
-(void)typeBtnClick:(UIButton*)sender
{
    if (sender.selected)
    {
        return;
    }
    
    for (UIView *view in [_scView subviews])
    {
        if ([view isKindOfClass:[UIButton class]])
        {
            ((UIButton*)view).selected=NO;
        }
    }
    sender.selected=YES;
    _xiaLaBtn.selected=YES;

    CGRect rect=sender.frame;
    [UIView animateWithDuration:0.5 animations:^{
        [_lineView setFrame:CGRectMake(rect.origin.x, rect.size.height-2, rect.size.width, 2)];
        
        if (rect.origin.x-(_scView.frame.size.width-rect.size.width)/2 <0)
        {
            [_scView setContentOffset:CGPointMake(0, 0)];
        }
        else if (rect.origin.x-(_scView.frame.size.width-rect.size.width)/2 >_scView.contentSize.width-_scView.frame.size.width)
        {
            [_scView setContentOffset:CGPointMake(_scView.contentSize.width-_scView.frame.size.width, 0)];
        }
        else
        {
            [_scView setContentOffset:CGPointMake(rect.origin.x-(_scView.frame.size.width-rect.size.width)/2, 0)];
        }
    }];
    
    _typeViewIndex=sender.tag-100000;
    [self initYanZhanView:[_typeViewArray objectAtIndex:_typeViewIndex]];
    
    if(self.delegate &&[self.delegate respondsToSelector:@selector(clickTypeViewBtn:)])
    {
        [self.delegate clickTypeViewBtn:[_typeViewArray objectAtIndex:_typeViewIndex]];
    }
}
//点击了延展btn
-(void)yanZhanBtnClick:(UIButton*)sender
{
    if (sender.selected)
    {
        return;
    }
    
    for (UIView *view in [_yanZhanView subviews])
    {
        if ([view isKindOfClass:[UIButton class]])
        {
            ((UIButton*)view).selected=NO;
        }
    }
    sender.selected=YES;
    
    
    if(self.delegate &&[self.delegate respondsToSelector:@selector(clickYanZhanTypeViewBtn:)])
    {
        [self.delegate clickYanZhanTypeViewBtn:[[[_typeViewArray objectAtIndex:_typeViewIndex] objectForKey:@"type"] objectAtIndex:sender.tag-200000]];
    }
}
//点了下拉按钮
-(void)xiaLaBtnClick
{
    if (_xiaLaBtn.selected)
    {
        _xiaLaBtn.selected=NO;
        
         _yanZhanViewSize=_yanZhanView.frame.size;
        [UIView animateWithDuration:0.5 animations:^{
            [_yanZhanView setFrame:CGRectMake(_yanZhanView.frame.origin.x, _yanZhanView.frame.origin.y, _yanZhanView.frame.size.width,0)];
            [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 45)];
        }];
    }
    else
    {
        _xiaLaBtn.selected=YES;
        [UIView animateWithDuration:0.5 animations:^{
            [_yanZhanView setFrame:CGRectMake(_yanZhanView.frame.origin.x, _yanZhanView.frame.origin.y, _yanZhanView.frame.size.width,_yanZhanViewSize.height)];
            [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _yanZhanView.frame.origin.y+_yanZhanView.frame.size.height)];
        }];
    }
}

//lbl自动宽的标题栏view
- (CGFloat)autoLblWidth:(UILabel*)label
{
    NSDictionary *attribute = @{NSFontAttributeName:label.font};
    CGSize size = [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, label.frame.size.height)
                                           options: NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                        attributes:attribute
                                           context:nil].size;
    return size.width;
}
@end


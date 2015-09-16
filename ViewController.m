//
//  ViewController.m
//  YT_ShopTypeView
//
//  Created by yt on 15/9/15.
//  Copyright (c) 2015年 szyt. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark -TypeViewDelegate
//类型视图点击回调
-(void)clickTypeViewBtn:(NSDictionary*)dic
{
    NSLog(@"%@",dic);
}
//延展类型视图点击回调
-(void)clickYanZhanTypeViewBtn:(NSDictionary*)dic
{
    NSLog(@"%@",dic);
}
#pragma mark -视图 加载完成 即将显示 已经显示 即将消失 已经消失
//视图已经加载完成
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray *typeViewArray=[[NSMutableArray alloc] init];
    
    [typeViewArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"全部",@"name",nil,@"type", nil]];
    
    for (NSInteger i=1000000; i<1000010; i++)
    {
        NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
        [dic setObject:[NSString stringWithFormat:@"%zd",i] forKey:@"name"];
        NSInteger value = arc4random()%20;//取一个随机数
        
        NSMutableArray *array=[[NSMutableArray alloc] init];
        for (NSInteger y=0;y<value;y++)
        {
            NSDictionary *yanZhanDic=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"产品%zd",y],@"name", nil];
            [array addObject:yanZhanDic];
        }
        [dic setObject:array forKey:@"type"];
        
        [typeViewArray addObject:dic];
    }

    
    YT_ShopTypeView *typeView=[[YT_ShopTypeView alloc] initZhongXiaoTypeViewWithPoint:CGPointMake(0, 64) AndArray:typeViewArray];
    typeView.delegate=self;
    [self.view addSubview:typeView];
}
//根视图即将显⽰示
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

//根视图已经显⽰示
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}

//根视图即将消失
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
}

//根视图已经消失
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
}
//收到内存警告
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

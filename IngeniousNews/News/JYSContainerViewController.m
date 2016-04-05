//
//  JYSContainerViewController.m
//  IngeniousNews
//
//  Created by 姜雨生 on 16/2/27.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSContainerViewController.h"
#import "JYSDaysNewsTableViewController.h"
#import "JYSNewsTableViewController.h"
#import "JYSTitleLable.h"
#import "JYSSqliteFmdbTool.h"
#import "JYSChannelViewController.h"
#import "JYSTools.h"
@interface JYSContainerViewController ()<UIScrollViewDelegate>

/** 新闻接口的数组*/
@property(nonatomic,retain)NSArray *arrayLists;

@property(nonatomic,retain)UIScrollView *titleView;

@property(nonatomic,retain)UIScrollView *vcView;

@property(nonatomic,assign)BOOL selected;


@end

@implementation JYSContainerViewController

/** 数组懒加载,加载界面Channels*/
-(NSArray *)arrayLists{
    if (_arrayLists == nil) {
        _arrayLists = [JYSSqliteFmdbTool selectedChannels];
    }
    return _arrayLists;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addController];
    [self creatScrollView];
    [self addLable];
    [self creatBtns];
  
    
}

/** 左右按钮*/
-(void)creatBtns{
    
    UIImage *image = [UIImage imageNamed:@"24_01"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:image style:0 target:self action:@selector(getNews)];
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [rightBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [rightBtn addTarget:self action:@selector(changeChannel:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.title = @"资讯";
    self.view.backgroundColor = [UIColor whiteColor];
    self.selected = NO;

    
}

/** 重置页面数据数量*/
-(void)changeChannel:(UIButton*)sender{
    
    _selected = !_selected;
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animation];
    
    animation1.keyPath = @"transform.rotation";
    if (_selected) {
        animation1.values = @[@(0),@(M_PI*0.25)];
    }
    else{
        animation1.values =@[@(M_PI*0.25),@(M_PI*1)];
    }
    animation1.duration = 0.2;
    animation1.repeatCount = 1;
    animation1.fillMode = kCAFillModeForwards;
    animation1.removedOnCompletion = false;
    [sender.layer addAnimation:animation1 forKey:nil];
    
    
    JYSChannelViewController *channel = [self.childViewControllers lastObject];
    if (!channel.view.superview) {
        channel.view.frame = CGRectMake(0, 64, UISCREENWIDTH, UISCREENHEIGHT-64-49);
        [self.view addSubview:channel.view];
        channel.view.alpha = 0.0;
    }
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.subtype = kCATransitionFromTop;
       if (_selected) {
        channel.userChannelArr = [self.arrayLists mutableCopy];
        channel.view.alpha = 1;
           
    }
    else{
        if (![self.arrayLists isEqual:channel.userChannelArr]) {
            
            self.arrayLists = channel.userChannelArr;
            [self reloadView];
        }
        channel.view.alpha = 0;
    }
    
}

/** 重置View*/
-(void)reloadView{
    
    for (UIViewController *temp in self.childViewControllers) {
        [temp removeFromParentViewController];
    }
    
    for (UIView *temp in self.titleView.subviews) {
        [temp removeFromSuperview];
    }
    for (UIView *temp in self.vcView.subviews) {
        [temp removeFromSuperview];
    }
    [self addController];
    [self addLable];
    [self creatScrollView];
    [self.vcView setContentOffset:CGPointMake(0, 0) animated:YES];
}

/** 24小时要闻*/
-(void)getNews{
    
    JYSDaysNewsTableViewController *newsVC = [[JYSDaysNewsTableViewController alloc]init];
    [self.navigationController pushViewController:newsVC animated:YES];
        
}

/** 添加子控制器*/
-(void)addController{
    
    for (int i = 0; i<self.arrayLists.count; i++) {
        JYSNewsTableViewController *VC = [[JYSNewsTableViewController alloc]init];
        VC.url = self.arrayLists[i][@"urlString"];
        VC.dataTitle = self.arrayLists[i][@"title"];
        VC.key = self.arrayLists[i][@"key"];
        [self addChildViewController:VC];
    }
    [self addChildViewController:[JYSChannelViewController new]];
   

}

/** 创建ScrollView*/
-(void)creatScrollView{
    if (self.vcView == nil) {
        self.vcView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 104, UISCREENWIDTH,UISCREENHEIGHT-144)];
    }
    CGFloat contentX = (self.childViewControllers.count-1) * UISCREENWIDTH;
    self.vcView.contentSize = CGSizeMake(contentX, 0);
    self.vcView.pagingEnabled = YES;
    self.vcView.delegate = self;
    if (self.vcView.superview == nil) {
        [self.view addSubview:self.vcView];
    }
    
    //添加默认控制器
    UIViewController *firseVC = [self.childViewControllers firstObject];
    firseVC.view.frame = CGRectMake(0, -64, UISCREENWIDTH, UISCREENHEIGHT-144);
    [self.vcView addSubview:firseVC.view];
    
    JYSTitleLable *lable = [self.titleView.subviews firstObject];
    lable.scale = 1.0;
    self.vcView.showsHorizontalScrollIndicator = NO;
    
    if (self.titleView == nil) {
        self.titleView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, UISCREENWIDTH, 40)];
    }
    self.titleView.contentSize = CGSizeMake(70*(self.childViewControllers.count-1), 0);
    self.titleView.showsHorizontalScrollIndicator = NO;
    self.titleView.showsVerticalScrollIndicator = NO;
    if (self.titleView.superview == nil) {
        [self.view addSubview:self.titleView];
    }
    
    
}

/** 添加标题栏*/
-(void)addLable{
    
    
    for (int i = 0; i<self.arrayLists.count; i++) {
        CGFloat lw = 70;
        CGFloat lh = 40;
        CGFloat ly = 0;
        CGFloat lx = i*lw;
        JYSTitleLable *lable = [[JYSTitleLable alloc]init];
        lable.text = self.arrayLists[i][@"title"];
        lable.frame = CGRectMake(lx, ly, lw, lh);
        lable.font = [UIFont systemFontOfSize:22];
        [self.titleView addSubview:lable];
        lable.tag = 1000+i;
        lable.userInteractionEnabled = YES;
        [lable addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lableClick:)]];
    }
    
}

/** 标题点击事件*/
-(void)lableClick:(UITapGestureRecognizer*)tap{

    JYSTitleLable *lable = (JYSTitleLable*)tap.view;
    CGFloat offsetx = (lable.tag-1000) * self.vcView.frame.size.width;
    CGFloat offsety = self.vcView.contentOffset.y;
    CGPoint offset = CGPointMake(offsetx, offsety);
    [self.vcView setContentOffset:offset animated:YES];
}


#pragma mark - scrollView Delegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    //获取索引页
    NSUInteger index = scrollView.contentOffset.x/self.vcView.bounds.size.width;
    
    //滚动标题栏
    JYSTitleLable *titleLable = (JYSTitleLable*)self.titleView.subviews[index];
    CGFloat offsetX = titleLable.center.x - self.titleView.frame.size.width * 0.5;
    CGFloat offsetMax = self.titleView.contentSize.width - self.titleView.frame.size.width;
    if (offsetX<0) {
        offsetX = 0;
    }
    else if (offsetX > offsetMax){
        offsetX = offsetMax;
    }
    CGPoint offset = CGPointMake(offsetX, self.titleView.contentOffset.y);
    [self.titleView setContentOffset:offset animated:YES];
    
    [self.titleView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx != index) {
            JYSTitleLable *temp = self.titleView.subviews[idx];
            temp.scale = 0;
        }
    }];
    JYSNewsTableViewController *newsVC = self.childViewControllers[index];
    
    if (newsVC.view.superview)return;
    
    newsVC.view.frame = scrollView.bounds;
    [self.vcView addSubview:newsVC.view];

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

/** 正在滚动 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //  取出绝对值 避免最左边往右拉时形变超过1
    CGFloat value = ABS(scrollView.contentOffset.x / scrollView.frame.size.width);
    NSUInteger leftIndex = (int)value;
    NSUInteger rightIndex = leftIndex + 1;
    CGFloat scaleRight = value - leftIndex;
    CGFloat scaleLeft = 1 - scaleRight;
    JYSTitleLable *labelLeft = self.titleView.subviews[leftIndex];
    labelLeft.scale = scaleLeft;
    
    // 考虑到最后一个板块，如果右边已经没有板块了 就不在下面赋值scale了
    if (rightIndex < self.titleView.subviews.count) {
        JYSTitleLable *labelRight = self.titleView.subviews[rightIndex];
        labelRight.scale = scaleRight;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end

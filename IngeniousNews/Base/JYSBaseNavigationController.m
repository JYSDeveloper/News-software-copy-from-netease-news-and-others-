//
//  JYSBaseNavigationController.m
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/4.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSBaseNavigationController.h"

@interface JYSBaseNavigationController ()



@end

@implementation JYSBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.barTintColor = [UIColor redColor];
    self.rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    self.rightBtn.backgroundColor = [UIColor redColor];
    self.rightBtn.layer.borderWidth = 1;
    self.rightBtn.layer.borderColor = [UIColor grayColor].CGColor;
    self.rightBtn.layer.cornerRadius = 15;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
        UIImage *image = [UIImage imageNamed:@"back"];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:image style:0 target:self action:@selector(backBtnAction)];
       // viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightBtn];
    }
    
    [super pushViewController:viewController animated:animated];
}

-(void)backBtnAction{
    
    [self popViewControllerAnimated:YES];
}


@end

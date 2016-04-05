//
//  JYSWebViewController.h
//  IngeniousNews
//
//  Created by 姜雨生 on 16/2/27.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYSNewsModel.h"
#import "JYSWebViewModel.h"
@interface JYSWebViewController : UIViewController

@property(nonatomic,copy)NSString *url;

@property(nonatomic,copy)NSString *docid;

@property(nonatomic,retain)JYSNewsModel *model;

@property(nonatomic,assign)WebModelType type;
@end

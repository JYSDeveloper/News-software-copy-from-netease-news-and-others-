//
//  JYSNewsTableViewController.h
//  IngeniousNews
//
//  Created by 姜雨生 on 16/2/27.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYSBaseTableViewController.h"
@interface JYSNewsTableViewController : JYSBaseTableViewController

@property(nonatomic,copy)NSString *url;

@property(nonatomic,copy)NSString *dataTitle;

@property(nonatomic,copy)NSString *key;
@end

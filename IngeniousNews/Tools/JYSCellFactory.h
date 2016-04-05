//
//  JYSCellFactory.h
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/4.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JYSOneImageTableViewCell.h"
#import "JYSBaseTableViewCell.h"
#import "JYSNewsModel.h"
#import "JYSOneImageTableViewCell.h"
#import "JYSOneBigImageTableViewCell.h"
#import "JYSImagesTableViewCell.h"
#import "JYSListenModel.h"
#import "JYSCityNewsModel.h"

@interface JYSCellFactory : NSObject


typedef NS_ENUM(NSUInteger, CellType) {
    
    NewsOneImageCell = 0,
    NewsOneImageCellSpecial,
   // NewsOneImageCellLive,
    NewsImagesCell,
    NewsOneBigImageCell,
    ListenNormalCell,
    CityNormalCell,
    CityImageCell,
};

+(CellType)cellTypeWithModel:(id)model;

+(JYSBaseTableViewCell*)cellWithTableView:(UITableView*)tableView Model:(id)model IndexPath:(NSIndexPath*)indexPath;

+(JYSBaseTableViewCell*)cellWithTableView:(UITableView*)tableView Model:(id)model IndexPath:(NSIndexPath*)indexPath Type:(CellType)type;

+(CGFloat)cellHightWithModel:(id)model;

+(CGFloat)cellHightWithModel:(id)model Type:(CellType)type;

@end

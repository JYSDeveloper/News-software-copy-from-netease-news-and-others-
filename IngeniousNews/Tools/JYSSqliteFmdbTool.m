//
//  JYSSqliteFmdbTool.m
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/11.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSSqliteFmdbTool.h"
#import "FMDB.h"
@implementation JYSSqliteFmdbTool
static FMDatabase *db;


+(void)initialize{
    //沙盒路径
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject]stringByAppendingPathComponent:@"FavouriteChannel"];
    db = [FMDatabase databaseWithPath:filePath];
    if ([db open]) {
    //创建表语句
    NSString *creatTableSql = @"CREATE TABLE IF NOT EXISTS t_FavouriteChannel(title text,urlString text , key text)";
    //创建表
        BOOL result = [db executeUpdate:creatTableSql];
        if (result) {
            NSLog(@"success");
        }
        else{
            NSLog(@"fail");
        }
        NSMutableArray *dbArr = [self selectedChannels];
        if (dbArr.count == 0) {
            NSArray *arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"DefaultURLs.plist" ofType:nil]];
            for (NSDictionary *temp in arr) {
                [self addChannelWithDic:temp];
            }
        }
        NSLog(@"%@",filePath);
    }
}
//添加数据
+(void)addChannelWithDic:(NSDictionary*)dic{
    [db executeUpdateWithFormat:@"INSERT INTO t_FavouriteChannel(title,urlString,key) VALUES(%@,%@,%@)",dic[@"title"],dic[@"urlString"],dic[@"key"]];
}

+(NSMutableArray*)selectedChannels{
    
    NSMutableArray *result = [NSMutableArray new];
    FMResultSet *set = [db executeQuery:@"SELECT *FROM t_FavouriteChannel"];
    while (set.next) {
        NSString *title = [set stringForColumn:@"title"];
        NSString *urlString = [set stringForColumn:@"urlString"];
        NSString *key = [set stringForColumn:@"key"];
        [result addObject:@{@"title":title,@"urlString":urlString,@"key":key}];
    }
    return result;
}

+(void)delectedChannelWithTitle:(NSString*)title{
    
    if ([db open]) {
        NSString *deleteSql = [NSString stringWithFormat:@"DELETE FROM t_FavouriteChannel where title = %@",title];
        BOOL res = [db executeUpdate:deleteSql];
        if (!res) {
            NSLog(@"失败");
        }
        else{
            NSLog(@"成功");
        }
    }
}
+(void)delectedAll{
    
    NSString * sql = @"delete from t_FavouriteChannel";
    BOOL res = [db executeUpdate:sql];
    if (res) {
        NSLog(@"delected All success");
    }
    else{
        NSLog(@"delected fail");
    }
    
}

+(void)addChannelsWithArr:(NSMutableArray *)arr{
    for (NSDictionary *temp in arr) {
        [self addChannelWithDic:temp];
    }
}

@end

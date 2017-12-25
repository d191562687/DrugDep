//
//  ScanListViewController.h
//  DrugDep
//
//  Created by 金安健 on 2017/11/29.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import "SuperViewController.h"


@interface ScanListViewController : SuperViewController

/** 添加商品回调 */
@property (nonatomic,copy) void (^callBack) (id model);

@end

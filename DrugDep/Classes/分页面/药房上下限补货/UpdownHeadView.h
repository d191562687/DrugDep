//
//  UpdownHeadView.h
//  DrugDep
//
//  Created by 金安健 on 2017/6/27.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    AddClickType = 1, // 添加按钮事件
    SaveClickType = 2, // 保存按钮事件
    TijiaoClickType = 3, // 提交
    CancleClickType = 4  // 取消
    
}ButtonClickType;

@interface UpdownHeadView : UIView


/**
 4个按钮的点击事件回调
 */
@property (copy,nonatomic) void (^SelectBlock)(ButtonClickType clickType);


@end

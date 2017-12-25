//
//  EveryShopHeaderFooterView.h
//  DrugDep
//
//  Created by 金安健 on 2017/11/13.
//  Copyright © 2017年 杜彪. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EveryShopHeadViewDelegate <NSObject>
@optional
- (void)WTShopcatHeadViewCurrectSectionsInView:(NSInteger)section selectStatus:(BOOL)selectStatus;

- (void)WTShopcatHeadViewDeleteCurrectSectionsInView:(NSInteger)section;

@end
static NSString * const EveryShopHeaderFooterViews = @"EveryShopHeaderFooterView";

@interface EveryShopHeaderFooterView : UITableViewHeaderFooterView

@property (nonatomic, assign) id<EveryShopHeadViewDelegate> delegate;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UILabel *shopName;
@property (nonatomic, assign) NSInteger section;

@end

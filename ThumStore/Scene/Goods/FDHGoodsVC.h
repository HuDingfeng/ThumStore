//
//  FDHGoodsVC.h
//  ThumStore
//
//  Created by 胡定锋Mac on 16/6/21.
//  Copyright © 2016年 胡定锋/IOS blog:hudingfeng.github.io   github:HuDingfeng. All rights reserved.
//

//#import <EasyIOS/EasyIOS.h>
#import "Scene.h"

/**
 *  接收动画结束通知的name
 */
#define kShopCartAdd @"kShopCartAdd"
//从购物车中减去商品
#define shopCartMinus @"shopCartMinus"

@interface FDHGoodsVC : Scene


/** 订单数据 */
@property (nonatomic, strong) NSMutableArray *orderArray;

/** 订单所选总数量 */
@property (nonatomic, assign) NSInteger totalOrderCount;

/** 订单总价 */
@property (assign, nonatomic) double totalPrice;

@end

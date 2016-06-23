//
//  FDHGoodsModel.h
//  ThumStore
//
//  Created by 胡定锋Mac on 16/6/22.
//  Copyright © 2016年 胡定锋/IOS blog: http://hudingfeng.github.io   github:HuDingfeng. All rights reserved.
//

#import "BaseModel.h"

@interface FDHGoodsModel : BaseModel


@property (nonatomic,copy)NSString *goodsName;
@property (nonatomic,copy)NSString *goodsImage;
@property (nonatomic,copy)NSString *goodsPrice;
@property (nonatomic,copy)NSString *goodsAddCartNum;
@end

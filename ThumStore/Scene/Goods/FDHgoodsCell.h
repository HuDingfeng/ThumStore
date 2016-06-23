//
//  FDHgoodsCell.h
//  ThumStore
//
//  Created by hdf on 16/6/22.
//  Copyright © 2016年 胡定锋/IOS blog: http://hudingfeng.github.io   github:HuDingfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"

@class GoodsModel, FDHgoodsCell;

@protocol FDHgoodsCellDelegate <NSObject>

@optional
- (void)menuItemCellDidClickPlusButton:(FDHgoodsCell *)goodsCell;
- (void)menuItemCellDidClickMinusButton:(FDHgoodsCell *)goodsCell;

@end

@interface FDHgoodsCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *goodsIconView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsOriginalPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsSalePriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;
//@property (weak, nonatomic) IBOutlet UIView *soldoutBackgroudView;
@property (weak, nonatomic) IBOutlet UIImageView *soldoutIconView;
//@property (weak, nonatomic) IBOutlet UIButton *plusButton;


@property (weak, nonatomic) IBOutlet UIButton *plusButton;

/** 商品模型 */
@property (strong, nonatomic) GoodsModel *goods;

/** 代理对象 */
@property (nonatomic, weak) id<FDHgoodsCellDelegate> delegate;
@end

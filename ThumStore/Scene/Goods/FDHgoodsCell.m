//
//  FDHgoodsCell.m
//  ThumStore
//
//  Created by hdf on 16/6/22.
//  Copyright © 2016年 胡定锋/IOS blog: http://hudingfeng.github.io   github:HuDingfeng. All rights reserved.
//

#import "FDHgoodsCell.h"
#import "UIImageView+WebCache.h"
#import "CustomDefine.h"
#import "GoodsModel.h"
@interface FDHgoodsCell ()
@end

@implementation FDHgoodsCell

- (void)setGoods:(GoodsModel *)goods {
    _goods = goods;
    
    self.goodsIconView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", goods.goodsIcon]];
    self.goodsNameLabel.text = [NSString stringWithFormat:@"%@", goods.goodsName];
    self.goodsOriginalPriceLabel.text = [NSString stringWithFormat:@"原价：¥ %.2f", goods.goodsOriginalPrice];
    self.goodsSalePriceLabel.text = [NSString stringWithFormat:@"¥ %.2f", goods.goodsSalePrice];
    self.goodsCountLabel.text = [NSString stringWithFormat:@"%zd", goods.orderCount];
    
    if (_goods.orderCount > 0) {
        [self.minusButton setHidden:NO];
        [self.goodsCountLabel setHidden:NO];
    } else {
        [self.minusButton setHidden:YES];
        [self.goodsCountLabel setHidden:YES];
    }
    
    if (!_goods.goodsStock  > 0) {
        //self.soldoutBackgroudView.hidden = NO;
        self.soldoutIconView.hidden = NO;
        _plusButton.enabled = NO;
    } else {
        //self.soldoutBackgroudView.hidden = YES;
        self.soldoutIconView.hidden = YES;
        _plusButton.enabled = YES;
    }
}

- (IBAction)plusButtonClicked {
    _goods.orderCount++;    // 修改模型
    _goods.goodsStock--;
    _goodsCountLabel.text = [NSString stringWithFormat:@"%i", _goods.orderCount];
    _minusButton.hidden = NO;
    _goodsCountLabel.hidden = NO;
    if (_goods.goodsStock == 0) {
        _plusButton.enabled = NO;
        self.soldoutIconView.hidden = NO;
    }
    
    // 通知代理（调用代理的方法）
    // respondsToSelector:能判断某个对象是否实现了某个方法
    if ([self.delegate respondsToSelector:@selector(menuItemCellDidClickPlusButton:)]) {
        [self.delegate menuItemCellDidClickPlusButton:self];
    }
}

- (IBAction)minusButtonClicked {
    _goods.orderCount--;
    _goods.goodsStock++;
    _goodsCountLabel.text = [NSString stringWithFormat:@"%i", _goods.orderCount];
    
    if (_goods.orderCount == 0) {
        _minusButton.hidden = YES;
        _goodsCountLabel.hidden = YES;
    }
    
    if (_goods.goodsStock > 0) {
        _plusButton.enabled = YES;
        self.soldoutIconView.hidden = YES;
    }
    
    // 通知代理（调用代理的方法）
    if ([self.delegate respondsToSelector:@selector(menuItemCellDidClickMinusButton:)]) {
        [self.delegate menuItemCellDidClickMinusButton:self];
    }
}
@end

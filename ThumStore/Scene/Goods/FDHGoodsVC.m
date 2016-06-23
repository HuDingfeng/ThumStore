//
//  FDHGoodsVC.m
//  ThumStore
//
//  Created by 胡定锋Mac on 16/6/21.
//  Copyright © 2016年 胡定锋/IOS blog:http://hudingfeng.github.io   github:HuDingfeng. All rights reserved.
//

#import "FDHGoodsVC.h"
#import "CustomDefine.h"
//#import "SMVerticalSegmentedControl.h"
#import "FDHgoodsCell.h"

#import "MJExtension.h"
#import "GoodsCategory.h"
#import "GoodsModel.h"
#import "SDCycleScrollView.h"
#define ZXColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
@interface FDHGoodsVC ()<UITableViewDelegate,UITableViewDataSource,FDHgoodsCellDelegate,SDCycleScrollViewDelegate>
{
    UITableView *miantableView;
    SDCycleScrollView *cycleScrollView;
}
@property (nonatomic, strong) NSMutableArray *animationLayers;
@property (nonatomic, assign) BOOL isNeedNotification;
@property (nonatomic, strong) UITableView   *leftTableView;
@property (nonatomic, strong) UITableView   *rightTableView;
@property (nonatomic, strong) NSArray       *dataArray;
@property (nonatomic, assign) BOOL          isRelate;
@property (nonatomic, assign) NSInteger     totalOrders;
@end

@implementation FDHGoodsVC
static NSString * const cellID = @"MenuItemCell";
static NSString * const ListCellID = @"DetailListCell";

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [cycleScrollView adjustWhenControllerViewWillAppera];
}

-(void)viewDidLoad
{
    miantableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    miantableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [miantableView resignFirstResponder];
    [self.view addSubview:miantableView];
    
    [self showBarButton:NAV_LEFT title:@"郑州↓" fontColor:[UIColor whiteColor]];
    [self leftTableView];
    [self rightTableView];
    [self loadData];
    [self creatheaderScrollview:@[]];
    _isRelate = YES;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shopCarBadgeValueAdd:) name:@"kShopCartAdd" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shopCarBadgeValueMinus:) name:@"kShopCartMinus" object:nil];

}
-(void)creatheaderScrollview:(NSArray *)imagestrArr
{
    imagestrArr = @[@"http://picyun.90sheji.com/design/00/02/90/50/s_1024_551518b3d6831.png",
                    @"http://img.zcool.cn/community/01a1815543724c0000005b03f03692.jpg",
                    @"http://img.zcool.cn/community/011c2155f7d23d6ac7251df8702cf4.jpg"];
    
    if (!cycleScrollView) {
        cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0,Main_Screen_Width, 150) delegate:self placeholderImage:nil];
        cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
        cycleScrollView.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
        cycleScrollView.pageControlDotSize = CGSizeMake(7, 7);
        cycleScrollView.autoScrollTimeInterval = 3.0f;
        cycleScrollView.imageURLStringsGroup = imagestrArr;
        [miantableView addSubview:cycleScrollView];
        //预留  **带标题bannar
        /*
         cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, APPBOUNDS.size.width, 150) delegate:self placeholderImage:nil];
         cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
         cycleScrollView.titlesGroup = titleArr;
         cycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
         [_topView addSubview:cycleScrollView];
         cycleScrollView.imageURLStringsGroup = imagesURLStrings;
         */
    }

}
- (UITableView *)leftTableView {
    if (nil == _leftTableView) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 150, self.view.frame.size.width * 0.25, self.view.frame.size.height - 50)];
        _leftTableView.backgroundColor = [UIColor whiteColor];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [miantableView addSubview:_leftTableView];
    }
    return _leftTableView;
    
}

- (UITableView *)rightTableView {
    if (nil == _rightTableView) {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 0.25, 150, self.view.frame.size.width * 0.75, self.view.frame.size.height -150 - 64-48)];
        _rightTableView.backgroundColor = [UIColor whiteColor];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        //_rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_rightTableView registerNib:[UINib nibWithNibName:NSStringFromClass([FDHgoodsCell class]) bundle:nil] forCellReuseIdentifier:cellID];
        [miantableView addSubview:_rightTableView];
    }
    return _rightTableView;
}

#pragma mark - 获取商品数据
- (void)loadData {
    if (!_dataArray) {
        _dataArray = [NSArray new];
        // 解析本地JSON文件获取数据，生产环境中从网络获取JSON
        NSString *path = [[NSBundle mainBundle] pathForResource:@"goods" ofType:@"json"];
        NSError *error = nil;
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data
                                                       options:NSJSONReadingAllowFragments
                                                         error:&error];
        _dataArray = [GoodsCategory objectArrayWithKeyValuesArray:arr];
        if (error) {
            NSLog(@"address.json - fail: %@", error.description);
        }
    }
}

#pragma mark dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == _leftTableView) {
        return 1;
    } else{
        
        return [_dataArray count];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    GoodsCategory *goodsCategory = _dataArray[section];
    if (tableView == _leftTableView) {
        return _dataArray.count;
    } else {
        return goodsCategory.goodsArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _leftTableView) {
        static NSString *CellIdentifier = @"Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
            cell.backgroundColor = ZXColor(240, 240, 240);
            UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
            selectedBackgroundView.backgroundColor = [UIColor whiteColor];
            cell.selectedBackgroundView = selectedBackgroundView;
            
            // 左侧示意条
            UIView *liner = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 6, 40)];
            liner.backgroundColor = [UIColor colorWithHue:0.56 saturation:0.73 brightness:0.98 alpha:1];
            [selectedBackgroundView addSubview:liner];
        }
        
        GoodsCategory *goodsCategory = _dataArray[indexPath.row];
        cell.textLabel.font = FONT(13);
        cell.textLabel.text = goodsCategory.goodsCategoryName;
        
        return cell;
    } else if (tableView == _rightTableView) {
        
        FDHgoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        GoodsCategory *goodsCategory = _dataArray[indexPath.section];
        GoodsModel *goods = goodsCategory.goodsArray[indexPath.row];
        
        cell.goods = goods;
//        cell.goodsIconView.image = [UIImage imageNamed:@"fangbianmain"];
        return cell;
    } else {
        return nil;
    }
}

#pragma mark delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _leftTableView) {
        return 40;
    } else if (tableView == _rightTableView) {
        return 92;
    } else{
        return 0.f;
    }
}
//返回每一个组头的高度，如果想达到有那种效果则一定要做这个操作
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == _rightTableView) {
        return 30;
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (tableView == _rightTableView) {
        return 0.01;
    } else {
        return 0;
    }
}

//返回组头部的那块View
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == _rightTableView) {
        UIView *view = [[UIView alloc]init];
        view.frame = CGRectMake(0, 0, tableView.frame.size.width, 30);
        view.backgroundColor = ZXColor(240, 240, 240);
        [view setAlpha:0.7];
        UILabel *label = [[UILabel alloc]initWithFrame:view.bounds];
        //NSDictionary *item = [_dataArray objectAtIndex:section];
        label.font = FONT(14);
        GoodsCategory *goodsCategory = [_dataArray objectAtIndex:section];
        NSString *title = goodsCategory.goodsCategoryDesc;
        [label setText:[NSString stringWithFormat:@"  %@",title]];
        [view addSubview:label];
        return view;
    } else {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //左边tableView
    if (tableView == _leftTableView) {
        _isRelate = NO;
        [self.leftTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
        
        //点击了左边的cell，让右边的tableView跟着滚动
        [self.rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:indexPath.row] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    } else{
        [_rightTableView deselectRowAtIndexPath:indexPath animated:NO];
        
        NSLog(@"点击这里可以跳到详情页面");
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (_isRelate) {
        NSInteger topCellSection = [[[tableView indexPathsForVisibleRows] firstObject] section];
        if (tableView == _rightTableView) {
            [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:topCellSection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section {
    if (_isRelate) {
        NSInteger topCellSection = [[[tableView indexPathsForVisibleRows] firstObject] section];
        if (tableView == _rightTableView) {
            [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:topCellSection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    }
}

#pragma mark - UISCrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    _isRelate = YES;
}

#pragma mark - MenuItemCellDelegate
- (void)menuItemCellDidClickMinusButton:(FDHgoodsCell *)goodsCell {
//    // 计算总价
//    _totalPrice = _totalPrice - itemCell.goods.goodsSalePrice;
//    
//    // 设置总价
//    [_shopCartView setTotalPrice:_totalPrice];
    
    --self.totalOrders;
//    _shopCartView.badgeValue = self.totalOrders;
//    NSIndexPath *indexpath = [_rightTableView indexPathForCell:goodCell];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kShopCartMinus" object:nil];
    
    // 将商品从购物车中移除
    if (goodsCell.goods.orderCount == 0) {
        [self.orderArray removeObject:goodsCell.goods];
    }
//    [_shopCartView.detailListView.listTableView reloadData];
//    _shopCartView.detailListView.objects = _orderArray;
//    _shopCartView.orderArray = _orderArray;
}

- (void)menuItemCellDidClickPlusButton:(FDHgoodsCell *)goodsCell {
    // 计算总价
//    _totalPrice = _totalPrice + itemCell.goods.goodsSalePrice;
//    // 设置总价
//    [_shopCartView setTotalPrice:_totalPrice];
    
    
    // 如果这个商品已经在购物车中，就不用再添加
    if ([self.orderArray containsObject:goodsCell.goods]) {
//        [_shopCartView.detailListView.listTableView reloadData];
    } else {
        // 添加需要购买的商品
        [self.orderArray addObject:goodsCell.goods];
//        [_shopCartView.detailListView.listTableView reloadData];
        [self addProductsAnimation:goodsCell.goodsIconView dropToPoint:CGPointMake(Main_Screen_Width*0.5, self.view.layer.bounds.size.height - 40) isNeedNotification:YES];

    }
//    _shopCartView.detailListView.objects = _orderArray;
//    _shopCartView.orderArray = _orderArray;
}

//#pragma mark - ThrowLineToolDelegate
//- (void)animationDidFinish {
//    
//    [self.redView removeFromSuperview];
//    [UIView animateWithDuration:0.1 animations:^{
//        _shopCartView.shopCartBtn.transform = CGAffineTransformMakeScale(0.8, 0.8);
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.1 animations:^{
//            _shopCartView.shopCartBtn.transform = CGAffineTransformMakeScale(1, 1);
//        } completion:^(BOOL finished) {
//            
//        }];
//        
//    }];
//}

//#pragma mark - DetailListCellDelegate
//- (void)orderDetailCellPlusButtonClicked:(DetailListCell *)cell {
//    NSLog(@"订单 + 按钮点击: %@ %@ %i", cell.goods.goodsID, cell.goods.goodsName, cell.goods.goodsStock);
//    // 计算总价
//    _totalPrice = _totalPrice + cell.goods.goodsSalePrice;
//    // 设置总价
//    [_shopCartView setTotalPrice:_totalPrice];
//    ++self.totalOrders;
//    _shopCartView.badgeValue = self.totalOrders;
//    
//    _shopCartView.detailListView.objects = _orderArray;
//    _shopCartView.orderArray = _orderArray;
//    [_shopCartView updateFrame:_shopCartView.detailListView];
//    [_shopCartView.detailListView.listTableView reloadData];
//    [_rightTableView reloadData];
//}

//- (void)orderDetailCellMinusButtonClicked:(DetailListCell *)cell {
//    NSLog(@"订单 - 按钮点击: %@ %@ %i", cell.goods.goodsID, cell.goods.goodsName, cell.goods.goodsStock);
//    // 计算总价
//    _totalPrice = _totalPrice - cell.goods.goodsSalePrice;
//    // 设置总价
//    [_shopCartView setTotalPrice:_totalPrice];
//    --self.totalOrders;
//    _shopCartView.badgeValue = self.totalOrders;
//    
//    // 将商品从购物车中移除
//    if (cell.goods.orderCount == 0) {
//        [self.orderArray removeObject:cell.goods];
//    }
//    _shopCartView.detailListView.objects = _orderArray;
//    _shopCartView.orderArray = _orderArray;
//    [_shopCartView updateFrame:_shopCartView.detailListView];
//    [_shopCartView.detailListView.listTableView reloadData];
//    [_rightTableView reloadData];
//}




//- (void)viewDidLoad {
//    [super viewDidLoad];
//    [self showBarButton:NAV_LEFT title:@"郑州↓" fontColor:[UIColor whiteColor]];
//
//    [self initComponents];
//    [self loadSegment];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shopCarBadgeValueAdd:) name:@"kShopCartAdd" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shopCarBadgeValueMinus:) name:@"kShopCartMinus" object:nil];
//}
//
//
////初始化something
//-(void)initComponents
//{
//    allkeys = @[@"啤酒",@"饮料",@"矿泉水",@"瓜子儿",@"大碗面",@"水果",@"萝卜",@"青菜"];
//}
//
////创建垂直的segment
//-(void)loadSegment{
//    
//    //实例化segment
//    self.segmentedControl = [[SMVerticalSegmentedControl alloc] initWithSectionTitles:allkeys];
//    
//    //设置背景颜色
//    self.segmentedControl.backgroundColor = [UIColor whiteColor];
//    
//    //设置类型
//    self.segmentedControl.selectionStyle = SMVerticalSegmentedControlSelectionStyleBox;
//    //设置字体居中
//    self.segmentedControl.textAlignment = SMVerticalSegmentedControlTextAlignmentCenter;
//    
//    self.segmentedControl.selectionIndicatorThickness = 4;
//    
//    //设置frame
//    [self.segmentedControl setFrame:CGRectMake(0, 0, 85, 40*allkeys.count)];
//    
//    self.segmentedControl.layer.borderWidth = 0.5f;
//    
//    self.segmentedControl.layer.borderColor = [UIColor hexStringToColor:@"cccccc"].CGColor;
//   
//    //添加segment
//    [self.view addSubview:self.segmentedControl];
//    
//    //调用block
//    [self.segmentedControl indexChangeBlock:^(NSInteger index) {
//        
//        [self indexChangeBlock:index];
//    }];
//    
//    //设置默认的选中按钮
//    self.segmentedControl.selectedSegmentIndex = 0;
//    
//    if (_segmentedControl) {
//        
//        [self creategoodsTableView];
//    }
//}
//
//-(void)creategoodsTableView
//{
//    _maintableView =[[UITableView alloc]initWithFrame:CGRectMake(_segmentedControl.frame.size.width, 0, Main_Screen_Width-_segmentedControl.frame.size.width, Main_Screen_Height-64) style:UITableViewStylePlain];
//    _maintableView.delegate = self;
//    _maintableView.dataSource = self;
//    _maintableView.rowHeight = 92;
//    [self.view addSubview:_maintableView];
//}
////按钮改变时调用
//-(void)indexChangeBlock:(NSInteger)index{
//    
//    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:index];
//    
//    //使得collectionView跳转到指定的按钮上
//    [_maintableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
//}
//
//#pragma mainTableView delegate & datasource
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 9;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *cellIdentifier= @"CellId";
//    FDHgoodsCell  *cell  = (FDHgoodsCell *)[tableView dequeueReusableCellWithIdentifier: cellIdentifier];
//    if (!cell) {
//        NSBundle *bundle = [NSBundle mainBundle];
//        NSArray *array = [bundle loadNibNamed:@"FDHgoodsCell" owner:nil options:nil];
//        for (id object in array) {
//            if ([object isKindOfClass:[FDHgoodsCell class]]) {
//                cell = (FDHgoodsCell *)object;
//                break;
//            }
//        }
//    }
//    cell.delegate = self;
//    [cell.goodsImageView setImage:[UIImage imageNamed:@"fangbianmain"]];
//    cell.goodsName.text = @"方便面";
//    return cell;
//
//}
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return allkeys.count;
//}
//
//- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return allkeys[section];
//}
//
////单元格结束移动时调用
//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    
//    NSArray *indexArr = [_maintableView indexPathsForVisibleRows];
//    
//    NSIndexPath *lastIndexPath = [indexArr firstObject];
//    
//    self.segmentedControl.selectedSegmentIndex = lastIndexPath.section;
//}
//
////当单元格减速时调用
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    
//    NSArray *indexArr = [_maintableView indexPathsForVisibleRows];
//    
//    NSIndexPath *lastIndexPath = [indexArr firstObject];
//    
//    self.segmentedControl.selectedSegmentIndex = lastIndexPath.section;
//}
//
//#pragma FDHgoodsCellDelegate 
//-(void)addgoodsToshoppingCart:(FDHgoodsCell *)cell
//{
//    NSIndexPath *indexpath = [_maintableView indexPathForCell:cell];
//    
//    [self addProductsAnimation:cell.goodsImageView dropToPoint:CGPointMake(Main_Screen_Width*0.5, self.view.layer.bounds.size.height - 40) isNeedNotification:YES];
//
//}
//-(void)minusgoodsToshoppingCart:(FDHgoodsCell *)cell
//{
//    NSIndexPath *indexpath = [_maintableView indexPathForCell:cell];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"kShopCartMinus" object:nil];
//
//}
//
#pragma mark leftBtn click
-(void)leftButtonTouch
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"当前城市为“郑州”" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

//添加到购物车动画
- (void)addProductsAnimation:(UIImageView *)imageView dropToPoint:(CGPoint)dropToPoint isNeedNotification:(BOOL)isNeedNotification {
    
    self.isNeedNotification = isNeedNotification;
    if (self.animationLayers == nil) {
        self.animationLayers = [[NSMutableArray alloc] init];
    }
    
    CGRect frame = [imageView convertRect:imageView.bounds toView:self.view];
    CALayer *transitionLayer = [[CALayer alloc] init];
    transitionLayer.frame = frame;
    transitionLayer.contents = imageView.layer.contents;
    [self.view.layer addSublayer:transitionLayer];
    [self.animationLayers addObject:transitionLayer];
    
    CGPoint point1 = transitionLayer.position;
    
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, point1.x, point1.y);
    CGPathAddCurveToPoint(path, nil, point1.x, point1.y - 30, dropToPoint.x, point1.y - 30, dropToPoint.x, dropToPoint.y);
    positionAnimation.path = path;
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @1;
    opacityAnimation.toValue = @0.9;
    opacityAnimation.fillMode = kCAFillModeForwards;
    opacityAnimation.removedOnCompletion = YES;
    
    CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    transformAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    transformAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.2, 0.2, 1)];
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[positionAnimation, transformAnimation, opacityAnimation];
    groupAnimation.duration = 0.8;
    groupAnimation.delegate = self;
    
    [transitionLayer addAnimation:groupAnimation forKey:@"cartParabola"];
    
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (self.animationLayers.count > 0) {
        CALayer *layer = self.animationLayers[0];
        layer.hidden = YES;
        [layer removeFromSuperlayer];
        [self.animationLayers removeObjectAtIndex:0];
        [self.view.layer removeAnimationForKey:@"cartParabola"];
        if (self.isNeedNotification) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kShopCartAdd" object:nil];
        }
    }
}

#pragma mark - NSNotification
- (void)shopCarBadgeValueAdd:(NSNotification *)notification {
    
    UIViewController *vc = self.tabBarController.viewControllers[1];
    NSInteger badgeValue = [vc.tabBarItem.badgeValue integerValue];
    badgeValue += 1;
    vc.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld", badgeValue];
    
}
- (void)shopCarBadgeValueMinus:(NSNotification *)notification {
    
    UIViewController *vc = self.tabBarController.viewControllers[1];
    NSInteger badgeValue = [vc.tabBarItem.badgeValue integerValue];
    badgeValue -= 1;
    vc.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld", badgeValue];
    
}

@end

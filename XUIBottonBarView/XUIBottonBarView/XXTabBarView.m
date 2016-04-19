//
//  XXTabBarView.m
//  XUIBottonBarView
//
//  Created by 陈曦 on 16/4/15.
//  Copyright © 2016年 xi chen. All rights reserved.
//

#import "XXCollectionView.h"
#import "XXCollectionViewCell.h"
#import "XXTabBarView.h"

typedef NS_OPTIONS(NSUInteger, RotationType) {
  RotationTypeLeft = 1 << 0,
  RotationTypeRight = 1 << 1,
};

@interface XXTabBarView () <UICollectionViewDelegate,
                            UICollectionViewDataSource>
/**
 *  label控件集合
 */
@property(nonatomic, strong) NSMutableArray<UILabel *> *labelArray;
/**
 *  图片控件集合
 */
@property(nonatomic, strong) NSMutableArray<UIImageView *> *imageArray;
/**
 *  cell 集合
 */
@property(nonatomic, strong) NSMutableArray *cellArray;

@end

@implementation XXTabBarView

- (NSMutableArray *)cellArray {
  if (_cellArray == nil) {
    _cellArray = [NSMutableArray array];
  }
  return _cellArray;
}

- (NSMutableArray *)labelArray {
  if (_labelArray == nil) {
    _labelArray = [NSMutableArray array];
  }
  return _labelArray;
}

- (NSMutableArray *)imageArray {
  if (_imageArray == nil) {
    _imageArray = [NSMutableArray array];
  }
  return _imageArray;
}
#pragma mark - 属性设置完成后调用的布局方法
- (void)OK {

  UICollectionViewFlowLayout *layout =
      [[UICollectionViewFlowLayout alloc] init];
  XXCollectionView *BarView = [[XXCollectionView alloc] initWithFrame:self.frame
                                                 collectionViewLayout:layout];

  CGFloat itemWidth = self.frame.size.width / self.tabarIconArray.count;
  CGFloat itemHeight = self.frame.size.height;
  NSLog(@"%f,%f", itemWidth, itemHeight);

  layout.itemSize = CGSizeMake(itemWidth, itemHeight);
  layout.minimumInteritemSpacing = 0;
  layout.minimumLineSpacing = 0;

  BarView.delegate = self;
  BarView.dataSource = self;

  [self addSubview:BarView];

  [BarView registerClass:[UICollectionViewCell class]
      forCellWithReuseIdentifier:@"id"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {

  return self.tabarIconArray.count;
}

#pragma mark - 返回 cell 样式
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {

  XXCollectionViewCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:@"id"
                                                forIndexPath:indexPath];
  cell.backgroundColor = self.tabBarbackgroundColor;

  UIImage *image = [UIImage imageNamed:self.tabarIconArray[indexPath.row]];

  UIImageView *imageView = [[UIImageView alloc] initWithImage:image];

  if (self.tabarImageSize.x) {
    imageView.bounds =
        CGRectMake(0, 0, self.tabarImageSize.x, self.tabarImageSize.y);
  }

  NSLog(@"%@", NSStringFromCGRect(imageView.bounds));
  imageView.center =
      CGPointMake(cell.bounds.size.width / 2, cell.bounds.size.height / 2 - 5);
  UILabel *label = [[UILabel alloc] init];
  label.textColor = self.textColor;
  label.text = self.tabarTitleArray[indexPath.row];
  label.font = [UIFont systemFontOfSize:10];
  [label sizeToFit];
  label.center =
      CGPointMake(cell.bounds.size.width / 2, cell.bounds.size.height - 8);
  [self.imageArray addObject:imageView];
  [self.labelArray addObject:label];
  NSLog(@"%@", label);

  [cell addSubview:imageView];
  [cell addSubview:label];

  if (self.defaultItem > -1) {

    if (indexPath.row == self.defaultItem) {

      cell.selected = YES;
      self.imageArray[self.defaultItem].image =
          [UIImage imageNamed:self.tabarBackIconArray[self.defaultItem]];
      self.labelArray[self.defaultItem].textColor = self.tectHightColor;
    }
  } else {
    if (indexPath.row == 0) {

      self.imageArray[self.defaultItem].image =
          [UIImage imageNamed:self.tabarBackIconArray[self.defaultItem]];
      self.labelArray[self.defaultItem].textColor = self.tectHightColor;
    }
  }

  [self.cellArray addObject:cell];

  return cell;
}
/**
 * cell 点击的代理方法.通过点击 cell. 让 cell
 * 内部的控件做相应的操作.并调用自己的代理方法.传出这个被点击的 cell 的 index;
 */
#pragma mark - cell 的点击响应事件
- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

  for (int i = 0; i < self.imageArray.count; i++) {
    self.imageArray[i].image = [UIImage imageNamed:self.tabarIconArray[i]];
  }

  for (UILabel *label in self.labelArray) {
    label.textColor = self.textColor;
  }
  for (XXCollectionViewCell *cell in self.cellArray) {
    cell.selected = NO;
  }
//  UILabel *Clicklabel = self.labelArray[indexPath.row];
//  Clicklabel.textColor = self.tectHightColor;

  if ([self.delegate
          respondsToSelector:@selector(XXTabBarView:didClickTaBarItemIndex:)]) {

    [self.delegate XXTabBarView:self didClickTaBarItemIndex:(int)indexPath.row];
  }

  UIImage *himage = [UIImage imageNamed:self.tabarBackIconArray[indexPath.row]];

  [self IconAnimation:self.imageArray[indexPath.row]
             wihtlabelColor:self.labelArray[indexPath.row]
      withIconBackImageName:himage];
}
#pragma mark - 代码设置某个 item显示的类方法
- (void)selectedIteme:(int)index {

  for (XXCollectionViewCell *cell in self.cellArray) {
    cell.selected = NO;
  }

  for (UILabel *label in self.labelArray) {
    label.textColor = self.textColor;
  }

  for (int i; i < self.imageArray.count; i++) {

    self.imageArray[i].image = [UIImage imageNamed:self.tabarIconArray[i]];
  }

//  UILabel *Clicklabel = self.labelArray[index];
//
////  Clicklabel.textColor = self.tectHightColor;

  XXCollectionViewCell *cell = self.cellArray[index];
  cell.selected = YES;

//  self.imageArray[index].image =
//      [UIImage imageNamed:self.tabarBackIconArray[index]];
//    
      UIImage *himage = [UIImage imageNamed:self.tabarBackIconArray[index]];
    [self IconAnimation:self.imageArray[index] wihtlabelColor:self.labelArray[index] withIconBackImageName:himage];
}
#pragma mark - 图标的动画逻辑判断
- (void)IconAnimation:(UIImageView *)imageView
       wihtlabelColor:(UILabel *)label
withIconBackImageName:(UIImage *)imageName {
  if (self.animationType) {

    switch (self.animationType) {
    case XXTabBarViewItemIconAnimationTypeLeftRotation:

      [self iconLeftRotation:imageView
                      withlabel:label
                wihtleftOrRight:RotationTypeLeft
          withIconBackImageName:imageName];

      break;
    case XXTabBarViewItemIconAnimationTypeRightRotation:
      [self iconLeftRotation:imageView
                      withlabel:label
                wihtleftOrRight:RotationTypeRight
          withIconBackImageName:imageName];
      break;

    default:
      break;
    }
  } else {

    imageView.image = imageName;
  };
}

#pragma mark - icon 的动画效果方法

- (void)iconLeftRotation:(UIImageView *)imageView
               withlabel:(UILabel *)label
         wihtleftOrRight:(RotationType)type
   withIconBackImageName:(UIImage *)imageName {
  dispatch_async(dispatch_get_main_queue(), ^{

    CAAnimationGroup *group = [CAAnimationGroup animation];

    CABasicAnimation *caBasic =
        [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    if (type == RotationTypeLeft) {
      caBasic.byValue = @(-M_PI * 2 * 1);
    } else if (type == RotationTypeRight) {
      caBasic.byValue = @(M_PI * 2 * 1);
    }
    group.animations = @[ caBasic ];

    group.duration = 0.7;
    group.repeatCount = 1;

    [imageView.layer addAnimation:group forKey:@"group_anim"];

    // --- 这段带来是在动画异步主线程的动画结束之后做的事情;
    dispatch_time_t popTime =
        dispatch_time(DISPATCH_TIME_NOW, group.duration * NSEC_PER_SEC);

    dispatch_after(popTime, dispatch_get_main_queue(), ^{

      imageView.image = imageName;
        label.textColor = self.tectHightColor;

    });

  });
}

@end

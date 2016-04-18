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

@interface XXTabBarView () <UICollectionViewDelegate,
                            UICollectionViewDataSource>

@property(nonatomic, strong) NSMutableArray *labelArray;
@property(nonatomic, strong) NSMutableArray *imageArray;

@end

@implementation XXTabBarView

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

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {

  XXCollectionViewCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:@"id"
                                                forIndexPath:indexPath];
  cell.backgroundColor = self.tabBarbackgroundColor;

  UIImage *image = [UIImage imageNamed:self.tabarIconArray[indexPath.row]];
  UIImage *himage = [UIImage imageNamed:self.tabarBackIconArray[indexPath.row]];

  UIImageView *imageView =
      [[UIImageView alloc] initWithImage:image highlightedImage:himage];

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

  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

  for (UILabel *label in self.labelArray) {
    label.textColor = self.textColor;
  }
  UILabel *Clicklabel = self.labelArray[indexPath.row];
  Clicklabel.textColor = self.tectHightColor;
    
    if([self.delegate respondsToSelector:@selector(XXTabBarView:didClickTaBarItemIndex:)]){
    
        [self.delegate XXTabBarView:self didClickTaBarItemIndex:(int)indexPath.row];
    
    }
    
}

@end

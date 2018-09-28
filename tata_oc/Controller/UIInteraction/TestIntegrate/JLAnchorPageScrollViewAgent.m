//
//  JLAnchorPageScrollViewAgent.m
//  呱呱直播
//
//  Created by yongming on 2018/9/25.
//  Copyright © 2018年 com.julelive. All rights reserved.
//

#import "JLAnchorPageScrollViewAgent.h"
#import "YMScrollView.h"

@interface JLAnchorPageScrollViewAgent () <UIScrollViewDelegate, UITableViewDelegate>
{
    BOOL _hasScroll;
    BOOL _hasSubScroll;
    CGFloat _headerViewHeight;
}

@property (nonatomic, strong) UIScrollView* containerView;
@property (nonatomic, strong) UITableView* leftView;
@property (nonatomic, strong) UITableView* rightView;

@end

@implementation JLAnchorPageScrollViewAgent

- (void)setupAgent:(UIView*)parentView
          leftView:(UITableView *)leftView
         rightView:(UITableView *)rightView
        headerView:(UIView*)headerView
      headerHeight:(CGFloat)headerHeight
{
    _headerViewHeight = headerHeight;
    
    YMScrollView* container = [[YMScrollView alloc]initWithFrame:parentView.bounds];
    [parentView addSubview:container];
    
    [container setContentSize:CGSizeMake(parentView.bounds.size.width, parentView.bounds.size.height + headerHeight)];
    container.delegate = self;
    [self setContainerView:container];
    
    [container addSubview:headerView];
    
    CGRect bounds = parentView.bounds;
    UIScrollView* bottomScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, headerHeight, bounds.size.width, bounds.size.height)];
    [container addSubview:bottomScroll];
    [bottomScroll setContentSize:CGSizeMake(bounds.size.width*2, bounds.size.height)];
    
    bottomScroll.pagingEnabled = YES;
    
    {
        leftView.frame = bounds;
        [bottomScroll addSubview:leftView];
        
        rightView.frame = CGRectMake(bounds.size.width, 0, bounds.size.width, bounds.size.height);
        [bottomScroll addSubview:rightView];
        
        [self setLeftView:leftView];
        [self setRightView:rightView];
    }
    
    leftView.delegate = self;
    rightView.delegate = self;
    
    self.containerView.showsVerticalScrollIndicator = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint mainPT = scrollView.contentOffset;
    
    if (scrollView == self.containerView) {
        
//        NSLog(@"offset:%@", NSStringFromCGPoint(mainPT));
        
        if (mainPT.y < _headerViewHeight && !_hasScroll) {
            self.leftView.contentOffset = CGPointMake(0, 0);
            self.rightView.contentOffset = CGPointMake(0, 0);
            [self showContainerIndicator:YES];
        } else {
            self.containerView.contentOffset = CGPointMake(0, _headerViewHeight);
            _hasScroll = YES;
            _hasSubScroll = NO;
            [self showContainerIndicator:NO];
        }
        
    } else if (scrollView == self.leftView || scrollView == self.rightView) {
        
//        NSLog(@"====> offset:%@", NSStringFromCGPoint(mainPT));
        
        if (mainPT.y > 0 && !_hasSubScroll && _hasScroll) {
            self.containerView.contentOffset = CGPointMake(0, _headerViewHeight);
            [self showContainerIndicator:NO];
        } else {
            _hasScroll = NO;
            _hasSubScroll = YES;
            [self showContainerIndicator:YES];
        }
    }
}

- (void)showContainerIndicator:(BOOL)show
{
    self.containerView.showsVerticalScrollIndicator = show;
    self.leftView.showsVerticalScrollIndicator = !show;
    self.rightView.showsVerticalScrollIndicator = !show;
}

#pragma mark - UITableView delegate

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (self.leftView == tableView) {
//        self.leftView
//    }
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.leftView == tableView) {
        [self.leftVC didSelectRowAtIndexPath:indexPath];
    } else {
        [self.rightVC didSelectRowAtIndexPath:indexPath];
    }
}

@end

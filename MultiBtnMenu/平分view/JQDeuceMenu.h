//
//  JQDeuceMenu.h
//  masonry测试
//
//  Created by 韩军强 on 2017/11/7.
//  Copyright © 2017年 韩军强. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    JQDeuceMenuHorizontal,
    JQDeuceMenuVertical,
} JQDeuceMenuStyle;

typedef void(^ClickBlock)(NSInteger index);
@interface JQDeuceMenu : UIView

@property (nonatomic, strong) UILabel *linelbl;

@property (nonatomic, strong) NSMutableArray *imgNamesArray;

@property (nonatomic, copy) ClickBlock clickBlcok;

/**
 ➤ 无点击事件
 参数解释：

 @param frame 自定义view的frame
 @param imgNamesArray 图片选中和未选中的名字（即数组中每个对象也是数组，比如：@[@[@"btn1.jpg",@"btn1Select.jpg"] ]）
 @return 自定义view对象
 
 注意：
     1，如果图片有未显示完全的情况，一般是因为图片尺寸不对。
     2，imgNamesArray的数量至少2个。
 */
-(instancetype)jq_initWithFrame:(CGRect)frame imgNamesArray:(NSMutableArray *)imgNamesArray;

//比上个方法多了个设置下划线高度的参数。
-(instancetype)jq_initWithFrame:(CGRect)frame imgNamesArray:(NSMutableArray *)imgNamesArray lineHeight:(CGFloat)lineHeight;


//--------------------------------无点击事件⤴️，有点击事件⤵️--------------------------------------


/**
 ➤ 有点击事件
 默认为水平方向平分，如果想竖直方向，请使用另一种方式。（推荐：如果是水平方向平分用该方法）

 @param frame 自定义view的frame
 @param imgNamesArray 同上
 @param lineHeight 下划线的高度
 @param clickBlock 点击按钮的回调
 @return 自定义view对象
 */
-(instancetype)jq_initWithFrame:(CGRect)frame imgNamesArray:(NSMutableArray *)imgNamesArray lineHeight:(CGFloat)lineHeight click:(ClickBlock)clickBlock;


/**
 ➤ 有点击事件
 可以控制水平平分还是竖直平分。（推荐：如果是竖直方向平分用该方法）
 
 @param frame 自定义view的frame
 @param style 控制水平和竖直方向。
 @param lineHeight 下划线的高度
 @param imgNamesArray 同上
 @param clickBlock 点击按钮的回调
 @return 自定义view对象
 
 */
-(instancetype)jq_initWithFrame:(CGRect)frame stype:(JQDeuceMenuStyle)style lineHeight:(CGFloat)lineHeight imgNamesArray:(NSMutableArray *)imgNamesArray click:(ClickBlock)clickBlock;


@end

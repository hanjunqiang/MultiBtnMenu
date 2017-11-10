//
//  JQDeuceMenu.m
//  masonry测试
//
//  Created by 韩军强 on 2017/11/7.
//  Copyright © 2017年 韩军强. All rights reserved.
//

#import "JQDeuceMenu.h"
#import <Masonry.h>

@interface JQDeuceMenu()

//存储所有按钮
@property (nonatomic, strong) NSMutableArray *btnsArray;    //存放创建的数组

@property (nonatomic, assign) CGFloat lineHeight;   //下划线高度

@property (nonatomic, strong) UIButton *selectBtn;  //防止选中的按钮重复点击

@property (nonatomic, assign) JQDeuceMenuStyle style; //平分方向

@property (nonatomic, assign) CGFloat jq_lineWH; //平分按钮的宽/高
@end

@implementation JQDeuceMenu

-(NSMutableArray *)btnsArray{
    if (_btnsArray == nil) {
        _btnsArray = [NSMutableArray array];
    }
    return _btnsArray;
}

-(NSMutableArray *)imgNamesArray{
    if (_imgNamesArray == nil) {
        _imgNamesArray = [NSMutableArray array];
    }
    return _imgNamesArray;
}


-(instancetype)jq_initWithFrame:(CGRect)frame imgNamesArray:(NSMutableArray *)imgNamesArray
{
    self.imgNamesArray = imgNamesArray;
    
   return [self initWithFrame:frame];
}

-(instancetype)jq_initWithFrame:(CGRect)frame imgNamesArray:(NSMutableArray *)imgNamesArray lineHeight:(CGFloat)lineHeight
{
    self.imgNamesArray = imgNamesArray;
    self.lineHeight = lineHeight;
    
    return [self initWithFrame:frame];
}

-(instancetype)jq_initWithFrame:(CGRect)frame imgNamesArray:(NSMutableArray *)imgNamesArray lineHeight:(CGFloat)lineHeight click:(ClickBlock)clickBlock
{
    self.imgNamesArray = imgNamesArray;
    self.lineHeight = lineHeight;
    
    if (clickBlock) {
        self.clickBlcok = clickBlock;
    }
    
    return [self initWithFrame:frame];
}

-(instancetype)jq_initWithFrame:(CGRect)frame stype:(JQDeuceMenuStyle)style lineHeight:(CGFloat)lineHeight imgNamesArray:(NSMutableArray *)imgNamesArray click:(ClickBlock)clickBlock
{
    self.imgNamesArray = imgNamesArray;
    self.lineHeight = lineHeight;
    self.style = style;
    
    if (clickBlock) {
        self.clickBlcok = clickBlock;
    }
    
    return [self initWithFrame:frame];
}

/**
        注意：使用alloc in withFrame,初始化的时候不会调用init方法
    */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        if (self.imgNamesArray.count == 0) {
            NSLog(@"self.imgNamesArray不能为空！");
            return nil;
        }

        for (int i = 0; i<self.imgNamesArray.count; i++) {
            
            UIButton *btn = [[UIButton alloc] init];
            [self addSubview:btn];

            /**
             
                 作用：关闭长按按钮时的高亮状态
             
                 问题：如果按钮处于选中状态，那么这时候长按按钮，按钮也是处于非高亮状态。（坑~~~）
             
                 解决方式：
                 其实，按钮处于选中状态，然后长按按钮，是一种复合状态(UIControlStateSelected|UIControlStateHighlighted)
             
            */
            btn.adjustsImageWhenHighlighted = NO;

            [btn setImage:[UIImage imageNamed:self.imgNamesArray[i][0]] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:self.imgNamesArray[i][1]] forState:UIControlStateSelected];
            [btn setImage:[UIImage imageNamed:self.imgNamesArray[i][1]] forState:UIControlStateSelected|UIControlStateHighlighted]; //复合状态
            
            [btn addTarget:self action:@selector(jq_clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            if (i == 0) {
                btn.selected = YES;
                self.selectBtn = btn;
            }
            
            btn.tag = i;
            [self.btnsArray addObject:btn];
        }
        
        /**
             注意！！！
             不要写成如下形式（先初始化局部变量，然后赋值给全局变量），因为在masonry中用到self.jq_lineWH会报约束冲突。
             CGFloat jq_lineWH = 0.0;
             self.jq_lineWH = jq_lineWH;
         
             解决方式：
             直接赋值即可。
        */
        
        if (self.style == JQDeuceMenuVertical) {
            
            self.jq_lineWH = self.frame.size.height/3;
            
            //➤ 假设这里设置的为水平方向间距
            [self.btnsArray mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
            
            //➤ 这里要控制竖直方向的约束
            [self.btnsArray mas_makeConstraints:^(MASConstraintMaker *make) {
                
                //MASAxisTypeVertical
                make.left.mas_equalTo(@0);
                make.right.mas_equalTo(@0);
            }];

        }else{
            
            self.jq_lineWH = self.frame.size.width/3;
            
            //➤ 假设这里设置的为水平方向间距
            [self.btnsArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
            
            //➤ 这里要控制竖直方向的约束
            [self.btnsArray mas_makeConstraints:^(MASConstraintMaker *make) {
                
                //MASAxisTypeHorizontal
                make.top.mas_equalTo(@0);
                make.bottom.mas_equalTo(@0);
            }];
            
        }
        
        
        
        //如果有按钮存在，设置下划线
        if (self.imgNamesArray.count) {
            
            //下划线默认放到第一个按钮下面
            UIButton *btn1 = self.btnsArray[0];
            
            UILabel *linelbl = [UILabel new];
            [self addSubview:linelbl];
            
            self.linelbl = linelbl;
            linelbl.backgroundColor = [UIColor blueColor];
            
            [linelbl mas_makeConstraints:^(MASConstraintMaker *make) {
                //            make.centerY.mas_equalTo(btn1.centerY);   //这种方式，结果不对
                
                if (self.style == JQDeuceMenuVertical) {
                    //其实self.jq_lineWH可以直接用self.height/3代替，这里是为了演示上面self.jq_lineWH初始化时候的注意点。
                    make.top.left.bottom.mas_equalTo(btn1);
                    make.size.mas_equalTo(CGSizeMake(self.lineHeight?self.lineHeight:2,self.jq_lineWH));
                }else{
                    make.left.right.bottom.mas_equalTo(btn1);
                    make.size.mas_equalTo(CGSizeMake(self.jq_lineWH, self.lineHeight?self.lineHeight:2));
                }
                
            }];
        
        }
        
        
        
    }
    return self;
}

#pragma Mrhan- 按钮点击方法
-(void)jq_clickBtn:(UIButton *)button
{
    //防止选中的按钮重复点击
    if (self.selectBtn == button) {
        return;
    }
    
    for (UIButton *btn in self.btnsArray) {
        
        if (btn == button) {
            btn.selected = YES;
            self.selectBtn = btn;   //记录选中的按钮
            
            //更新linelbl的位置（带有动画效果）
            [self.linelbl mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                if (self.style == JQDeuceMenuVertical) {
                    
                    make.top.left.bottom.mas_equalTo(btn);
                    make.size.mas_equalTo(CGSizeMake(self.lineHeight?self.lineHeight:2,self.jq_lineWH));
                }else{
                    make.left.right.bottom.mas_equalTo(btn);
                    make.size.mas_equalTo(CGSizeMake(self.jq_lineWH, self.lineHeight?self.lineHeight:2));
                }
                
            }];
            
            [UIView animateWithDuration:0.2 animations:^{
                
                [self.linelbl.superview layoutIfNeeded];
            }];
            
        }else{
            btn.selected = NO;

        }
        
    }
    
    if (self.clickBlcok) {
        self.clickBlcok(button.tag);
    }
}

@end

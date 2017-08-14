//
//  DataPickerViewDemo.m
//  ChooseTimePickerView
//
//  Created by ZT on 2017/7/2.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "DataPickerViewOneDemo.h"
#define EndTime @"2018-12-01"
static DataPickerViewOneDemo *pikerView = nil;
@interface DataPickerViewOneDemo ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,strong)UIView *headerView;
@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UIPickerView *pickView;
@property (nonatomic,strong)UIView *backView;
@end

@implementation DataPickerViewOneDemo {
    NSInteger _currentSelectedRow;
    NSInteger _currentSelectComponent;
    UILabel *_titleLable;
}

+(DataPickerViewOneDemo* )sharedPikerView {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!pikerView) {
            pikerView = [[DataPickerViewOneDemo alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        }
    });
    return pikerView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.backView];
        [self.backView addSubview:self.headerView];
        [self.backView addSubview:self.pickView];
        [self.backView addSubview:self.bottomView];
    }
    return self;
}

- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    if (dataSource.count==0) {
        return;
    }
    [self.pickView reloadAllComponents];
}


- (void)show {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.backgroundColor = [UIColor clearColor];
    self.backView.transform = CGAffineTransformMakeScale(0.7, 0.7);
    [window addSubview:self];
    [UIView animateWithDuration:0.35 animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.backView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        self.backView.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
    
}
- (void)dismiss {
    [UIView animateWithDuration:0.35 animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.backView.transform = CGAffineTransformMakeTranslation(0, [UIScreen mainScreen].bounds.size.height-150);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return _dataSource.count;
}

// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _currentSelectedRow = row;
    _currentSelectComponent = component;
    [self.pickView reloadComponent:_currentSelectComponent];   //一定要写这句
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    //设置分割线的颜色
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            singleLine.backgroundColor = [UIColor clearColor];
        }
    }
    // 这里用label来展示要显示的文字, 然后可以用label的textAlignment来设置文字的对齐模式
    UILabel *myView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.0, [UIScreen mainScreen].bounds.size.width-20, 35)];
    myView.font = [UIFont systemFontOfSize:16];
    myView.backgroundColor = [UIColor clearColor];
    myView.textAlignment = NSTextAlignmentCenter;
    if (_currentSelectedRow == row) {
        myView.textColor = [UIColor redColor];
    }
    else {
        myView.textColor = [UIColor darkGrayColor];
    }
    myView.text =_dataSource[row];
    return myView;
}


- (UIView *)headerView {
    
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.backView.frame.size.width, 49)];
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _headerView.frame.size.width, 49)];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.font = [UIFont systemFontOfSize:14];
        lable.text = @"请选择";
        _titleLable = lable;
        lable.textColor = [UIColor darkGrayColor];
        [_headerView addSubview:lable];
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLable.text = title;
}

- (UIPickerView *)pickView {
    if (!_pickView) {
        _pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 49.5, self.backView.frame.size.width, 100)];
        _pickView.delegate = self;
        _pickView.dataSource = self;
        _pickView.backgroundColor = [UIColor whiteColor];
    }
    return _pickView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 150, self.backView.frame.size.width, 49)];
        _bottomView.backgroundColor = [UIColor whiteColor];
        //可以创建想要的Btn
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(0, 0, _bottomView.frame.size.width/2, 49);
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //        cancelBtn.backgroundColor = [UIColor cyanColor];
        [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:cancelBtn];
        UIButton *determineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        determineBtn.frame = CGRectMake(_bottomView.frame.size.width/2, 0, _bottomView.frame.size.width/2, 49);
        [determineBtn setTitle:@"确定" forState:UIControlStateNormal];
        determineBtn.backgroundColor = [UIColor redColor];
        [determineBtn addTarget:self action:@selector(determineBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:determineBtn];
    }
    return _bottomView;
}
- (void)cancelBtnClick
{
    [self dismiss];
    NSLog(@"取消");
}
- (void)determineBtnClick
{
    [self dismiss];
    NSInteger oneComRow =[self.pickView selectedRowInComponent:0];
    if (self.pikerSelected) {
        self.pikerSelected(_dataSource[oneComRow]);
    }
    
}

- (UIView *)backView {
    if (!_backView) {
        _backView =[[UIView alloc]initWithFrame:CGRectMake(20, 150, self.frame.size.width-40, 197)];
        _backView.backgroundColor = [UIColor lightGrayColor];
        _backView.layer.masksToBounds= YES;
        _backView.layer.cornerRadius = 10;
    }
    return _backView;
}
@end

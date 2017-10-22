//
//  MySchedulingController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/10/12.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "MySchedulingController.h"
#import "NSDate+Formatter.h"
#import "NSDate+Extension.h"
#import "CALayer+UIColor.h"
#import "UIView+KC.h"
#import "UpPartHttpManager.h"

#define Iphone6Scale(x) ((x) * kScreenWidth / 375.0f)
#define HeaderViewHeight 30

#define DELAY(time,block) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(),block)

#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)

#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)


#define kScreenWidth \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.width)

#define kScreenHeight \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.height)

#define kRGBColor(r, g, b)    [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface MySchedulingController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *dayModelArray;
@property (strong, nonatomic) NSDate *tempDate;
@property (nonatomic,copy)  NSString *seletedData;


// 年label
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;

// 月份选择相关
@property (weak, nonatomic) IBOutlet UIButton *month1;
@property (weak, nonatomic) IBOutlet UIButton *month2;
@property (weak, nonatomic) IBOutlet UIButton *month3;
//@property (strong, nonatomic) NSDate *currentDate;
//@property (strong, nonatomic) NSDate *nextDate;
//@property (strong, nonatomic) NSDate *nextNextDate;

@property (strong, nonatomic) NSDate *chooseDate;

@property (weak, nonatomic) IBOutlet UIView *line;

@property (nonatomic,assign)BOOL isAnimation;

@property (nonatomic,strong) UIButton *button;
@property (nonatomic,strong) UILabel *selectTime;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation MySchedulingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(247, 247, 247);
    [self titleViewWithTitle:@"我的排班" titleColor:[UIColor whiteColor]];
    self.dayModelArray = [NSMutableArray array];
    [self.view addSubview:self.collectionView];
    self.tempDate = [NSDate date];
    _chooseDate = [NSDate date];
    // 显示选择时间的UILabel
    _selectTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    _selectTime.textAlignment = NSTextAlignmentCenter;
    _selectTime.font = [UIFont systemFontOfSize:20];
    _selectTime.backgroundColor = [UIColor whiteColor];
    _selectTime.textColor = kRGBColor(106, 148, 39);
    _selectTime.text = [NSString stringWithFormat:@"%@",_seletedData];
//    _selectTime.text = [NSString stringWithFormat:@"%ld年%ld月",_chooseDate.year,_chooseDate.month];

    [self.view addSubview:_selectTime];
    
    // 创建左右按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(35, 12, 25, 25);
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"icon_previous"] forState:UIControlStateNormal];
    leftBtn.backgroundColor = kRGBColor(106, 148, 39);
    [leftBtn addTarget:self action:@selector(lastMouth) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(SCREEN_WIDTH-60, 12, 25, 25);
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"icon_next"] forState:UIControlStateNormal];
    rightBtn.backgroundColor = kRGBColor(106, 148, 39);
    [rightBtn addTarget:self action:@selector(nextMouth) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn];

    
    // 下面的蓝线
    UIView *lineViewTwo = [[UIView alloc] initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
    lineViewTwo.backgroundColor = kRGBColor(0, 134, 237);
    
    [self.view addSubview:lineViewTwo];
    [self currentMonth];

    [self requestScheduling];
    
}

- (void)leftBtnClick{
    NSLog(@"哈哈");
}

// 排班计划--查
- (void)requestScheduling{
    @weakify(self);
    [UpPartHttpManager requestWorkerId:@""
                                 orgId:@""
                                deptId:@""
                             startTime:@"2017-09-01"
                               endTime:@"2017-10-19"
                         workShiftType:@""
                            workPlanId:@""
                             machineId:[getUUID getUUID]
                           machineName:[Tools deviceVersion]
                            clientType:@""
                               success:^(id response) {
                                   @strongify(self);
                                   [self.dataSource removeAllObjects];
                                   [self.dataSource addObjectsFromArray:response];
                                   [self.collectionView reloadData];
                                   //[self.tableView reloadData];
                               } failure:^(NSError *error, NSString *message) {
                               
                               }];
}

//键盘失去响应
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITextField *t1 = (UITextField *)[self.view viewWithTag:111];
    UITextField *t2 = (UITextField *)[self.view viewWithTag:112];
    UITextField *t3 = (UITextField *)[self.view viewWithTag:113];
    
    [t1 resignFirstResponder];
    [t2 resignFirstResponder];
    [t3 resignFirstResponder];
}

//调到目标时间
- (void) targetMonth{
    UITextField *t1 = (UITextField *)[self.view viewWithTag:111];
    UITextField *t2 = (UITextField *)[self.view viewWithTag:112];
    UITextField *t3 = (UITextField *)[self.view viewWithTag:113];
    
    _chooseDate = [self getCurrentMonth:self.tempDate andYear:[t1.text integerValue] andMonth:[t2.text integerValue] andDay:[t3.text integerValue] ];
    [self getDataDayModel:_chooseDate];
    self.navigationItem.title = [NSString stringWithFormat:@"%ld年%ld月",_chooseDate.year,_chooseDate.month];
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    UITextField *t1 = (UITextField *)[self.view viewWithTag:111];
    UITextField *t2 = (UITextField *)[self.view viewWithTag:112];
    UITextField *t3 = (UITextField *)[self.view viewWithTag:113];
    
    if (t1.text == nil) {
        t1.text = @"2017年";
    }
    
    NSString *title = [NSString stringWithFormat:@"跳转到%@年%@月%@日",t1.text,t2.text,t3.text];
    
    [_button setTitle:title forState:(UIControlStateNormal)];
}


//当前月
- (void) currentMonth{
    _chooseDate = [self getCurrentMonth:self.tempDate];
    [self getDataDayModel:_chooseDate];
    self.selectTime.text =_chooseDate.yyyyMMddByLineWithDate;
    _seletedData = _chooseDate.yyyyMMddByLineWithDate;
    
}

//上个月
- (void)lastMouth{
    
    _chooseDate = [self getLastMonth:_chooseDate];
    [self getDataDayModel:_chooseDate];
    self.navigationItem.title = [NSString stringWithFormat:@"%ld年%ld月",_chooseDate.year,_chooseDate.month];
}

//下个月
- (void)nextMouth{
    _chooseDate = [self getNextMonth:_chooseDate];
    [self getDataDayModel:_chooseDate];
    self.navigationItem.title = [NSString stringWithFormat:@"%ld年%ld月",_chooseDate.year,_chooseDate.month];
    
}

//根据目标日期来显示目标对应月的日期布局
- (void)getDataDayModel:(NSDate *)date{
    [self.dayModelArray removeAllObjects];
    NSUInteger days = [self numberOfDaysInMonth:date];
    NSInteger week = [self startDayOfWeek:date];
    int day = 1;
    for (int i= 1; i<days+week; i++) {
        if (i<week) {
            MonthModel *mon = [MonthModel new];
            mon.isCanClick = NO;
            mon.dayValue = 0;
            [self.dayModelArray addObject:mon];
        }else{
            MonthModel *mon = [MonthModel new];
            mon.dayValue = day;
            NSDate *dayDate = [self dateOfDay:day];
            mon.dateValue = dayDate;
            
            NSString *str1 = dayDate.yyyyMMddByLineWithDate;
            NSString *str2 = [NSDate date].yyyyMMddByLineWithDate;
            if ([str1 isEqualToString:str2]) {
                mon.isSelectedDay = YES;
            }
            
            if ([NSDate compareOneDay:dayDate.yyyyMMddByLineWithDate  withAnotherDay:[NSDate date].yyyyMMddByLineWithDate] >= 0) {
                mon.isCanClick = YES;
            } else {
                mon.isCanClick = YES;
            }
            
            [self.dayModelArray addObject:mon];
            day++;
        }
    }
    
    MAIN(^{
        [self.collectionView reloadData];
    });
    
}




#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dayModelArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CalendarCell" forIndexPath:indexPath];
    
    if (_isAnimation) {
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
        
        //设置动画时间为0.25秒,xy方向缩放的最终值为1
        
        [UIView animateWithDuration:0.5 animations:^{
            
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
            
        }];
    }
    
    
    id mon = self.dayModelArray[indexPath.row];
    if ([mon isKindOfClass:[MonthModel class]]) {
        cell.monthModel = (MonthModel *)mon;
    }else{
        cell.dayLabel.text = @"";
    }
    
    if ([(MonthModel *)mon dayValue] == 0) {
        cell.dayLabel.text = @"";
    }
    
    if ([_seletedData isEqualToString:[(MonthModel *)mon dateValue].yyyyMMddByLineWithDate]) {
        //        如果是当前选择的那一天，加个背景
        cell.backgroundColor = kRGBColor(24, 147, 239);
        cell.dayLabel.textColor = [UIColor whiteColor];

    }else {
        cell.backgroundColor = [UIColor whiteColor];
        
        if ([(MonthModel *)mon isCanClick]) {
            cell.dayLabel.textColor = [UIColor blackColor];
        } else {
            cell.dayLabel.textColor = [UIColor lightGrayColor];
        }
    }
    cell.modelArray = self.dataSource;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    CalendarHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CalendarHeaderView" forIndexPath:indexPath];
    return headerView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    id mon = self.dayModelArray[indexPath.row];
    if ([mon isKindOfClass:[MonthModel class]]) {
        _seletedData        = [(MonthModel *)mon dateValue].yyyyMMddByLineWithDate;
        _selectTime.text = [NSString stringWithFormat:@"%@",_seletedData];
        
    }
    
    if (_type == ThroughTrain) {
        if (_dateAction != nil) {
            _dateAction([(MonthModel *)mon dateValue]);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
    _isAnimation = NO;
    DELAY(0.25, ^{
        _isAnimation = YES;
    });
    
    [self.collectionView reloadData];
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        NSInteger width = Iphone6Scale(54);
        //        NSInteger height = Iphone6Scale(54);
        NSInteger height = 45;
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(width, height);
        flowLayout.headerReferenceSize = CGSizeMake(kScreenWidth, HeaderViewHeight);
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 50, width * 7, height * 6 + HeaderViewHeight - 50) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        [_collectionView registerClass:[CalendarCell class] forCellWithReuseIdentifier:@"CalendarCell"];
        [_collectionView registerClass:[CalendarHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CalendarHeaderView"];
        UISwipeGestureRecognizer *swipeGestureRecognizerL=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(nextOrLast:)];
        
        swipeGestureRecognizerL.direction = UISwipeGestureRecognizerDirectionLeft;
        
        [_collectionView addGestureRecognizer:swipeGestureRecognizerL];
        
        
        UISwipeGestureRecognizer *swipeGestureRecognizerR=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(nextOrLast:)];
        
        swipeGestureRecognizerR.direction = UISwipeGestureRecognizerDirectionRight;
        
        [_collectionView addGestureRecognizer:swipeGestureRecognizerR];
        
        _collectionView.bounces = NO;
    }
    return _collectionView;
}



- (void)nextOrLast:(UISwipeGestureRecognizer *)pan{
    
    if (pan.direction == UISwipeGestureRecognizerDirectionRight) {
        [self lastMouth];
        
    }else if (pan.direction == UISwipeGestureRecognizerDirectionLeft){
        
        [self nextMouth];
    }
    
}



#pragma mark -Private
//返回当月天数
- (NSUInteger)numberOfDaysInMonth:(NSDate *)date{
    NSCalendar *greCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [greCalendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    return [greCalendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;
    
}

//返回当月第一天数据
- (NSDate *)firstDateOfMonth:(NSDate *)date{
    NSCalendar *greCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [greCalendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSDateComponents *comps = [greCalendar
                               components:NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitWeekday | NSCalendarUnitDay
                               fromDate:date];
    comps.day = 1;
    return [greCalendar dateFromComponents:comps];
}


- (NSUInteger)startDayOfWeek:(NSDate *)date
{
    NSCalendar *greCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [greCalendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];//Asia/Shanghai
    NSDateComponents *comps = [greCalendar
                               components:NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitWeekday | NSCalendarUnitDay
                               fromDate:[self firstDateOfMonth:date]];
    return comps.weekday;
}

//上个月
- (NSDate *)getLastMonth:(NSDate *)date{
    NSCalendar *greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [greCalendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSDateComponents *comps = [greCalendar
                               components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                               fromDate:date];
    comps.month -= 1;
    return [greCalendar dateFromComponents:comps];
}
//下个月
- (NSDate *)getNextMonth:(NSDate *)date{
    NSCalendar *greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [greCalendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSDateComponents *comps = [greCalendar
                               components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                               fromDate:date];
    comps.month += 1;
    return [greCalendar dateFromComponents:comps];
}



//目标日期
- (NSDate *)getCurrentMonth:(NSDate *)date andYear:(NSInteger)year andMonth:(NSInteger)month andDay:(NSInteger)day{
    NSCalendar *greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [greCalendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSDateComponents *comps = [greCalendar
                               components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                               fromDate:date];
    comps.year = year;
    comps.month = month;
    comps.day = day;
    return [greCalendar dateFromComponents:comps];
}

//当前月
- (NSDate *)getCurrentMonth:(NSDate *)date{
    NSCalendar *greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [greCalendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSDateComponents *comps = [greCalendar
                               components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                               fromDate:date];
    return [greCalendar dateFromComponents:comps];
}

//日期的当天
- (NSDate *)dateOfDay:(NSInteger)day{
    NSCalendar *greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [greCalendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSDateComponents *comps = [greCalendar
                               components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                               fromDate:self.chooseDate];
    comps.day = day;
    return [greCalendar dateFromComponents:comps];
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}


@end


@implementation CalendarHeaderView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        NSArray *weekArray = [[NSArray alloc] initWithObjects:@"日",@"一",@"二",@"三",@"四",@"五",@"六", nil];
        
        for (int i=0; i<weekArray.count; i++) {
            UILabel *weekLabel = [[UILabel alloc] initWithFrame:CGRectMake(i*Iphone6Scale(54), 0, Iphone6Scale(54), HeaderViewHeight)];
            weekLabel.textAlignment = NSTextAlignmentCenter;
            weekLabel.textColor = [UIColor grayColor];
            weekLabel.font = [UIFont systemFontOfSize:13.f];
            weekLabel.text = weekArray[i];
            [self addSubview:weekLabel];
        }
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, HeaderViewHeight, self.frame.size.width, 1)];
        lineView.backgroundColor = kRGBColor(0, 134, 237);
        
        [self addSubview:lineView];
        
    }
    return self;
}
@end


@interface CalendarCell()
//三角形的背景颜色
@property (nonatomic,strong)UIColor *currentEdgColor;
//三角形上面的文字
@property (nonatomic,strong)NSString *text;
@end

@implementation CalendarCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        CGFloat width = self.contentView.frame.size.width*0.6;
        CGFloat height = self.contentView.frame.size.height*0.6;
        UILabel *dayLabel = [[UILabel alloc] initWithFrame:CGRectMake( self.contentView.frame.size.width*0.5-width*0.5,  self.contentView.frame.size.height*0.5-height*0.5, width, height )];
        dayLabel.textAlignment = NSTextAlignmentCenter;
        dayLabel.font = [UIFont boldSystemFontOfSize:13];
        dayLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:dayLabel];
        self.dayLabel = dayLabel;
        
        
    }
    return self;
}

- (void)setMonthModel:(MonthModel *)monthModel{
    _monthModel = monthModel;
        self.dayLabel.text = [NSString stringWithFormat:@"%02ld",monthModel.dayValue];
    
    if (monthModel.isSelectedDay) {
        self.dayLabel.text = @"今天";
    }
    
    if (monthModel.isCanClick) {
        self.dayLabel.textColor = [UIColor blackColor];
        self.userInteractionEnabled = YES;
       
        
    } else {
        self.dayLabel.textColor = [UIColor lightGrayColor];
        self.userInteractionEnabled = NO;
    }
}

- (void)setModelArray:(NSArray *)modelArray {
    _modelArray = modelArray;
    MySchedulingModel *model = nil;
    BOOL isHave = false;
    for (MySchedulingModel *currentModel in modelArray) {
        if ([[currentModel.workDate yyyyMMddByLineWithDate] isEqualToString:[_monthModel.dateValue yyyyMMddByLineWithDate]]){
            isHave = YES;
            model = currentModel;
            break;
        }
        else {
            isHave = NO;
        }
    }
    if (!isHave) {
        return;
    }
    NSString *str = [model.workshiftName stringByReplacingOccurrencesOfString:@"班" withString:@""];
    if (_monthModel.dayValue>0) {
        if ([model.workshiftType isEqualToString:@"1"]) {
            self.currentEdgColor = [UIColor redColor];
        }
        else if ([model.workshiftType isEqualToString:@"2"]){
            self.currentEdgColor = [UIColor redColor];
        }
        
        else if ([model.workshiftType isEqualToString:@"3"]){
            self.currentEdgColor = [UIColor redColor];
        }
        
        else if ([model.workshiftType isEqualToString:@"4"]){
            self.currentEdgColor = [UIColor redColor];
        }
        
        else {
            self.currentEdgColor = [UIColor clearColor];
        }
    }
    else {
        str = @"";
        self.currentEdgColor = [UIColor clearColor];
    }
    self.text = str;
    [self setNeedsDisplay];

    
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGPoint sPoints[3];
    sPoints[0] = CGPointMake(self.contentView.width-30, 0);
    sPoints[1] = CGPointMake(self.contentView.width, 0);
    sPoints[2] = CGPointMake(self.contentView.width, 30);
    CGContextSetFillColorWithColor(context, (self.currentEdgColor?self.currentEdgColor:[UIColor clearColor]).CGColor);     CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);//设置线的颜色
    CGContextAddLines(context, sPoints, 3);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    [self.text.length>0?self.text:@"" drawInRect:CGRectMake(self.contentView.width-15, 0, 15, 15) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}
@end


@implementation MonthModel


@end




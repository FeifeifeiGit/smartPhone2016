//
//  ProgressViewController.m
//  smartPhoneFinal
//
//  Created by fei Li on 12/14/16.
//  Copyright © 2016 fei Li. All rights reserved.
//

#import "ProgressViewController.h"
#import <CoreData/CoreData.h>
#import "PNChart.h"
#import <Foundation/Foundation.h>
#import <CoreGraphics/CGBase.h>
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>
#import "Completion+CoreDataProperties.h"

@interface ProgressViewController ()
@property NSMutableArray* xlableArray;
@property NSMutableArray* dataArray;
-(void)creteRecordForTest:(NSDate*) date number:(NSInteger) num;
-(void)clearCompletionRecord;
-(void)populateData:(NSInteger*) size;// how many data to draw
@end

@implementation ProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // [self drawLineChart];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
     [self populateData: 10];
     [self drawLineChart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)drawLineChart{
          NSLog(@"drawLineChart is called");
    //For Line Chart
    PNLineChart * lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 135.0, SCREEN_WIDTH, 200.0)];
    [lineChart setXLabels:_xlableArray];

    [lineChart setYLabels:@[
                                 @"0",
                                 @"10 ",
                                 @"25 ",
                                 @"50 ",
                                 @"100 ",
                                 @"150 ",
                                 @"200 ",
                                 ]
     ];
    // Line Chart No.1
    //NSArray * data01Array = @[@60.1, @160.1, @126.4, @262.2, @186.2];
    NSArray * data01Array = _dataArray;
    PNLineChartData *data01 = [PNLineChartData new];
    data01.color = PNFreshGreen;
    data01.itemCount = lineChart.xLabels.count;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    // Line Chart No.2
    NSArray * data02Array = @[@20.1, @180.1, @26.4, @202.2, @126.2];
    PNLineChartData *data02 = [PNLineChartData new];
    data02.color = PNTwitterColor;
    data02.itemCount = lineChart.xLabels.count;
    data02.getData = ^(NSUInteger index) {
        CGFloat yValue = [data02Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
  //  lineChart.chartData = @[data01, data02];
    lineChart.chartData = @[data01];
    [lineChart strokeChart];
   // lineChart.delegate =self;
    [self.view addSubview:lineChart];
}
-(void)populateData:(NSInteger*) size{
    NSLog(@"populate data is called");
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Completion"];
    request.fetchLimit =size;
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date"                                                                   ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    NSError *error;
    NSArray *completRecords = [_myContext executeFetchRequest:request error:&error];
    NSLog(@"populated data size :%lu", (unsigned long)[completRecords count]);
    _xlableArray = [[NSMutableArray alloc]init];
    _dataArray = [[NSMutableArray alloc] init];
    for(Completion *c in completRecords){
    /*    NSString *dateString = [NSDateFormatter localizedStringFromDate:c.date
                                                              dateStyle:NSDateFormatterShortStyle
                                                              timeStyle:NSDateFormatterFullStyle];
     */
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM/DDD/YY"];
        NSString *dateString = [formatter stringFromDate:c.date];
        NSLog(@"%@",dateString);
        [_xlableArray addObject: dateString];
        NSLog(@"_xlableArray size is :%lu",(unsigned long)[_xlableArray count]);
        [_dataArray addObject:[NSNumber numberWithInt:c.number]];
        NSLog(@"_dataArray size is :%lu",(unsigned long)[_dataArray count]);
    }
}

-(void)clearCompletionRecord{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Completion"];

    NSArray *emps = [_myContext executeFetchRequest:request error:nil];

    for (Completion *e in emps) {
        [_myContext deleteObject:e];
    }
    
    // 3.保存
    NSError *error = nil;
    [_myContext save:&error];
    
    if (error) {
        NSLog(@"%@",error);
    }
    NSLog(@"in progess VC, record cleared");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)clearRecord:(id)sender {
    [self clearCompletionRecord];
}
-(void)creteRecordForTest:(NSDate*) date number:(NSInteger) num{
    Completion  *newItem = [NSEntityDescription insertNewObjectForEntityForName:@"Completion" inManagedObjectContext:_myContext];
    newItem.date =date ;
    newItem.number = num;
     NSError *error = nil;
    if([_myContext hasChanges]){
        [_myContext save:&error];
    }
    if (error) {
        NSLog(@"%@",error);
    }
    
    NSLog(@"%hd is added to completed, its date is : %@",newItem.number,newItem.date);

}

- (IBAction)createRecord:(id)sender {
  
     NSDate *date1 = [NSDate dateWithTimeIntervalSinceNow: 604800];//7 days ago
     NSDate *date2 = [NSDate dateWithTimeIntervalSinceNow: 518400];
     NSDate *date3 = [NSDate dateWithTimeIntervalSinceNow: 259200];
     NSDate *date4 = [NSDate dateWithTimeIntervalSinceNow: 1036800];
     NSDate *date5 = [NSDate dateWithTimeIntervalSinceNow: 864000];
     NSDate *date6 = [NSDate dateWithTimeIntervalSinceNow: 86400];
     NSDate *date7 = [NSDate dateWithTimeIntervalSinceNow: 777600];
     NSDate *date8 = [NSDate dateWithTimeIntervalSinceNow: 1555200];
     NSDate *date9 = [NSDate dateWithTimeIntervalSinceNow: 1296000];
     NSDate *date10 = [NSDate dateWithTimeIntervalSinceNow: 483904];
     [self creteRecordForTest: date1 number:20];
     [self creteRecordForTest: date2 number:50];
     [self creteRecordForTest: date3 number:100];
     [self creteRecordForTest: date4 number:700];
     [self creteRecordForTest: date5 number:10];
     [self creteRecordForTest: date6 number:130];
     [self creteRecordForTest: date7 number:120];
     [self creteRecordForTest: date8 number:40];
     [self creteRecordForTest: date9 number:20];
     [self creteRecordForTest: date10 number:90];
     NSLog(@"completion test data saved in progressVC");
}
@end

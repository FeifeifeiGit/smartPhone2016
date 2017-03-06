//
//  SecondViewController.m
//  smartPhoneFinal
//
//  Created by fei Li on 12/14/16.
//  Copyright © 2016 fei Li. All rights reserved.
//

#import "ArticleViewController.h"
#import <CoreData/CoreData.h>
//#import "ArticleStore+CoreDataClass.h"
//#import "ArticleStore+CoreDataProperties.h"
#import "OnePassageViewController.h"

@class ArticleStore;

@interface ArticleViewController ()
@property NSArray  *category ;
@property NSMutableArray *articles;

-(void)buildConnection;
-(void)addArticlesToStore: (NSString*)name withSumarry: (NSString*) summary inCategory: (NSString*) category;
-(void)initializeArticle;
@end

@implementation ArticleViewController

- (void)viewDidLoad {
    NSLog(@"ArticleViewController viewDidLoad is called");
    [super viewDidLoad];
    self.tableView.bounces = YES;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    _category = [NSArray arrayWithObjects:@"Society", @"Entertainment", @"Culture", @"News",@"Story", nil];
    //build the connection to core data
    [self buildConnection];
    //initialize files to article: name, catagory
   //[self initializeArticle];
//   [self addArticlesToStore:@"News article_005" withSumary:@"Age-related macular degeneration (AMD) is a painless eye condition that causes you to lose central vision, usually in both eyes" inCategory:_category[1]];
    //fecth all the articles
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ArticleStore"];
    NSError *error = nil;
    NSArray *results = [_myContext executeFetchRequest:request error:&error];
   // _articles = [[NSMutableArray alloc]init];
    _articles =[NSMutableArray arrayWithArray:results] ;
    NSLog(@"fetched article %lu ",  (unsigned long)[_articles count] );

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
     return [_articles count];
    //return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OnePassageViewController *passageView = [[OnePassageViewController alloc]init];
    passageView.selctedPassage = [_articles objectAtIndex:indexPath.row];
    passageView.myContext = _myContext;
    
    [self.navigationController pushViewController:passageView animated:YES];
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"passageCell" forIndexPath:indexPath];
 
     ArticleStore *art = _articles[indexPath.item];
     cell.textLabel.text = art.articleName;
     cell.detailTextLabel.text=art.summary;
 
   return cell;
 }
 



//build connection method
-(void)buildConnection{
    
    _myContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    // create the managedObjectModel, using the compiled model file as resourse
    NSURL *modelPath = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    _model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelPath];
    // create the persistent store coodinator
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];
    // create a database to store all the data
    NSString *dataPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    dataPath = [dataPath stringByAppendingFormat:@"/%@.sqlite", @"Model"];
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:dataPath] options:nil error:nil];
    // set the context's cooridator, complet the connect between data model and sqlite database
    _myContext.persistentStoreCoordinator = coordinator;
    NSLog(@"here is Article scene ：myContext is %@", _myContext);   
}


-(void)addArticlesToStore: (NSString*)name withSumary: (NSString*) summary inCategory: (NSString*) category{
   ArticleStore  *newArticle = [NSEntityDescription insertNewObjectForEntityForName:@"ArticleStore" inManagedObjectContext:_myContext];
    newArticle.articleName = name;
    newArticle.summary= summary;
    newArticle.category = category;
    // save context
    NSError *error = nil;
    if (_myContext.hasChanges) {
        [self.myContext save:&error];
    }
    // error handling
    if (error) {
        NSLog(@"CoreData Insert ArticleStore Error : %@", error);
    }
    
    NSLog(@"article %@  added", name);
}
-(void)initializeArticle{
    [self addArticlesToStore:@"News article_001" withSumary:@"As cynics derided the popularity of Pokemon Go a few months ago, some tried to seek out the positives." inCategory:_category[2]];
    [self addArticlesToStore:@"News article_002" withSumary:@"Babies made from two women and one man have been approved by the UK's fertility regulator." inCategory:_category[4]];
    [self addArticlesToStore:@"News article_003" withSumary:@"Between “once upon a time” and “happily ever after” lies a timeless, ever-changing world, where everything is possible and dreams do come true. ." inCategory:_category[0]];
    [self addArticlesToStore:@"News article_004" withSumary:@"The team at Newcastle-upon-Tyne Hospitals NHS Foundation Trust and Newcastle University is expected to be the first to be granted a licence." inCategory:_category[3]];
    [self addArticlesToStore:@"News article_005" withSumary:@"Age-related macular degeneration (AMD) is a painless eye condition that causes you to lose central vision, usually in both eyes" inCategory:_category[1]];
    [self addArticlesToStore:@"News article_006" withSumary:@"Call it fried chicken with a side of sentimentality and a pinch of potential frostbite." inCategory:_category[2]];
    [self addArticlesToStore:@"News article_007" withSumary:@"After becoming a global star for playing Rey in Star Wars:" inCategory:_category[0]];
    [self addArticlesToStore:@"News article_008" withSumary:@"Gold nanotechnology could help reduce the number of injections needed to treat a common form of blindness, researchers believe." inCategory:_category[3]];
    [self addArticlesToStore:@"News article_009" withSumary:@"One of the major turning points in social and economic understanding emerged in the 1700s with the theory of social order without human design. " inCategory:_category[3]];
    [self addArticlesToStore:@"News article_011" withSumary:@"One of the major turning points in social and economic understanding emerged in the 1700s with the theory of social order without human design. " inCategory:_category[2]];
    [self addArticlesToStore:@"News article_010" withSumary:@"It's been held up as a particularly gloomy year for celebrity deaths. But has the grim reaper really claimed the souls of more notable people than usual in 2016?" inCategory:_category[1]];
    [self addArticlesToStore:@"News article_012" withSumary:@"Researcher Johan Basuki, from Australia's government-backed CSIRO" inCategory:_category[3]];
    [self addArticlesToStore:@"News article_013" withSumary:@"Simon Frith is stepping down from his role as chair Mercury Prize's judging panel after 25 years." inCategory:_category[4]];
    [self addArticlesToStore:@"News article_014" withSumary:@"The Children’s Society helps change children’s stories, working towards a country where all children are free from disadvantage." inCategory:_category[4]];
    [self addArticlesToStore:@"News article_015" withSumary:@"The last major unknown region on Earth has just been surveyed: the South Pole." inCategory:_category[4]];
    [self addArticlesToStore:@"News article_016" withSumary:@"The Walking Dead star Sonequa Martin-Green has reportedly landed the lead role in the new Star Trek TV series." inCategory:_category[4]];
}

@end

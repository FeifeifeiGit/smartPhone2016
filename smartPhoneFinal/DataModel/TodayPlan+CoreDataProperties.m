//
//  TodayPlan+CoreDataProperties.m
//  smartPhoneFinal
//
//  Created by fei Li on 12/16/16.
//  Copyright © 2016 fei Li. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "TodayPlan+CoreDataProperties.h"

@implementation TodayPlan (CoreDataProperties)

+ (NSFetchRequest<TodayPlan *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"TodayPlan"];
}

@dynamic todaywords;

@end

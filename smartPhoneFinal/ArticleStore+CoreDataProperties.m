//
//  ArticleStore+CoreDataProperties.m
//  smartPhoneFinal
//
//  Created by fei Li on 12/15/16.
//  Copyright © 2016 fei Li. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "ArticleStore+CoreDataProperties.h"

@implementation ArticleStore (CoreDataProperties)

+ (NSFetchRequest<ArticleStore *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ArticleStore"];
}

@dynamic articleName;
@dynamic category;
@dynamic summary;

@end

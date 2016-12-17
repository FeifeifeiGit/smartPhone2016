//
//  Inventory+CoreDataProperties.m
//  smartPhoneFinal
//
//  Created by fei Li on 12/16/16.
//  Copyright © 2016 fei Li. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Inventory+CoreDataProperties.h"

@implementation Inventory (CoreDataProperties)

+ (NSFetchRequest<Inventory *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Inventory"];
}

@dynamic done;
@dynamic fisrtDate;
@dynamic lastDate;
@dynamic stage;
@dynamic word;
@dynamic notesList;
@dynamic relatedArticle;

@end

//
//  SortedDictionary.h
//  Game
//
//  Created by December on 16/1/12.
//  Copyright © 2016年 anzogame. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SortedDictionary : NSObject
@property(nonatomic,readonly)NSUInteger count;
@property(nonatomic,strong)NSArray<NSString *> *sortedKeys;
-(id)objectForKey:(NSString *)key;
-(void)setObject:(id)object forKey:(NSString *)aKey;
-(id)objectAtIndex:(NSUInteger)index;
-(NSString *)keyAtIndex:(NSUInteger)index;
-(NSUInteger)indexForkey:(NSString *)key;
-(void)removeObjectForKey:(NSString *)key;
-(void)removeObjectAtIndex:(NSUInteger)index;
@end

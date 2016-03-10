//
//  SortedDictionary.m
//  Game
//
//  Created by December on 16/1/12.
//  Copyright © 2016年 anzogame. All rights reserved.
//

#import "SortedDictionary.h"

@interface SortedDictionary ()
@property(nonatomic,strong)NSMutableDictionary *privateDic;
@property(nonatomic,strong)NSMutableArray *realKeys;
@property(nonatomic,strong)NSMutableDictionary *realSortDic;
@end

@implementation SortedDictionary

#pragma mark - public

-(NSString *)description
{
    NSString *result = [NSString stringWithFormat:@"address = %@ ,keys = %@ data = %@",[super description],self.realKeys,self.privateDic];
    return result;
}
-(id)objectForKey:(NSString *)key
{
    return self.privateDic[key];
}

-(void)setObject:(id)object forKey:(NSString *)aKey
{
    if (object!=nil) {
        if ([object respondsToSelector:@selector(count)] && [object count]==0) {
            [self removeObjectForKey:aKey];
        }else{
            [self.privateDic setObject:object forKey:aKey];
            NSNumber *add = self.realSortDic[aKey];
            if (self.realKeys.count==0) {
                [self.realKeys addObject:aKey];
            }else{
                for (int i=0; i<self.realKeys.count; i++) {
                    NSNumber *old = self.realSortDic[self.realKeys[i]];
                    if (add==nil) {
                        [self.realKeys addObject:aKey];
                    }else if ([add integerValue]<[old integerValue]) {
                        [self.realKeys insertObject:aKey atIndex:i];
                        break;
                    }else if([add integerValue]==[old integerValue]){
                        [self.realKeys removeObjectAtIndex:i];
                        [self.realKeys insertObject:aKey atIndex:i];
                        break;
                    }else if (i==self.realKeys.count-1){
                        [self.realKeys addObject:aKey];
                    }
                }
            }
        }
    }
}

-(id)objectAtIndex:(NSUInteger)index
{
    if (index<self.realKeys.count) {
        NSString *key = self.realKeys[index];
        return self.privateDic[key];
    }
    return nil;
}
-(NSString *)keyAtIndex:(NSUInteger)index
{
    if (index<self.realKeys.count) {
        return self.realKeys[index];
    }
    return nil;
}

-(NSUInteger)indexForkey:(NSString *)key
{
    return [self.realKeys indexOfObject:key];
}

-(void)removeObjectForKey:(NSString *)key
{
    [self.privateDic removeObjectForKey:key];
    [self.realKeys removeObject:key];
}
-(void)removeObjectAtIndex:(NSUInteger)index
{
    if (index<self.realKeys.count) {
        NSString *key = self.realKeys[index];
        [self removeObjectForKey:key];
    }
}
#pragma mark - setter && getter
-(NSMutableDictionary *)privateDic
{
    if (_privateDic==nil) {
        _privateDic = [NSMutableDictionary dictionary];
    }
    return _privateDic;
}
-(NSMutableArray *)realKeys
{
    if (_realKeys==nil) {
        _realKeys = [NSMutableArray array];
    }
    return _realKeys;
}
-(NSMutableDictionary *)realSortDic
{
    if (_realSortDic==nil) {
        _realSortDic = [NSMutableDictionary dictionary];
    }
    return _realSortDic;
}
-(NSUInteger)count
{
    return self.realKeys.count;
}
-(void)setSortedKeys:(NSArray<NSString *> *)sortedKeys
{
    if ([NSArray isNilOrNotSafe:sortedKeys]) {
        [self.realSortDic removeAllObjects];
    }else{
        for (int i=0;i<sortedKeys.count;i++) {
            NSString *item = sortedKeys[i];
            [self.realSortDic setObject:@(i) forKey:item];
        }
    }
}
@end

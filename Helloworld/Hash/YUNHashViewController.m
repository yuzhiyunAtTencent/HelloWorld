//
//  YUNHashViewController.m
//  Helloworld
//
//  Created by zhiyunyu on 2019/6/27.
//  Copyright © 2019 zhiyunyu. All rights reserved.
//

#import "YUNHashViewController.h"

@interface Person : NSObject <NSCopying>

@end

@implementation Person

-(NSUInteger)hash {
    NSUInteger hash = [super hash];
    NSLog(@">>>>>>>hash>>>>>>>> %@", @(hash));
    return hash;
}

-(id)copyWithZone:(NSZone *)zone {
    // 是否这样写，还得再考量一下
    Person *p = [[Person allocWithZone:zone] init];
    return p;
}

@end

@interface YUNHashViewController ()

@end

@implementation YUNHashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    Person *person1 = [Person new];
    Person *person2 = [Person new];
    
    NSMutableArray *array1 = [NSMutableArray array];
    [array1 addObject:person1];
    NSMutableArray *array2 = [NSMutableArray array];
    [array2 addObject:person2];
    NSLog(@"array end -------------------------------");
    
    NSMutableSet *set1 = [NSMutableSet set];
    [set1 addObject:person1];
    NSMutableSet *set2 = [NSMutableSet set];
    [set2 addObject:person2];
    NSLog(@"set end -------------------------------");
    
    NSMutableDictionary *dictionaryValue1 = [NSMutableDictionary dictionary];
    [dictionaryValue1 setObject:person1 forKey:@"kKey1"];
    NSMutableDictionary *dictionaryValue2 = [NSMutableDictionary dictionary];
    [dictionaryValue2 setObject:person2 forKey:@"kKey2"];
    NSLog(@"dictionary value end -------------------------------");
    
    NSMutableDictionary *dictionaryKey1 = [NSMutableDictionary dictionary];
    [dictionaryKey1 setObject:@"kValue1" forKey:person1];
    NSMutableDictionary *dictionaryKey2 = [NSMutableDictionary dictionary];
    [dictionaryKey2 setObject:@"kValue2" forKey:person2];
    NSLog(@"dictionary key end -------------------------------");
    
    NSHashTable *hashTable = [[NSHashTable alloc] init];
    [hashTable addObject:@"jjj"];
    NSMapTable *mapTable = [[NSMapTable alloc] init];
    [mapTable setObject:@"s" forKey:@"s"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

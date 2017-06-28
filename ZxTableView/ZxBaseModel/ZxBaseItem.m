//
//  ZxBaseItem.m
//  ZxTableView
//
//  Created by ShawnXing on 2017/6/27.
//  Copyright © 2017年 ShawnXing. All rights reserved.
//

#import "ZxBaseItem.h"
#import <objc/runtime.h>
#import "NSDictionary+ZxExtension.h"

@interface ZxBaseItem()

@property (strong, nonatomic) NSMutableDictionary *jsonDataMap;
@property (strong, nonatomic) NSMutableDictionary *jsonArrayClassMap;

@end

@implementation ZxBaseItem

-(id)init{
    if (self = [super init]) {
        _jsonDataMap = [[NSMutableDictionary alloc]init];
        _jsonArrayClassMap = [[NSMutableDictionary alloc]init];
    }
    return self;
}

- (id)initWithData:(NSDictionary *)data{
    if (self = [self init]) {
        [self setData:data];
    }
    return self;
}

- (id)setData:(id)data{
    if (nil == data) {
        return self;
    }
    
    [self parseData:data];
    
    return self;
    
}

- (void)parseData:(NSDictionary *)data {
    
    Class cls = [self class];
    while (cls != [ZxBaseItem class]) {
        NSDictionary *propertyList = [[ZxClassHelper sharedInstance] propertyList:cls];
        for (NSString *key in [propertyList allKeys]) {
            NSString *typeString = [propertyList objectForKey:key];
            NSString *path = [self.jsonDataMap objectForKey:key];
            
            id value = [data objectAtPath:path];
            
            [self setfieldName:key fieldClassName:typeString value:value];
        }
        cls = class_getSuperclass(cls);
    }
    
}

- (void)setfieldName:(NSString*)name fieldClassName:(NSString*)className value:(id)value {
    if (value == nil) {
        return;
    }
    
    //如果结构里嵌套了TBCBaseListItem 也解析
    if ([NSClassFromString(className) isSubclassOfClass:[ZxBaseItem class]]) {
        Class entityClass = NSClassFromString(className);
        if ([value isKindOfClass:[NSString class]]) {
            NSString *str = (NSString *)value;
            if (str && str.length == 0) {
                return;
            }
        }
        
        if ([value isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *)value;
            if (array && [array count] == 0) {
                return;
            }
        }
        
        if (entityClass) {
            ZxBaseItem *entityInstance = [[entityClass alloc] init];
            [entityInstance parseData:value];
            [self setValue:entityInstance forKey:name];
        }
    }
    else if (![value isKindOfClass:NSClassFromString(className)]){
        if ([value isKindOfClass:[NSString class]] && NSClassFromString(className) == [NSNumber class]) {
            [self setValue:[NSNumber numberWithInteger:[(NSString *)value integerValue]] forKey:name];
        }else if([value isKindOfClass:[NSNumber class]] && NSClassFromString(className) == [NSString class]){
            [self setValue:[(NSNumber *)value stringValue] forKey:name];
        }
    }
    else if ([NSClassFromString(className) isSubclassOfClass:[NSArray class]]){
        //如果是array判断array内类型
        NSString *typeName = [_jsonArrayClassMap objectForKey:name];
        if (typeName) {
            //json中不是array 类型错误
            if (![value isKindOfClass:[NSArray class]]) {
                return;
            }
            //entiyClass不存在
            Class entityClass = NSClassFromString(typeName);
            if (!entityClass) {
                return;
            }
            //entityClass不是TBCJsonEntityBase的子类
            if(![entityClass isSubclassOfClass:[ZxBaseItem class]]){
                return;
            }
            NSMutableArray *mutableArr = [[NSMutableArray alloc]initWithCapacity:[(NSArray *)value count]];
            for (NSDictionary *dict in (NSArray *)value) {
                //array中存在的不是dict
                if(![dict isKindOfClass:[NSDictionary class]]){
                    return;
                }
                ZxBaseItem *entityInstance = [[entityClass alloc] init];
                [entityInstance parseData:dict];
                if (entityInstance) {
                    [mutableArr addObject:entityInstance];
                }
            }
            [self setValue:mutableArr forKey:name];
        }
        else{
            [self setValue:value forKey:name];
        }
    }
    else{//正常情况
        [self setValue:value forKey:name];
    }
}
#pragma -mark 映射规则
- (void)addMappingRuleProperty:(NSString*)propertyName pathInJson:(NSString*)path {
    [_jsonDataMap setObject:path forKey:propertyName];
}

- (NSString *)getPahtForDataMapWithKey:(NSString *)aKey {
    if (aKey == nil) {
        return nil;
    }
    return [_jsonDataMap objectForKey:aKey];
}

- (NSString *)mappingRuleWithKey:(NSString *)aKey {
    if (aKey == nil) {
        return nil;
    }
    return [_jsonArrayClassMap objectForKey:aKey];
}

- (void)addMappingRuleArrayProperty:(NSString*)propertyName class:(Class)cls {
    [_jsonArrayClassMap setObject:NSStringFromClass(cls) forKey:propertyName];
}

@end

@implementation ZxClassHelper
{
    NSRecursiveLock *_propertyListCacheLock;
}

+(void)load{
    [self sharedInstance];
}

+ (ZxClassHelper *)sharedInstance{
    static dispatch_once_t once;
    static ZxClassHelper *singleton;
    dispatch_once(&once, ^{
        singleton = [[ZxClassHelper alloc]init];
    });
    return singleton;
}

-(instancetype)init{
    if (self = [super init]) {
        self.propertyListCache = [[NSMutableDictionary alloc]init];
        _propertyListCacheLock = [[NSRecursiveLock alloc]init];
    }
    return self;
}

- (NSDictionary *)propertyList:(Class)cls{
    if (cls == NULL) {
        return nil;
    }
    
    [_propertyListCacheLock lock];
    
    NSString *clsName = NSStringFromClass(cls);
    
    NSDictionary *cachePropertyList = [self.propertyListCache objectForKey:clsName];
    
    if (cachePropertyList) {
        [_propertyListCacheLock unlock];
        return cachePropertyList;
    }
    
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    unsigned int propertyCount = 0;
    objc_property_t *propertyList = class_copyPropertyList(cls, &propertyCount);//获取cls类成员变量列表
    for(unsigned int i = 0; i<propertyCount; i++){
        objc_property_t property = propertyList[i];
        const char *attr = property_getAttributes(property);//取到这个变量的类型
        NSString *attrString = [NSString stringWithUTF8String:attr];
        NSString *typeAttr= [[attrString componentsSeparatedByString:@","] objectAtIndex:0];
        if (typeAttr.length<8) continue;
        NSString *typeString = [typeAttr substringWithRange:NSMakeRange(3, typeAttr.length-4)];
        NSString *key = [NSString stringWithUTF8String:property_getName(property)];//取得这个变量的名称
        [dict setObject:typeString forKey:key];
    }
    free(propertyList);
    [self.propertyListCache setObject:dict forKey:clsName];
    [_propertyListCacheLock unlock];
    
    return dict;
}


@end

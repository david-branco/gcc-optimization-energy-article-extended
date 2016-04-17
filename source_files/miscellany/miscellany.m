// Working with Numbers

#import <Foundation/Foundation.h>
#include <time.h>
#include <stdlib.h>

#define N 20000

@interface XYPoint : NSObject
{
  int x;
  int y;
}

-(void) setX: (int)a;
-(void) setY: (int)b;
-(int) x;
-(int) y;
@end

@implementation XYPoint
-(void) setX: (int) a
{
  x = a;
}

-(void) setY: (int) b
{
  y = b;
}

-(int) x
{
  return x;
}

-(int) y
{
  return y;
}

@end

@interface Fraction : NSObject
{
  int numerator;
  int denominator;
}

-(void) print;
-(void) setNumerator: (int) n;
-(void) setDenominator: (int) d;

@end

// ------- @implementation section -------

@implementation Fraction
-(void) print
{
  NSLog(@"%i/%i", numerator, denominator);
}

-(void) setNumerator: (int) n
{
  numerator = n;
}

-(void) setDenominator: (int) d;
{
  denominator = d;
}

@end


@interface BankAccount: NSObject
{
        double accountBalance;
        long accountNumber;
}
@end

@implementation BankAccount

-(void) setAccount: (long) y andBalance: (double) x;
{
        accountBalance = x;
        accountNumber = y;
}

-(void) setAccountBalance: (double) x
{
        accountBalance = x;
}

-(double) getAccountBalance
{
        return accountBalance;
}

-(void) setAccountNumber: (long) y
{
        accountNumber = y;
}

-(long) getAccountNumber
{
        return accountNumber;
}


-(void) displayAccountInfo
{
        NSLog (@"Account Number %ld has a balance of %f", accountNumber, accountBalance);
}
@end


@interface Sorting:NSObject
/* function declaration */
- (void) final_print;
- (void) print_array:(int*) array;
- (void) initalize_array:(int[]) array;
- (void) bubble_sort:(int*) array;
- (void) selection_sort:(int*) array;
- (void) insertion_sort:(int*) array;
- (void) heap_sort:(int*) array;
@end


@implementation Sorting

- (void) final_print
{
    NSLog(@"END\n");
}


- (void) print_array:(int[]) array
{
    int i;
    for ( i = 0; i < N; ++i)
    {
     NSLog( @"r[%d] = %d\n", i, array[i]);
    }

}

- (void) initalize_array:(int[]) array
{
    int i;

    srand( (unsigned)time( NULL ) );
    for ( i = 0; i < N; ++i)
    {
     array[i] = rand();
    }
    
}


- (void) bubble_sort:(int*) array
{
    int x, y, temp;

    for(x=0; x<N; x++)
    {
        for(y=0; y<N-1; y++)
        {
            if(array[y]>array[y+1])
            {
                temp = array[y+1];
                array[y+1] = array[y];
                array[y] = temp;
            }
        }
    }    
}

- (void) selection_sort:(int*) array
{
    int x, y, temp, index_of_min;

    for(x=0; x<N; x++)
    {
        index_of_min = x;
        for(y=x; y<N; y++)
        {
            if(array[index_of_min]>array[y])
            {
                index_of_min = y;
            }
        }

        temp = array[x];
        array[x] = array[index_of_min];
        array[index_of_min] = temp;
    }   
}

- (void) insertion_sort:(int*) array
{
    int x, y, value;

    for(x = 1 ; x < N ; x++)
    {
        value = array[x];
        for (y = x - 1; y >= 0 && array[y] > value; y--) 
        {
            array[y + 1] = array[y];
        }
        array[y + 1] = value;
    }
}


- (void) heap_sort:(int*) array
{
    if(N==0) 
      return;

    int t; 
    int n = N, parent = N/2, index, child; 

    while (1) 
    { 
        if (parent > 0) 
        {        
            t = array[--parent]; 
        } else {
           
            n--;              
            if (n == 0) {
                return; 
            }
            t = array[n];       
            array[n] = array[0];   
        }
        index = parent; 
        child = index * 2 + 1; 
        while (child < n) 
        {

            if (child + 1 < n  &&  array[child + 1] > array[child]) 
            {
                child++;
            }
            if (array[child] > t) 
            {
                array[index] = array[child]; 
                index = child; 
                child = index * 2 + 1; 
            } else {
                break; 
            }
        }
        array[index] = t; 
    }
}

@end



@interface Thingie : NSObject<NSCoding>
{
    NSString *name;
    int magicNumber;
    float shoeSize;
    NSMutableArray *subThingies;
}

@property (copy) NSString *name;
@property int magicNumber;
@property float shoeSize;
@property (retain) NSMutableArray *subThingies;

-(id)initWithName: (NSString *)name  
            magicNumber: (int)mn
            shoeSize: (float)ss;;
@end



@implementation Thingie

@synthesize name;
@synthesize magicNumber;
@synthesize shoeSize;
@synthesize subThingies;

- (id)initWithName:(NSString *)n magicNumber:(int)mn shoeSize:(float)ss
{
    if ((self = [super init])) 
    {
        self.name = n;
        self.magicNumber = mn;
        self.shoeSize = ss;
        self.subThingies = [NSMutableArray array];
    }
    
    return self;
}

- (void) dealloc
{
    [name release];
    [subThingies release];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    // 实现序列化
    [aCoder encodeObject:name forKey:@"name"];
    [aCoder encodeInt: magicNumber forKey:@"magicNumber"];
    [aCoder encodeFloat:shoeSize forKey:@"shoeSize"];
    [aCoder encodeObject:subThingies forKey:@"subThingies"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    // 实现反序列化
    if((self = [super init]))
    {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.magicNumber = [aDecoder decodeIntForKey:@"magicNumber"];
        self.shoeSize = [aDecoder decodeFloatForKey:@"shoeSize"];
        self.subThingies = [aDecoder decodeObjectForKey:@"subThingies"];
    }
    
    return self;
}

- (NSString *) description
{
    NSString *description = [NSString stringWithFormat:@"%@: %d/%.1f %@", name, magicNumber, shoeSize, subThingies];
    return description;
}

@end

void print_range(NSRange range)
{
    if(range.location != NSNotFound)
        NSLog(@"range is %@", NSStringFromRange(range)); // NSStringFromRange
    else
        NSLog(@"range.location not found.");
}


@interface RetainTracker : NSObject
@end

@implementation RetainTracker

- (id)init
{
    if (self = [super init]) 
    {
        NSLog(@"init: retain count of %lu.", [self retainCount]);
    }
    
    return self;
}

- (void)dealloc
{
    NSLog(@"dealloc called.Bye bye.");
    [super dealloc];
}
@end


typedef enum {
    kCircle,
    kRectangle
} ShapeType;

// 颜色
typedef enum {
    kRedColor,
    kGreenColor
} ShapeColor;

// 形状结构体
typedef struct {
    int x, y, width, height;
} ShapeRect;

typedef struct {
    ShapeType type;
    ShapeColor fillColor;
    ShapeRect bounds;
} Shape;

void drawCircle(ShapeRect rect, ShapeColor color);
void drawRectangle(ShapeRect rect, ShapeColor color);
void drawShapes(Shape shapes[], int count);

void drawCircle(ShapeRect rect, ShapeColor color)
{
    NSLog(@"drawCircle called");
}

void drawRectangle(ShapeRect rect, ShapeColor color)
{
    NSLog(@"drawRectangle called");
}

void drawShapes(Shape shapes[], int count)
{
    int i = 0;
    
    for (i = 0; i < count; i++) 
    {
        switch (shapes[i].type) 
        {
            case kCircle:
                drawCircle(shapes[i].bounds, shapes[i].fillColor);
                break;
            case kRectangle:
                drawRectangle(shapes[i].bounds, shapes[i].fillColor);
                break;
            default:
                break;
        }
    }
}






































int main(int argc, char* argv[])
{
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
  int loop;

  for(loop = 0; loop < 10; loop++) 
  {
    NSNumber          *myNumber, *floatNumber, *intNumber;
    NSInteger         myInt; 

    NSString *str1 = @"This is a string A";
    NSString *res;
    NSRange subRange;
    NSString *search, *replace;
    NSMutableString *mstr;
    NSRange substr;

    int i;
    Fraction *myFraction;
    BankAccount *account1;

    Sorting *sorting = [[Sorting alloc]init];
    int values[N];

    srand( (unsigned)time( NULL ) );


    // integer value
    intNumber = [NSNumber numberWithInteger: 100];
    // NSInteger is a basic data type.
    myInt = [intNumber integerValue];
    NSLog(@"%li", (long)myInt);

    // long value
    myNumber = [NSNumber numberWithLong: 0xabcdef];
    NSLog(@"%lx", [myNumber longValue]);

    // char value
    myNumber = [NSNumber numberWithChar: 'X'];
    NSLog(@"%c", [myNumber charValue]);

    // float value
    floatNumber = [NSNumber numberWithFloat: 100.00];
    NSLog(@"%g", [floatNumber floatValue]);

    // double value
    myNumber = [NSNumber numberWithDouble: 12345e+15];
    NSLog(@"%lg", [myNumber doubleValue]);

    // Wrong access here
    NSLog(@"%lg", [myNumber integerValue]);

    // Test two Numbers for equality
    if ([intNumber isEqualToNumber: floatNumber] == YES)
      NSLog(@"Numbers are equal");
    else
      NSLog(@"Numbers are not equal");

    // Test if one Number is <, ==, or > second Number
    if ([intNumber compare: myNumber] == NSOrderedAscending)
      NSLog(@"First number is less than second");

    // Extract first 3 chars from string
    res = [str1 substringToIndex: 3];
    NSLog(@"First 3 chars of str1: %@", res);

    // Extract chars to end of string starting at index 5
    res = [str1 substringFromIndex: 5];
    NSLog(@"Chars from index 5 of str1: %@", res);

    // Extract chars from index 8 through 13 (6 chars)
    res = [[str1 substringFromIndex: 8] substringToIndex: 6];
    NSLog(@"Chars from index 8 through 13: %@", res);

    // An easier way to to the same thing
    res = [str1 substringWithRange: NSMakeRange(8,6)];
    NSLog(@"Chars from index 8 through 13: %@", res);

    // Locate one string inside another
    subRange = [str1 rangeOfString: @"string A"];
    NSLog(@"String is at index %lu, length is %lu", subRange.location, subRange.length);

    subRange = [str1 rangeOfString: @"string B"];
    if (subRange.location == NSNotFound)
      NSLog(@"String not found");
    else

    str1 = @"This is a string A";
    // Create mutable string from nonmutable
    mstr = [NSMutableString stringWithString: str1];
    NSLog(@"%@", mstr);

    // Insert characters
    [mstr insertString: @" mutable" atIndex: 7];
    NSLog(@"%@", mstr);

    // Effective concatentation if insert at end
    [mstr insertString: @" and string B" atIndex: [mstr length]];
    NSLog(@"%@", mstr);

    // Or can user appendString directly
    [mstr appendString: @" and string c"];
    NSLog(@"%@", mstr);

    // Delete substring based on range
    [mstr deleteCharactersInRange: NSMakeRange(16,13)];
    NSLog(@"%@", mstr);

    // Find range first and then use it for deletion
    substr = [mstr rangeOfString: @"string B and "];
    if (substr.location != NSNotFound) {
      [mstr deleteCharactersInRange: substr];
      NSLog(@"%@", mstr);
    }

    // Set the mutable string directly
    [mstr setString: @"This is string A"];
    NSLog(@"%@", mstr);

    // Now let's replace a range of chars with another
    [mstr replaceCharactersInRange: NSMakeRange(8, 8) withString: @"a mutable string"];
    NSLog(@"%@", mstr);

    // Search and replace
    search = @"This is";
    replace = @"An example of";
    substr = [mstr rangeOfString: search];
    if (substr.location != NSNotFound) {
      [mstr replaceCharactersInRange: substr withString: replace];
      NSLog(@"%@", mstr);
    }

    // Search and replace all occurreces
    search = @"a";
    replace = @"X";
    substr = [mstr rangeOfString: search];
    while (substr.location != NSNotFound) {
      [mstr replaceCharactersInRange: substr withString: replace];
      substr = [mstr rangeOfString: search];
    }
    NSLog(@"%@", mstr);

    // Create an array to contain the month names
    NSArray *monthName = [NSArray arrayWithObjects:
      @"January", @"February", @"March", @"April",
      @"May", @"Jane", @"July", @"August", @"September",
      @"October", @"November", @"December", nil];

    // Now list all the elements in the array
    NSLog(@"Month Name");
    NSLog(@"===== ====");
    for (i=0; i<12; i++)
      NSLog(@" %2i   %@", i+1, [monthName objectAtIndex: i]);

    XYPoint *point;
    point = [XYPoint alloc];
    point = [point init];

    [point setX:4];
    [point setY:5];

    NSLog(@"The point's coordinate is (%d,%d)", [point x], [point y]);

    [point release];
    myFraction = [Fraction alloc];
    myFraction = [myFraction init];

    // Set fraction to 1/3
    [myFraction setNumerator: 1];
    [myFraction setDenominator: 3];

    // Display the fraction using the print method
    NSLog(@"The value of myFraction is:");
    [myFraction print];
    [myFraction release];

    account1 = [BankAccount alloc];
    account1 = [account1 init];


    for(i = 0; i < 10000; i++) {
      [account1 setAccountBalance: rand() % 1000];
      [account1 setAccountNumber: rand() % 1000];
      //[account1 displayAccountInfo];
      [account1 setAccount: rand() % 1000 andBalance: rand() % 1000];
    }
    NSLog(@"Number = %i, Balance = %f", [account1 getAccountNumber], [account1 getAccountBalance]);


    [sorting initalize_array: values];
    //[sorting print_array:values];

    [sorting bubble_sort: values];
    NSLog(@"Bubble Sort Terminated !\n");
    //[sorting print_array:values];

    [sorting initalize_array: values];
    [sorting selection_sort: values];
    //[sorting print_array:values];
    NSLog(@"Selection Sort Terminated !\n");

    [sorting initalize_array: values];
    [sorting insertion_sort: values];
    //[sorting print_array:values];
    NSLog(@"Insertion Sort Terminated !\n");

    [sorting initalize_array: values];
    [sorting heap_sort: values];
    //[sorting print_array:values];
    NSLog(@"Heap Sort Terminated !\n");


    NSFileManager *manager;
    NSString *dropbox, *downloads;
    NSMutableArray *files;
    
    manager = [NSFileManager defaultManager];
    dropbox = [@"~/Dropbox/" stringByExpandingTildeInPath];
    downloads = [@"~/Downloads/" stringByExpandingTildeInPath];
    files = [NSMutableArray arrayWithCapacity:60];
    

    for(i = 0; i < 20; i++) {
      for (NSString *filename in [manager enumeratorAtPath:dropbox]) 
      {
          if([[filename pathExtension] isEqualTo:@"jpg"])
          {
              [files addObject:filename];
          }
      }

      for (NSString *filename in [manager enumeratorAtPath:downloads]) 
      {
          if([[filename pathExtension] isEqualTo:@"jpg"])
          {
              [files addObject:filename];
          }
      }
      
      for(NSString* filename in files)
      {
          NSLog(@"%@", filename);
      }
    }

    NSArray *array = [NSArray arrayWithObjects:@"one", @"two", @"three", nil];

    // 遍历索引
    for(i = 0; i < [array count]; i++)
        NSLog(@"%@", [array objectAtIndex:i]);

    // 迭代
    for(NSString *str in array)
        NSLog(@"%@", str);

    // 切割
    NSString *strs = @"oop:bork:greeble:ponies";
    NSArray *chunks = [strs componentsSeparatedByString:@":"];
    for (NSString* str in chunks) 
        NSLog(@"%@", str);

    // 合成
    NSLog(@"joined: %@", [chunks componentsJoinedByString:@"@"]);

    // 可变数组
    NSMutableArray *marray = [NSMutableArray arrayWithObjects:@"zhangsan", @"lisi", nil];
    [marray addObject:@"wangwu"];
    [marray addObject:@"liuqi"];
    for(NSString *str in marray)
        NSLog(@"%@", str);

    // 枚举器
    NSEnumerator *enumerator;
    id o;

    // 正向枚举
    enumerator = [marray objectEnumerator];
    while ((o = [enumerator nextObject])) {
        NSLog(@"%@", o);
    }
    // 反向枚举
    enumerator = [marray reverseObjectEnumerator];
    while ((o = [enumerator nextObject]))  {
        NSLog(@"%@", o);
    }

    NSArray *phrase;
    phrase = [NSArray arrayWithObjects:@"I", @"seem", @"to", @"be", @"a", @"verb", nil];
    [phrase writeToFile:@"/tmp/phrase.txt" atomically:YES];

    NSArray *phrase2 = [NSArray arrayWithContentsOfFile:@"/tmp/phrase.txt"];
    NSLog(@"%@", phrase2);
    
    Thingie *thing1 = [[Thingie alloc] initWithName:@"thing1" magicNumber:42 shoeSize:10.5];
    NSLog(@"%@", thing1);
    /*
     thing1: 42/10.5 (
     )
     */
    
    NSData *freezeDried;
    freezeDried = [NSKeyedArchiver archivedDataWithRootObject:thing1];
    [thing1 release];
    
    thing1 = [NSKeyedUnarchiver unarchiveObjectWithData:freezeDried];
    NSLog(@"reconstituted thing: %@", thing1);
    /*
     reconstituted thing: thing1: 42/10.5 (
     )
     */
    
    Thingie *anotherThing;
    
    anotherThing = [[[Thingie alloc] initWithName:@"thing2" magicNumber:23 shoeSize:13.0] autorelease];
    [thing1.subThingies addObject:anotherThing];
    
    anotherThing = [[[Thingie alloc] initWithName:@"thing3" magicNumber:17 shoeSize:9.0] autorelease];
    [thing1.subThingies addObject:anotherThing];
    
    NSLog(@"thing with sub things :%@", thing1);

    freezeDried = [NSKeyedArchiver archivedDataWithRootObject:thing1];
    
    // 解码
    thing1 = [NSKeyedUnarchiver unarchiveObjectWithData:freezeDried];
    NSLog(@"reconstituted thing: %@", thing1);


    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"1", @"one", @"2", @"two", nil];
    NSLog(@"two is %@", [dic objectForKey:@"two"]);
    
    for(id key in dic)
        NSLog(@"%@ is %@", key, [dic objectForKey:key]);
    
    NSMutableDictionary *mdic = [NSMutableDictionary dictionaryWithCapacity:20];
    
    // 添加
    [mdic setObject:@"1" forKey:@"one"];
    [mdic setObject:@"2" forKey:@"two"];
    [mdic setObject:@"3" forKey:@"three"];
    
    for(id key in mdic)
        NSLog(@"%@ is %@", key, [mdic objectForKey:key]);
    
    // 删除
    [mdic removeObjectForKey:@"two"];
    
    for(id key in mdic)
        NSLog(@"%@ is %@", key, [mdic objectForKey:key]);        
    
    // 修改
    [mdic setObject:@"叁" forKey:@"three"];
    
    for(id key in mdic)
        NSLog(@"%@ is %@", key, [mdic objectForKey:key]);

    NSNumber *numberInt, *numberFloat;
    NSMutableArray *marray2;
    
    numberInt = [NSNumber numberWithInt:10];
    numberFloat = [NSNumber numberWithFloat:0.8];
    
    [marray2 addObject:numberInt];
    [marray2 addObject:numberFloat];
    
    NSLog(@"numberInt is %d", numberInt.intValue);
    NSLog(@"numberFloat is %f", numberFloat.floatValue);


    // 各种初始化方法
    NSRange range1;
    
    // 分别赋值
    range1.location = 18;
    range1.length = 20;
    print_range(range1);
    
    // 结构初始化方法
    NSRange range2 = {20, 40};
    print_range(range2);
    
    // 调用辅助的build函数
    NSRange range3 = NSMakeRange(30, 60);
    print_range(range3);
    
    // 暂时没有确定的有意义的值，可以设置成NSNotFound
    NSRange range4 = {NSNotFound, NSNotFound};
    print_range(range4);
    
    // 截取部分字符串
    NSString *str = @"that is a dog.";
    NSLog(@"it's a %@", [str substringWithRange:NSMakeRange(10, 3)]);
    
    // 返回部分字符串的位置信息
    NSRange range = [str rangeOfString:@"dog"];
    if(range.length > 0) print_range(range);
    
    // 反响查找
    range = [str rangeOfString:@"a" options:NSBackwardsSearch];
    if(range.length > 0) print_range(range);
    
    // 从字符串构建NSRange结构体
    NSLog(@"it's a %@", [str substringWithRange:NSRangeFromString(@"{10, 3}")]); // NSRangeFromString
    
    // 截取数组的部分元素
    NSArray *words = [NSArray arrayWithObjects:@"one", @"two", @"three", @"four", @"five", nil];
    NSArray *subWords = [words subarrayWithRange:NSMakeRange(2, 2)];

    for (NSString *w in subWords) 
        NSLog(@"%@", w);
    
    // 判断值是否相等
    NSRange rangeOne = NSMakeRange(1, 10);
    NSRange rangeTwo = NSMakeRange(1, 10);
    
    if(NSEqualRanges(rangeOne, rangeTwo))
        NSLog(@"rangeOne is equal to rangeTwo");
    
    // range is {3, 3}
    NSRange intersectionRange = NSIntersectionRange(NSMakeRange(1, 5), NSMakeRange(3, 8));
    print_range(intersectionRange);
    
    if(NSLocationInRange(8, NSMakeRange(5, 20)))
        NSLog(@"8 in {1, 20}");
    
    if(NSMaxRange(NSMakeRange(3, 8)) == (3 + 8))
        NSLog(@"NSMaxRange is sum of location and length");
    
    // range is {1, 14}
    print_range(NSUnionRange(NSMakeRange(1, 10), NSMakeRange(5, 10)));
    
    // range is {1, 20}
    print_range(NSUnionRange(NSMakeRange(1, 10), NSMakeRange(11, 10)));

    NSPoint point2 = {2.5, 3.8};
    NSLog(@"%@", NSStringFromPoint(point2));
    
    
    // NSSize size = NSMakeSize(10, 20);
    NSSize size = {10, 20};
    NSLog(@"%@", NSStringFromSize(size));
    
    // NSRect rect = NSMakeRect(4.5, 8.8, 30, 40);
    NSRect rect = {4.5, 8.8, 30, 40};
    NSLog(@"%@", NSStringFromRect(rect));
    
    rect.origin = point2;
    rect.size = size;
    NSLog(@"%@", NSStringFromRect(rect));

    NSString *str2 = [NSString stringWithFormat: @"this is a %@", @"dog"];
    NSLog(@"%@", str2);
    NSLog(@"str length = %ld", [str2 length]);
    
    // 判断内容是否相等
    NSString *thing11 = @"hello 5";
    NSString *thing22 = [NSString stringWithFormat:@"hello %d", 5];
    if([thing11 isEqualToString:thing22])
        NSLog(@"thing11 equal to thing22");
    
    if(NSOrderedSame == [thing11 compare:thing22])
        NSLog(@"thing11 equal to thing22");
    
    // 比较函数
    if(NSOrderedAscending == [@"99" compare:@"100"
                                    options:NSCaseInsensitiveSearch | NSNumericSearch])
        NSLog(@"99 < 100");
    
    // 前缀
    NSString *filename = @"draft-chapter.pages";
    if([filename hasPrefix:@"draft"])
        NSLog(@"this is a draft");
    
    // 后缀
    if([filename hasSuffix:@".pages"])
        NSLog(@"it's document");
    
    // 查找字符串
    NSRange range8764 = [filename rangeOfString:@"chapter"];
    NSLog(@"chapter is at %@", NSStringFromRange(range8764));
    
    // 可变字符串
    NSMutableString *mstr2 = [NSMutableString stringWithCapacity:60];
    [mstr2 appendString:@"this is "];
    [mstr2 appendFormat:@"a %@", @"dog"];
    NSLog(@"%@", mstr2);
    
    // 删除字符串
    NSMutableString *friends = [NSMutableString stringWithCapacity:60];
    [friends appendString:@"James BethLynn Jack Evan"];
    range8764 = [friends rangeOfString:@"Jack"];
    // 吃掉空格字符
    range8764.length++;
    [friends deleteCharactersInRange:range8764];
    NSLog(@"friends are %@", friends);

    NSMutableArray *marray3 = [NSMutableArray arrayWithCapacity:10];
          
    NSRect rect2 = NSMakeRect(1, 2, 30, 40);
    NSValue *value = [NSValue valueWithRect:rect2];
    
    // 装箱后就可以放入数组
    [marray3 addObject:value];
    
    // get方法从参数取得结果
    NSRect valueRect;
    [value getValue:&valueRect];
    
    NSPoint point123 = NSMakePoint(10.0, 20.0);
    // 便捷方法
    value = [NSValue valueWithPoint:point123];
    // 万能方法
    value = [NSValue valueWithBytes:&point123 objCType:@encode(NSPoint)];
    [marray3 addObject:value];
    // get方法从参数取得结果
    NSPoint valuePoint;
    [value getValue:&valuePoint];
    
    for(id o in marray3)
        NSLog(@"%@", o);


    RetainTracker *tracker = [RetainTracker new];
    // count = 1

    NSLog(@"%@", tracker);

    [tracker retain]; // count = 2
    NSLog(@"%ld", [tracker retainCount]);

    [tracker retain]; // count = 3
    NSLog(@"%ld", [tracker retainCount]);

    [tracker release]; // count = 2
    NSLog(@"%ld", [tracker retainCount]);    

    [tracker release]; // count = 1
    NSLog(@"%ld", [tracker retainCount]);    

    [tracker retain]; // count = 2
    NSLog(@"%ld", [tracker retainCount]);    

    [tracker release]; // count = 1
    NSLog(@"%ld", [tracker retainCount]);    

    [tracker release]; // count = 0, dealloc it       


    Shape shapes[2];
    
    ShapeRect rect0 = {0, 0, 10, 20};
    shapes[0].type = kCircle;
    shapes[0].fillColor = kRedColor;
    shapes[0].bounds = rect0;
    
    ShapeRect rect1 = {0, 0, 10, 20};
    shapes[1].type = kCircle;
    shapes[1].fillColor = kRedColor;
    shapes[1].bounds = rect1;
    
    drawShapes(shapes, 2);

    NSMutableArray *stomach = [[NSMutableArray alloc] init];
    
    NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
    
    for (i = 0; i < 10000000; i++) {
      [stomach addObject:@"string"];
    }
    
    NSTimeInterval duration = [NSDate timeIntervalSinceReferenceDate] - start;
    
    NSLog(@"Duration: %gs", duration);
    [sorting final_print];
  }

  [pool drain];
  return 0;
}


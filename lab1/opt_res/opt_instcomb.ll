; ModuleID = 'opt_res/opt_instcomb.bc'
source_filename = "main.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@N = dso_local constant i32 5, align 4
@m = dso_local constant i32 2, align 4
@.str = private unnamed_addr constant [4 x i8] c"%s\0A\00", align 1
@.str.1 = private unnamed_addr constant [10 x i8] c"DEF TEST!\00", align 1
@.str.2 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @rank(i32 %0, i32 %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 %1, i32* %3, align 4
  store i32 1, i32* %4, align 4
  br label %6

6:                                                ; preds = %13, %2
  %storemerge = phi i32 [ %0, %2 ], [ %15, %13 ]
  store i32 %storemerge, i32* %5, align 4
  %7 = load i32, i32* %3, align 4
  %8 = icmp sgt i32 %storemerge, %7
  br i1 %8, label %16, label %9

9:                                                ; preds = %6
  %10 = load i32, i32* %5, align 4
  %11 = load i32, i32* %4, align 4
  %12 = mul nsw i32 %11, %10
  store i32 %12, i32* %4, align 4
  br label %13

13:                                               ; preds = %9
  %14 = load i32, i32* %5, align 4
  %15 = add nsw i32 %14, 1
  br label %6

16:                                               ; preds = %6
  %17 = load i32, i32* %4, align 4
  ret i32 %17
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %puts = call i32 @puts(i8* nonnull dereferenceable(1) getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i64 0, i64 0))
  %1 = call i32 @rank(i32 4, i32 5)
  %2 = call i32 @rank(i32 1, i32 2)
  %3 = sdiv i32 %1, %2
  %4 = call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([4 x i8], [4 x i8]* @.str.2, i64 0, i64 0), i32 %3) #3
  %5 = call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([4 x i8], [4 x i8]* @.str.2, i64 0, i64 0), i32 9) #3
  ret i32 0
}

declare dso_local i32 @printf(i8*, ...) #1

; Function Attrs: nofree nounwind
declare i32 @puts(i8* nocapture readonly) #2

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nofree nounwind }
attributes #3 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 10.0.0-4ubuntu1 "}

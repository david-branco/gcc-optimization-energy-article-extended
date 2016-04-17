CC = gcc
CFLAGS = -Os
GNUSTEP_OBJCFLAGS = -MMD -MP -D_FORTIFY_SOURCE=2 -DGNUSTEP -DGNUSTEP_BASE_LIBRARY=1 -DGNU_GUI_LIBRARY=1 -DGNU_RUNTIME=1 -DGNUSTEP_BASE_LIBRARY=1 -fno-strict-aliasing -pthread -fPIC -Wall -DGSWARN -DGSDIAGNOSE -Wno-import -march=x86-64 -mtune=generic -pipe -fstack-protector-strong --param=ssp-buffer-size=4 -fgnu-runtime -fconstant-string-class=NSConstantString -I. -I/home/db/GNUstep/Library/Headers -I/usr/include
GNUSTEP_BASELIBS = -rdynamic -Wl,--sort-common,--as-needed,-z,relro -pthread -fgnu-runtime -L/home/db/GNUstep/Library/Libraries -L/usr/lib -lgnustep-base -lobjc -lm

all: miscellany.m
	$(CC) $(CFLAGS) -o miscellany miscellany.m $(GNUSTEP_OBJCFLAGS) $(GNUSTEP_BASELIBS)

SHELL := /bin/sh
MDL_DIR	:= /lib/modules/$(shell uname -r)
DRV_DIR	:= $(MDL_DIR)/kernel/drivers/iio/accel

#Handle the compression option for modules in 3.18+
ifneq ("","$(wildcard $(DRV_DIR)/*.ko.gz)")
COMPRESS_GZIP := y
endif
ifneq ("","$(wildcard $(DRV_DIR)/*.ko.xz)")
COMPRESS_XZ := y
endif

ifneq ($(KERNELRELEASE),)

	obj-m := kxcjk-1013.o

else
	PWD := $(shell pwd)
	KVER := $(shell uname -r)
	KDIR := /lib/modules/$(KVER)/build

all:
	$(MAKE) -C $(KDIR) M=$(PWD) modules

clean:
	rm -rf *.o *.mod.c *.mod.o *.ko *.symvers *.order *.a
endif

install:
	@cp -f *.ko $(DRV_DIR)/.
ifeq ($(COMPRESS_GZIP), y)
	@gzip -f $(DRV_DIR)/kxcjk-1013.ko
endif
ifeq ($(COMPRESS_XZ), y)
	@xz -f $(DRV_DIR)/kxcjk-1013.ko
endif
	depmod -a $(MDL_DIR)
	@echo "installed revised kxcjk-1013"

uninstall:
	rm -f $(DRV_DIR)/kxcjk-1013.ko*
	depmod -a $(MDL_DIR)
	echo "uninstalled revised kxcjk-1013"

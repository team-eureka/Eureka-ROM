Initramfs/Kernel Readme
====

Long story short, this process is done by hand. Writeup is as follows:

1. Build custom kernel using https://github.com/team-eureka/Eureka-Kernel, use the `new-vivante` branch.

	*Hint, add `-b new-vivante` to the repo URL in the script, which is the var named kernel_repo*
2. Take a stock OTA and dump it's initramfs once it's extracted from the kernel.

	```
	mkdir ./builddir
	cp  ./initfsfile ./builddir
	cd ./builddir
	cpio -v -i --absolute-filenames < initfsfile && rm initfsfile
	```

3. Add Console/DHCP scripts to `./init.rc`

	```
	service console /bin/sh /sbin/uart_console.sh
	    class service
	    user root

	service dhcpcd /bin/sh /sbin/set_hostname.sh
	    class service
	    user root
	```

4. Copy over scripts to initramfs root

	```
	cp *repo*/initramfs/set_hostname.sh ./sbin/
	chmod 700 ./sbin/set_hostname.sh
	cp *repo*/initramfs/uart_console.sh ./sbin/
	chmod 700 ./sbin/uart_console.sh
	```

5. Create the new initramfs

	```
	find . | cpio -o -H newc | gzip > ../custom-initramfs
	```

6. Make new Kernel Image

	```
	cc-make-bootimg nand ./final-custom-kernel.img custom-kernel custom-initramfs
	```

7. Enjoy!

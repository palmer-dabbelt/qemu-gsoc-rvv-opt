.SECONDARY:

all: $(patsubst %.c,%.times,$(wildcard *.c))

%.times: %.rv64gcv.time %.rv64gc.time
	cat $^ > $@

%.rv64gc.time: %.rv64gc.static
	/usr/bin/time qemu-riscv64 -cpu rv64,v=false $< 2> $@

%.rv64gcv.time: %.rv64gcv.static
	/usr/bin/time qemu-riscv64 -cpu rv64,v=true $< 2> $@

%.dump: %.static
	riscv64-unknown-linux-gnu-objdump -d $< > $@

%.rv64gcv.static: %.c
	riscv64-unknown-linux-gnu-gcc -O3 -static -o $@ $^ -march=rv64gcv

%.rv64gc.static: %.c
	riscv64-unknown-linux-gnu-gcc -O3 -static -o $@ $^ -march=rv64gc

clean::
	rm *.static *.times *.time

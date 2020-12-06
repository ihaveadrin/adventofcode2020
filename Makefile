prog=$(wildcard puzzle*.nim)
obj=$(patsubst %.nim,%,$(prog))

all: $(obj) 
	echo ${prog}
	echo ${obj}

%: %.nim
	nim c $<

clean: 
	rm -v ${obj}

.PHONY: all clean

PRG            = main


SOURCES		= main.c
OBJ			= $(SOURCES:.c=.o)
LIBS           =

#MCU_TARGET     = atmega644p
MCU_TARGET     = atmega328p

OPTIMIZE       = -O2
CC             = avr-gcc

override CFLAGS        = -g -Wall $(OPTIMIZE) -mmcu=$(MCU_TARGET) -Os
override LDFLAGS       = -Wl,-Map,$(PRG).map
OBJCOPY        = avr-objcopy
OBJDUMP        = avr-objdu

EXTRA_CLEAN_FILES       = *.hex *.bin *.srec

all: clean $(PRG).elf hex
$(PRG).elf: $(OBJ)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)
%.o: %.c
	$(CC) $(CFLAGS) -c $^
clean:
	rm -rf *.o $(PRG).elf *.eps *.png *.pdf *.bak 
	rm -rf *.lst *.map $(EXTRA_CLEAN_FILES)
hex:  $(PRG).hex
%.hex: %.elf
	$(OBJCOPY) -j .text -j .data -O ihex $< $@

main:
import sys

def make_entry(base: int, limit: int, access_byte: int, flags: int) -> int:
    """
        Makes a gdt_entry for a given base, limit, access byte and flag bytes

        base: 32 bits
        limit: 32 bits
        access: 8 bits
        flags: 8 bits


    """
    descriptor = limit         & 0x000F0000
    descriptor |= (flags << 8) & 0x00F0FF00
    descriptor |= (base >> 16) & 0x000000FF
    descriptor |= base         & 0xFF000000

    descriptor <<= 32


    descriptor |= base << 16
    descriptor |= limit & 0x0000FFFF

    print('{:016x}'.format(descriptor))


[base, limit, access_byte, flags] = sys.argv[1:]

make_entry(int(base, 0), int(limit, 0), int(access_byte, 0), int(flags, 0))



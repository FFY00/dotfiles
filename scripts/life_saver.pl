#!/usr/bin/perl
open(DEV, '/dev/sda1') or die "Can't open: $!\n";
while (read(DEV, $buf, 4096)) {
  print tell(DEV), "\n", $buf, "\n"
    if $buf =~ /@ARGV/;
}

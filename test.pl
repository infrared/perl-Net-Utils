use strict;
use warnings;
use lib './lib';

use Net::Utils;

my $nu = Net::Utils->new;

print $nu->valid_mask('255.128.0.0');

print "\n";
print $nu->valid_mask('/32');

print $nu->network('192.168.10.56','/24')->binary_to_ip;

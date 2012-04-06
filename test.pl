use strict;
use warnings;
use lib './lib';

use Net::Utils;

my $nu = Net::Utils->new;

print $nu->valid_mask('255.128.0.0');

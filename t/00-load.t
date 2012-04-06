#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Net::Utils' ) || print "Bail out!\n";
}

diag( "Testing Net::Utils $Net::Utils::VERSION, Perl $], $^X" );

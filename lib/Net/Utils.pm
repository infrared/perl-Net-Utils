package Net::Utils;

use 5.006;
use strict;
use warnings;
use List::MoreUtils qw(pairwise);

=head1 NAME

Net::Utils - Utilities for calculating various network stuff

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

    use Net::Utils;

    my $nu = Net::Utils->new();
    


=head1 METHODS

=head2 new

Constructor

=cut
sub new {
    my $class = shift;
    my $self = bless {}, $class;
    return $self;
}
=head2 network

Returns network address of a given IP & mask

=cut

sub network {
        my ($self,$ip,$mask) = @_;
        
=cut
        # TO DO
        
        # mask in binary
        my $ones = $prefix;
        my $zeros = 32 - $prefix;
        my $binary_mask = 1 x $ones . 0 x $zeros;
        my @mask = split('',$binary_mask);

        # IP in binary
        my $join = join('',@octets);
        my @ipaddr = split('',$join);


        my @network = pairwise { $a & $b } @mask,@ipaddr;
        my $network_binary = join('',@network);
        my @network_octets = ($network_binary =~ /(\d{8})/g);
        my @decimals = map{ _bin2dec($_) } @network_octets;
        
        my $question = "Given $ip/$prefix, network address is?";
        my $answer = join('.',@decimals);
        
        my @array = ($question,$answer);
        return @array;
=cut
}

=head2 broadcast

Returns broadcast address of a given IP & mask

=cut

=head2 random_ip

Generate random IP address

=cut
sub _randomip {
        my $ip = join ".", map int rand 256, 1 .. 4;
        return $ip;
}

=head2 bin2dec

Convert binary to decimal

=cut

sub _bin2dec {
        my $binary = shift;
        my $decimal = unpack("N", pack("B32", substr("0" x 32 . $binary, -32)));
        return $decimal;
}
=head2 dec2bin

Convert decimal to binary

=cut
sub dec2bin {
        my $decimal = shift;
        my $binary = unpack("B32", pack("N", $decimal));
        $binary =~ s/^0+(?=\d)//;
        $binary = sprintf("%08d",$binary);
        return $binary;
}
=head2 dunno

Not sure if this will stay

=cut

sub dec2bin_nibble {
        my $decimal = shift;
        my $binary = unpack("B32", pack("N", $decimal));
        $binary =~ s/^0+(?=\d)//;
        $binary = sprintf("%04d",$binary);
        return $binary;
}

=head2 valid_mask

Validate a netmask

=cut
sub valid_mask {
    my ($self,$mask) = @_;
    
     if ($mask =~ /^\/\d{1,2}$/) {
        # TO DO CIDR stuff
=cut
        my $cidr
        my $ones = $prefix;
        my $zeros = 32 - $prefix;
        my $binary_mask = 1 x $ones . 0 x $zeros;
        my @mask = split('',$binary_mask);
        # CIDR
=cut    
    }
    elsif ($mask =~ /^\d{3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/) {
        my (@octets) = ($mask =~ /(\d+)/g);
             
        my @binary_octets = map{ dec2bin($_) } @octets;
        my $binary_mask = join('',@binary_octets);
        print $binary_mask,"\n";
        if ($binary_mask =~ /^1+0+?$/) {
            return "valid";
        }
        else {
            return 0;
        }
    }
    else {
        return 0;
    }
    
}
    
=head2 valid_ip

Validate an IP address

=cut

sub valid_ip {
    # to do
    return; 
}




=head1 AUTHOR

Michael Kroher, C<< <infrared at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-net-utils at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Net-Utils>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Net::Utils


You can also look for information at:

=over 4

=item * github

L<https://github.com/infrared/Net-Utils>

=back




=head1 LICENSE AND COPYRIGHT

Copyright 2012 Michael Kroher.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of Net::Utils

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
        my $binary_mask = $self->valid_mask($mask);

        my @mask = split('',$binary_mask);

        # IP in binary
        my @octets = map{ dec2bin($_) } split('\.',$ip);
        my $join = join('',@octets);
        my @ipaddr = split('',$join);


        my @network = pairwise { $a & $b } @mask,@ipaddr;
        return join ('', @network);

        

}

=head2 broadcast

Returns broadcast address of a given IP & mask

=cut

sub broadcast {
        my ($self,$ip,$mask) = @_;
        my $binary_mask = $self->valid_mask($mask);

        my @mask = split('',$binary_mask);

        # IP in binary
        my @octets = map{ dec2bin($_) } split('\.',$ip);
        my $join = join('',@octets);
        my @ipaddr = split('',$join);


        my @broadcast = pairwise { $a | $b } @mask,@ipaddr;
        my $broadcast_binary = join('',@broadcast);

        return $self->binary_to_ip($broadcast_binary);

}

=head2 random_ip

Generate random IP address

=cut
sub randomip {
        # TO DO
        # Class A,B,C, private/public
        
        my $ip = join ".", map int rand 256, 1 .. 4;
        return $ip;
}

=head2 bin2dec

Convert binary to decimal

=cut

sub bin2dec {
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

=head2 valid_mask_binary

Validates a netmask, and returns the mask binary format

=cut
sub valid_mask {
    my ($self,$mask) = @_;
    
     if ($mask =~ /^\/\d{1,2}$/) {
        # CIDR

        my ($ones)  = ($mask =~ /^\/(\d{1,2})$/);  # a /30 is 30 1's
        my $zeros = 32 - $ones;
        my $binary_mask = 1 x $ones . 0 x $zeros;
        if ($binary_mask =~ /^1+0*$/) {
            return $binary_mask;
        }
        else {
            return 0;
        }


    }
    elsif ($mask =~ /^\d{3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/) {
        my (@octets) = ($mask =~ /(\d+)/g);
             
        my @binary_octets = map{ dec2bin($_) } @octets;
        my $binary_mask = join('',@binary_octets);
        if ($binary_mask =~ /^1+0*$/) {
            return $binary_mask;
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

=head2 binary_to_ip {

Convert 32 bit binary into an IP address format

=cut

sub binary_to_ip {
    my ($self,$binary) = @_;
    my @octets = ($binary =~ /(\d{8})/g);
    my @decimals = map{ bin2dec($_) } @octets;
        
        
    return join('.',@decimals);
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

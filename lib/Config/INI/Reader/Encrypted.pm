package Config::INI::Reader::Encrypted;

use 5.006;
use strict;
use warnings FATAL => 'all';
use parent qw/ Config::INI::Reader /;
use Carp;
use File::Slurp qw//;
use Crypt::CBC;

=head1 NAME

Config::INI::Reader::Encrypted - Read AES encrypted INI files

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

    my $filename = 'myconfig.ini.aes';
    my $key = 'It$As3cReT';
    my $config =
      eval { Config::INI::Reader::Encrypted->read_file( $filename, $key ); };
    if ($@) {
        croak "Unable to decrypt the file";
    }

=head1 DESCRIPTION

This module is a subclass of Config::INI::Reader that can read encrypted INI
files. The idea is that a user can place sentitive settings, such as usernames
and passwords, in the INI file and encrypt it. This module can then be used to
read and unencrypt the file when needed.

=head1 SUBROUTINES/METHODS

=head2 read_file

Given a filename and decryption key, this method returns a hashref of the
contents of that file.

=cut

sub read_file {
    my ($self, $filename, $key) = @_;

    if ( !defined $key ) {
        croak "A key was not provided";
    }

    my $ciphertext = File::Slurp::read_file($filename);

    # Decrypt file
    my $cipher = Crypt::CBC->new(
        -key    => $key,
        -cipher => 'Rijndael',
    ) or croak "Couldn't create CBC object";

    my $plaintext = $cipher->decrypt($ciphertext);

    # Parse unencrypted config file
    my $cfg = $self->read_string($plaintext);

    return $cfg;
}


=head1 AUTHOR

Matt Perry, C<< <matt at mattperry.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-config-ini-reader-encrypted at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Config-INI-Reader-Encrypted>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Config::INI::Reader::Encrypted


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Config-INI-Reader-Encrypted>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Config-INI-Reader-Encrypted>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Config-INI-Reader-Encrypted>

=item * Search CPAN

L<http://search.cpan.org/dist/Config-INI-Reader-Encrypted/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2014 Matt Perry

This library is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=head1 SEE ALSO

L<Config::INI::Reader>

=cut

1; # End of Config::INI::Reader::Encrypted

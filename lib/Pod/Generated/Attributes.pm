package Pod::Generated::Attributes;


use warnings;
use strict;
use Attribute::Handlers;
use Pod::Generated 'add_doc';


our $VERSION = '0.01';


sub add_attr_doc {
    my ($type, $package, $symbol, $referent, $attr, $data, $phase) = @_;
    add_doc($package, ref($referent), *{$symbol}{NAME}, $type, $data);
}


no warnings 'redefine';

sub UNIVERSAL::Purpose    :ATTR         { add_attr_doc(purpose    => @_) }
sub UNIVERSAL::Id         :ATTR         { add_attr_doc(id         => @_) }
sub UNIVERSAL::Author     :ATTR         { add_attr_doc(author     => @_) }
sub UNIVERSAL::Param      :ATTR(CODE)   { add_attr_doc(param      => @_) }
sub UNIVERSAL::Returns    :ATTR(CODE)   { add_attr_doc(returns    => @_) }
sub UNIVERSAL::Throws     :ATTR(CODE)   { add_attr_doc(throws     => @_) }
sub UNIVERSAL::Example    :ATTR         { add_attr_doc(example    => @_) }
sub UNIVERSAL::Deprecated :ATTR         { add_attr_doc(deprecated => @_) }
sub UNIVERSAL::Default    :ATTR(SCALAR) { add_attr_doc(default    => @_) }
sub UNIVERSAL::Default    :ATTR(ARRAY)  { add_attr_doc(default    => @_) }
sub UNIVERSAL::Default    :ATTR(HASH)   { add_attr_doc(default    => @_) }



1;


__END__

=head1 NAME

Pod::Generated::Attributes - use attributes to declare documentation

=head1 SYNOPSIS

    sub say
        : Purpose(prints its arguments, appending a newline)
        : Param(@text; the text to be printed)
        : Deprecated(use Perl6::Say instead)
    {
        my $self = shift;
        print @_, "\n";
    }

=head1 DESCRIPTION

This module provides attributes so you can declare documentation with the
subroutine or variable you are documenting.

The following attributes are provided:

=over 4

=item Purpose

=item Id

=item Author

=item Param

=item Returns

=item Throws

=item Example

=item Default

=back

More documentation will follow.

=head1 TAGS

If you talk about this module in blogs, on del.icio.us or anywhere else,
please use the C<podgenerated> tag.

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests to
C<bug-pod-generated@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.

=head1 INSTALLATION

See perlmodinstall for information and options on installing Perl modules.

=head1 AVAILABILITY

The latest version of this module is available from the Comprehensive Perl
Archive Network (CPAN). Visit <http://www.perl.com/CPAN/> to find a CPAN
site near you. Or see <http://www.perl.com/CPAN/authors/id/M/MA/MARCEL/>.

=head1 AUTHOR

Marcel GrE<uuml>nauer, C<< <marcel@cpan.org> >>

=head1 COPYRIGHT AND LICENSE

Copyright 2007 by Marcel GrE<uuml>nauer

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut


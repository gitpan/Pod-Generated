package Template::Plugin::PodGenerated;

use strict;
use warnings;
use Pod::Generated 'doc';


our $VERSION = '0.01';


use base 'Template::Plugin';


sub new {
    my ($class, $context) = @_;

    my $source = $context->stash->get('SOURCE');

    my $package;
    if ($source =~ /
        ^
        package \s*
        (\w+(::(?:\w+))*)
        \s* ;
    /xms) {
        $package = $1;
    } else {
        die "can't parse package from source\n";
    }

    # This will generate documentation via add_doc.

    eval $source;
    die "can't eval source: $@\n" if $@;

    bless {
        _CONTEXT => $context,
        package  => $package,
    }, $class;
}


sub package {
    my $self = shift;
    $self->{package};
}


sub format {
    my ($self, %args) = @_;
    my $result = '';
    my $line = my $indent = ' ' x $args{indent};

    for my $word (split /\s+/ => $args{text}) {
        if (length($line) + 1 + length($word) > $args{width}) {
            $result .= "$line\n";
            $line = $indent . $word;
        } else {
            $line .= ' ' if length($result) != 0 || length($line) != 0;
            $line .= $word;
        }
    }
    $result .= "$line\n";
    $result;
}


sub write_inheritance {
    my $self = shift;
    no strict 'refs';
    my @inherited = @{ $self->{package} . '::ISA' };

    my $result = $self->format(
        indent => 0,
        width  => 75,
        text   => sprintf "%s inherits from %s.\n", $self->{package},
            join ', ' =>
            map { "L<$_>" } 
            @inherited
    );

    my %doc = doc();
    for my $pkg (@inherited) {
        next unless keys %{ $doc{$pkg}{CODE} || {} };
        $result .= "\nMethods inherited from L<$pkg>:\n\n";
        $result .= $self->format(
            indent => 4,
            width  => 75,
            text   =>
                join ', ' =>
                map { "$_()" }
                $self->sub_order(keys %{ $doc{$pkg}{CODE} })
        );
    }

    1 while chomp $result;
    $result;
}


sub write_methods {
    my $self = shift;

    my %doc = doc();
    my $package_doc = $doc{ $self->{package} }{CODE} || {};

    my $result = '';

    for my $sub ($self->sub_order(keys %$package_doc)) {
        my $vars = {
            sub     => $sub,
            purpose => (join "\n" => @{ $package_doc->{$sub}{purpose} }),
            example => (join "\n" => map { "    $_" } 
                @{ $package_doc->{$sub}{example} }),
        };

        $result .=
            "=item $vars->{sub}\n\n$vars->{example}\n\n$vars->{purpose}\n";
    }

    1 while chomp $result;
    $result;
}


# Basically an alphabetic sort, but sort certain sub names first, such as
# 'new' and 'instance'.

sub sub_order {
    my ($self, @names) = @_;
    
    my %has;
    @has{@names} = ();

    # partition the names into those that should come first, and the rest
    my @first;

    for my $name (qw(new instance)) {
        next unless exists $has{$name};
        delete $has{$name};
        push @first => $name;
    }

    (sort(@first), sort keys %has);
}


1;


__END__

=head1 NAME



=head1 SYNOPSIS


    {% USE p = PodGenerated %}

    =head1 NAME

    {% p.package %} - Definition of what this module does

    =head1 SYNOPSIS

        {% p.package %}->new;

    =head1 DESCRIPTION

    {% p.write_inheritance %}

    =head1 METHODS

    =over 4

    {% p.write_methods %}

    =back

    {% PROCESS standard_pod_zid %}

    =cut

=head1 DESCRIPTION

This is a plugin for the L<Template> Toolkit that you can use to generate POD
documentation during C<make> time.

To understand the concepts behind this, please read the documetation of
L<Module::Install::Template> and C<Pod::Generated>.

When this plugin is loaded in a template - using C<USE p = PodGenerated>, for
example - it evaluates the template's source code - which it has by magic of
L<Module::Install::Template> - so it gives participating modules a chance to
generate documentation. For example, if your module uses
L<Class::Accessor::Complex>, documentation for the generated accessors will be
generated during this time.

This plugin provides the following methods to be used in templates:

=over 4

=item package

The current package name as parsed from the source code.

=item write_inheritance

Information about which classes the current class inherits from and which
methods it inherites, as far as known. Only those methods in superclasses for
which documentation has also been generated are found through this mechanism.

This might be improved at some point.

=item write_methods

Write the documentation for the methods in the current package that have
documentation defined for it.

=back

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


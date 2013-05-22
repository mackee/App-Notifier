package App::Notifier;
use 5.008005;
use strict;
use warnings;

our $VERSION = "0.01";

use Module::Pluggable;

sub new {
    my $class = shift;
    my %opt = @_;

    return bless {
        opt => %opt
    }, $class;
}

sub opt { shift->{opt}; }

sub exec_command {
    my $self = shift;
    my @commands = @_;

    $self->setup;

    system @commands;

    $self->finish;
}

sub setup {
    my $self = shift;
}

sub finish {
    my $self = shift;
}

1;
__END__

=encoding utf-8

=head1 NAME

App::Notifier - Run some command and send to target with notifier plugins

=head1 SYNOPSIS

Connect <notif> and some options before a long-running command.

    $ notif -P after_mail -t example@example.com benchmark.pl

This example is using App::Notifier::Plugin::After::Mail.
This is sending mail to <example@example.com> after the command.

=head1 DESCRIPTION

App::Notifier is ...

=head1 LICENSE

Copyright (C) MACOPY.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

MACOPY E<lt>macopy123[at]gmail[dot]com E<gt>

=cut


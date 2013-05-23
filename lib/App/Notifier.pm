package App::Notifier;
use 5.008005;
use strict;
use warnings;

our $VERSION = "0.01";

use Module::Pluggable
    require => 1,
    search_path => ['App::Notifier::Plugin'];

sub new {
    my $class = shift;
    my %opt = @_;

    return bless {
        plugins => $opt{plugins},
        argv => $opt{argv},
        commands => [],
        queue => [],
        plugin_module_list => [],
        commands => [],
        return_code => 0,
        command_result => '',
    }, $class;
}

sub exec {
    my $self = shift;

    my $command = join ' ', @{$self->{commands}};
    $self->{command_result} = `$command`;
    $self->{return_code} = $? >> 8;

}

sub setup {
    my $self = shift;

    my @commands;
    for my $arg (reverse @{$self->{argv}}) {
        last if '--' eq $arg;
        unshift @commands, $arg;
    }
    $self->{commands} = [ @commands ];

    for my $plugin_name ($self->plugins) {
        my @module_splited_name = split /::/, $plugin_name;
        my $plugin_suffix = $module_splited_name[-1];
        if (grep { $plugin_suffix eq $_ } @{$self->{plugins}}) {
            push @{$self->{plugin_module_list}}, $plugin_name;
        }
    }

}

sub finish {
    my $self = shift;
    for my $plugin (@{$self->{plugin_module_list}}) {
        if ($plugin->can('finish')) {
            $plugin->finish($self);
        }
    }
}

1;
__END__

=encoding utf-8

=head1 NAME

App::Notifier - Run some command and send to target with notifier plugins

=head1 SYNOPSIS

Connect <notif> and some options before a long-running command.

    $ notif -p Mail --mail_to example@example.com -- benchmark.pl

This example is using App::Notifier::Plugin::Mail.
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


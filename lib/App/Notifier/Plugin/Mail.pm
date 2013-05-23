package App::Notifier::Plugin::Mail;
use strict;
use warnings;
use utf8;
use 5.012;

use MIME::Lite;
use Sys::Hostname qw/hostname/;
use Getopt::Long qw/GetOptionsFromArray/;

sub finish {
    my $class = shift;
    my $executer = shift;

    GetOptionsFromArray($executer->{argv}, \my %opt,
        qw/
            mail_to=s
            mail_from=s
        /
    );
    my $to_address = $opt{mail_to};
    my $from_address = $opt{mail_from} // 'notifier@'.hostname();

    my $data = '';
    if ($executer->{command_result}) {
        $data .= <<"DATA";
Result
==============================
$executer->{command_result}
==============================
DATA
    }

    $data .= "exit code: $executer->{return_code}";

    my $mail =
        MIME::Lite->new(
            From => $from_address,
            To => $to_address,
            Subject => 'Execute command result: '.join(' ', @{$executer->{commands}}),
            Data => $data
        );
    $mail->send;
}

1;


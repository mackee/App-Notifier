requires 'perl', '5.008001';

on 'test' => sub {
    requires 'Test::More', '0.98';
};

requires 'Module::Pluggable';
requires 'Getopt::Long';
requires 'Pod::Usage';
requires 'MIME::Lite';
requires 'Sys::Hostname';


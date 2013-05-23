# NAME

App::Notifier - Send to message with notifier plugins after the run command

# SYNOPSIS

Connect <notif> and some options before a long-running command.

    $ notif -p Mail --mail_to example@example.com -- benchmark.pl

This example is using App::Notifier::Plugin::Mail.
This is sending mail to <example@example.com> after the command.

# DESCRIPTION

App::Notifier is ...

# LICENSE

Copyright (C) MACOPY.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

MACOPY <macopy123\[at\]gmail\[dot\]com >

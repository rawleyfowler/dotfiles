#!/usr/bin/env perl
use v5.36;

use File::Path qw(make_path);
use List::Util qw(first);
use File::Copy::Recursive qw(rcopy);
use Config;
use Env;

use experimental 'smartmatch';

my $HOME = $ENV{'HOME'};
my $dry = first { $_ eq '--dry' } @ARGV;

my $dot = first { $_ ne '--dry' } @ARGV;

sub copy_to_home($root) {
    if ($dry) {
        say "Copying $root to $HOME/";
    } else {
        rcopy("$root/*", "$HOME/");
    }
}

sub copy_to_config($root) {
    if ($dry) {
        say "Making path $HOME/.config/";
        say "Copying $root/* to $HOME/.config/$root";
    } else {
        make_path("$HOME/.config/");
        rcopy("$root/*", "$HOME/.config/$root");
    }
}

if ($dot eq 'i3') {
    copy_to_config('i3');
} elsif ($dot eq 'cwm' ||
         $dot eq 'dwm') {
    copy_to_home("$dot/xorg/*");
} elsif ($dot eq 'bash') {
    copy_to_home("bash/*");
} elsif ($dot eq 'fish') {
    copy_to_config('fish');
} elsif ($dot eq 'git') {
    copy_to_home('git/.gitignore_global');
} else {
    copy_to_home("$dot/*");
}

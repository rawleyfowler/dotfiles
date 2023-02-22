#!/usr/bin/env perl

use v5.36;

use File::Spec;
use Carp q<croak>;

my @packages = qw<
    git
    emacs
    clang
    perl
    firefox
    hexchat
    bash
    >;

sub install_packages($cmd) {
    my @success;
    my @failed;
    for (@packages) {
        my $ret = system($cmd . $_);

        if ($ret == 0) {
            push @success, $_;
        } else {
            push @failed, $_;
        }
    }

    return (\@success, \@failed);
}

sub generate_command($os) {
    $os = 'freebsd' if $os eq 'dragonfly';

    my $cmd;
    $cmd = 'pkg_add -Im ' if $os eq 'openbsd';
    $cmd = 'pkg install -yi ' if $os eq 'freebsd';

    if ($os eq 'netbsd') {
        my $dir = File::Spec::splitpath(__FILE__)->[1];
        $cmd = "pkg_add -C $dir/netbsd.config" if $os eq 'netbsd';
    }

    croak 'You should never see this!! Somehow the program blew up!' unless $cmd;

    return $cmd;
}

my $cmd;
if ($^O eq 'freebsd'   ||
    $^O eq 'openbsd'   ||
    $^O eq 'dragonfly' ||
    $^O eq 'netbsd') {
    $cmd = generate_command($^O);
} else {
    print qq/I can't figure what OS you're using.\nPlease specify the command to install packages (include sudo, doas, and\/or -y if applicable): /;
    my $pkg_mngr = <STDIN>;
    chomp $pkg_mngr;
    $cmd = $pkg_mngr . ' ';
}

my ($success, $failed) = install_packages($cmd);

if ($success) {
    print "Successfully installed the following packages: ";
    print "$_ " for (@{$success});
    print "\n";
} else {
    print "Failed to install all packages :(\n";
    exit 1;
}

if ($failed) {
    print "Failed to install some packages: ";
    print "$_ " for (@{$failed});
    print "\n";
    exit 2;
}

exit 0;

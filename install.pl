use v5.36;

use File::Copy;
use Config;
use Env;

use experimental 'smartmatch';

my @SUPPORTED_OS = [ 'freebsd', 'linux', 'openbsd' ];
my $HOME = $ENV{HOME};
my $DRY = (@ARGV ~~ '--dry');

sub install {
	my ($os) = @_;

	sub install_dir {
		my ($dir_name, $step) = @_;

		$step = '' unless $step;

		opendir(my $dir, $dir_name);
		my @files = readdir($dir);
		closedir($dir);

		foreach my $file (@files) {
			chomp $file;

			next if ($file eq '..') || ($file eq '.');

			if (-d "$dir_name/$file") {
				say "INSTALLING DIR $dir_name";
				
				if (length($step) > 0) {
					mkdir "$HOME$step/$dir_name" unless $DRY;
				} else {
					mkdir "$HOME/$dir_name" unless $DRY;
				}
				
				install_dir("$dir_name/$file", "$step/$file");
			} elsif (-e "$dir_name/$file") {
				if (length($step) > 0) {
					say "INSTALLING $dir_name/$file TO $HOME$step/$file";
					copy("dir_name/$file", "$HOME/$file") unless $DRY;
				} else {
					say "INSTALLING $dir_name/$file TO $HOME/$file";
					copy("dir_name/$file", "$HOME/$file") unless $DRY;
				}
			}
		}
	}
	
	die 'Your operating system is not supported, to try anyways provide the OS type you would like to install as the first argument'
		unless ($os ~~ @SUPPORTED_OS);

	install_dir("./$os/home");
}

if (scalar(@ARGV) && length($ARGV[0]) && ($ARGV[0] ne '--dry')) {
	install($ARGV[0]);
} else {
	install($^O);
}

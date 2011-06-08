#!c:/perl/bin/perl.exe
##
##  devInit-- device initializtion
##
use CGI;  
$query = CGI->new(\*STDIN);
$device = $query->param('deviceId');
$version = $query->param('version');

print "Content-type: text/plain; charset=iso-8859-1\n\n";

my $devFile;

$devFile = "device.txt";

## check device ID existed in device file or nor
## die if it is already existed
open IN, "<${devFile}" or die $!;
while (<IN>) {
    if ($_ =~ m/$device/)
    {
    	print "yes";
	die;
    }
    else
    {
    	print "no";
    }
}
close IN;

## record device ID and client OS version to device file
open FILE, ">>${devFile}" or die $!;
print FILE "${device} ${version}\n";
close FILE;



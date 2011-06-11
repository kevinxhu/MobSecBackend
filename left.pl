#!c:/perl/bin/perl.exe
##
## left.pl  
##
use CGI;  
print "Content-type: text/html; charset=iso-8859-1\n\n";

open(TEMPLATE, "../htdocs/left.html");
while(<TEMPLATE>) {
    $buffer .= $_;
}

my $devFile;

$devFile = "device.txt";

$device;
open IN, "<${devFile}" or die $!;
while (<IN>) {
	if ($_) {
		$device  .= "<li><a href=\"../content.html?dev=${_}}\" target=\"content\">${_}</a></li>";
	}
}


$buffer =~ s/<!--cgi:device-->/$device/g; 
print $buffer;
close TEMPLATE;

#!c:/perl/bin/perl.exe
##
## content.pl  
##
use CGI;  
my $cgi = new CGI;

my $devId = $cgi->param("dev");

my $policyFile = "../htdocs/${devId}.txt";
my $jsbuf;
my $index = 0;
$jsbuf .= "var devId = \"${devId}\";\n";
open IN, "<${policyFile}";
while (<IN>) {
    if($_) {
	my @values = split(' ', $_);	
	$jsbuf .= "policyList[${index}] = new policyObj(\"${values[0]}\", \"${values[1]}\", \"${values[2]}\", \"${values[3]}\");\n";
	$index += 1;
    }
}

print "Content-type: text/html; charset=iso-8859-1\n\n";

open(TEMPLATE, "../htdocs/content.html");
while(<TEMPLATE>) {
    $buffer .= $_;
}

$buffer =~ s/<!--cgi:policy-->/$jsbuf/g; 
print $buffer;
close TEMPLATE;

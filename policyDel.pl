#!c:/perl/bin/perl.exe
##
##  policyDel.pl-- policy configuration
##
use CGI;  
use File::Copy;
$query = CGI->new(\*STDIN);
$device = $query->param('deviceId');
$polName = $query->param('polName');

my $policyFile;
my $policyFileBk;

$policyFile = "../htdocs/${device}.txt";
$policyFileBk = "../htdocs/${device}.txt.bk";

copy($policyFile,$policyFileBk) or die "Copy failed: $!";
open OUT, ">${policyFile}" or die $!;
open IN, "<${policyFileBk}" or die $!;
while (<IN>) {
	if($_ =~ m/$polName/)
	{
	}
	else
	{
		print OUT "${_}";	
	}
}

close OUT;

my $policyFile = "../htdocs/${device}.txt";
my $jsbuf;
my $index = 0;
$jsbuf .= "var devId = \"${device}\";\n";
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

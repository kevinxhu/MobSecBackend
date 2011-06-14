#!c:/perl/bin/perl.exe
##
##  policyConf.pl-- policy configuration
##
use CGI;  
use File::Copy;
$query = CGI->new(\*STDIN);
$device = $query->param('deviceId');
$polName = $query->param('polName');
$polType = $query->param('polType');
$polAddr = $query->param('polAddr');
$polMask = $query->param('polMask');

my $policyFile;
my $policyFileBk;

$policyFile = "../htdocs/${device}.txt";
$policyFileBk = "../htdocs/${device}.txt.bk";

my $outbuf = "${polName} ${polType} ";
if($polType == "0")
{
	$outbuf .= "${polAddr} ${polMask}";
}
else
{
	$outbuf .= "${polAddr}";
}

copy($policyFile,$policyFileBk) or die "Copy failed: $!";
open OUT, ">${policyFile}" or die $!;
open IN, "<${policyFileBk}" or die $!;
while (<IN>) {
	if($_ =~ m/$polName/)
	{
		print OUT "${outbuf}\n";
	}
	else
	{
		print OUT "${_}"	
	}
}

close OUT;

print "Content-type: text/html; charset=iso-8859-1\n\n";


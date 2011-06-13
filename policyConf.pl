#!c:/perl/bin/perl.exe
##
##  policyConf.pl-- policy configuration
##
use CGI;  
$query = CGI->new(\*STDIN);
$device = $query->param('deviceId');
$polName = $query->param('polName');
$polType = $query->param('polType');
$polAddr = $query->param('polAddr');
$polMask = $query->param('polMask');

print "Content-type: text/plain; charset=iso-8859-1\n\n";

my $policyFile;

$policyFile = "../htdocs/${device}.txt";

my $outbuf = "${polName} ${polType} ";
if($polType == "0")
{
	$outbuf .= "${polAddr} ${polMask}";
}
else
{
	$outbuf .= "${polAddr}";
}

open OUT, ">>${policyFile}" or die $!;
print OUT "${outbuf}\n";
close OUT;



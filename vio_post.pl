use strict;
use warnings;

my $go_back_bid_num = 5;                #Back bid numbers
my $eos_account_name = "worldpeace55";  #your eos account name
my $passwd = "buyer_p";                 #eos wallet password file
my $wallet_name = "buyer";              #eos wallet name


my $api_url;

if($ARGV[1])
{
$api_url = "-u $ARGV[1]";
}
else
{
$api_url = "";
}

sub bid_action
{
  print "line num : $_[0] \n";
  my @cleos_get = `cleos $api_url get table labelaarbaro labelaarbaro posts -L $_[0] -l 1`;
  if ($cleos_get[2] =~ /post_id\D+(\d+)/)
  {
   my $post_id = $1;
   print "post_id : $post_id\n";
   if($cleos_get[3] =~ /labelaarbaro/)
   {
    print "bid 1\n";
   `cat $passwd |cleos wallet unlock -n $wallet_name`;
    `cleos $api_url  push action labelaarbaro bid '["$eos_account_name","$post_id"]' -p $eos_account_name`;
   }
   elsif($cleos_get[5] =~ /\"next_bid\"\: \"13.0000|16.9000|21.9700 VIO\"/) #next bid  28.5610 37.1293...   #add bid regular matching mode
   {
   print "bid 2 \n";
    unless($cleos_get[3] =~ /$eos_account_name/)
    {
   `cat $passwd |cleos wallet unlock -n $wallet_name`;
   `cleos $api_url  push action labelaarbaro bid '["$eos_account_name","$post_id"]' -p $eos_account_name`;
    }
   }
   return 1;
  }
}

if (@ARGV)
{
 while()
 {
  print "$ARGV[0] \n";
  my $get_return  = bid_action ($ARGV[0]);
  
  unless (my $pid = fork) {
    print "child process\n";
    my $bid_num = $ARGV[0] - $go_back_bid_num;
    foreach ($bid_num..$ARGV[0])
    {
    bid_action ($_);
    }
    exit 0;
   }
  
   if ($get_return == 1)
  {
   $ARGV[0] ++;
  }
  sleep(1);

 }
}

else
{
print "ARGV MISSING \n";
}


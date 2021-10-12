use strict;
use warnings;

my $eden_account = "worldpeace55";   #your eos account name
my $api = "http://api.eosn.io";      #eos node api
my $passwd = "buyer_p";              #eos wallet password file
my $wallet_name = "buyer";           #eos wallet name

while()
{

`cat $passwd |cleos wallet unlock -n $wallet_name`;

for (0..1)
{
my $curl_get = `curl https://api.eospowerup.io/freePowerup/$eden_account`;
print $curl_get;
sleep (5);
}

for (0..1)
{
my $cleos =`cleos -u $api push action labelaarbaro  checkin '["$eden_account"]' -p $eden_account`;
sleep(5);
}

#for (0..1)
#{
#my $cleos =`cleos -u $api push action labelaarbaro  withdraw '["worldpeace55"]' -p $eden_account`;
#sleep(5);
#}

sleep (86400-10);

}

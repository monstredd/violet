# violet

vio token auto claim;

cleos must be installed first;

your account private key must be your cleos wallet.

mac and ubuntu tested;

Modify your parameters in scrpit before run it.

nohup perl vio_claim.pl >>claim.log 2>&1 &

nohup perl vio_claim.pl POSTNUM EOS_NODE_API_ADDRESS  >>post.log 2>&1 &    #if use run on your owe nodeos parameter 2 left blank, POSTNUM is the new post number.


# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Sudo.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 4;
use Data::Dumper;
#use Sudo;

BEGIN { use_ok('Sudo') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

my ($user,$pass,$sudo,$id,$su,$rc);


print STDERR "\n\n-----\n";
$sudo = '/usr/bin/sudo';
printf STDERR  "sudo found at %s\n",$sudo if (-e $sudo);
while (! -e $sudo) 
   {
    print  STDERR "Enter full path to sudo (e.g. /usr/bin/sudo): \n";
    chomp($sudo=<>);
   }

$id = '/usr/bin/id';
printf  STDERR "id found at %s\n",$id if (-e $id);
while (! -e $id) 
   {
    print STDERR  "Enter full path to the \"id\" program (e.g. /usr/bin/id): \n ";
    chomp($id=<>);
   }
   
print STDERR  "\n\nEnter a user name to which you have a valid password: \n";
chomp($user=<>);
print STDERR  "Enter the correct password for the user name you just entered: \n";
chomp($pass=<>);

$su = Sudo->new(
		{
		 username => $user, 
		 password=>$pass, 
		 sudo => $sudo, 
		 debug => '1',
		 program => $id
		}
	       );
$rc = $su->sudo_run;

ok (exists($rc->{stdout}), "Captured standard output");
ok (exists($rc->{rc}), "Captured return code");
ok (!exists($rc->{error}), "No error messages");

#v0.10 Sudo.t:  Governed by the Artistic License
#copyright (c) 2004 Scalable Informatics LLC
#http://scalableinformatics.com

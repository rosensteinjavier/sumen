use lib './lib';
use utf8;

use SMM::Schema;

use FindBin qw($Bin);
use lib "$Bin/../files";
use File::Basename;
use Text::CSV;
use DDP;
use List::Util qw/sum/;
use JSON;

use Catalyst::Test q(SMM);
my $config = SMM->config;

my $schema = SMM::Schema->connect(
    $config->{'Model::DB'}{connect_info}{dsn},
    $config->{'Model::DB'}{connect_info}{user},
    $config->{'Model::DB'}{connect_info}{password}
);

my $csv = Text::CSV->new(
    { binary => 1, sep_char => ';' } )    # should set binary attribute.
  or die "Cannot use CSV: " . Text::CSV->error_diag();

open my $fh, '<:encoding(utf8)', 'data/project_milestones.csv'
  or die "nao abriu";

my $furl = Furl->new(
    agent   => 'SMM',
    timeout => 100
);

my @rows;
my $data = {};
while ( my $row = $csv->getline($fh) ) {

    my $project =
      $schema->resultset('Project')->search( { project_number => $row->[1] } )
      ->next;

    use DDP;
    p $row->[1];
    my $update_project;
    if ( !$project ) {
        p $project;
        my $url =
          URI->new("http://planejasampa.prefeitura.sp.gov.br/metas/api");

        $url->path_segments( 'metas', 'api', 'project', $row->[1] );

        my $resp  = $furl->get( $url->as_string );
        my $value = decode_json $resp->content;
        warn "value";
        print $row->[1], "\n";
        print $value->{name}, "\n";
        $update_project =
          $schema->resultset('Project')
          ->search( { name => { ilike => $value->{name} } } )
          ->update( { project_number => $row->[1] } );
        $project =
          $schema->resultset('Project')
          ->search( { project_number => $row->[1] } )->next
          if $update_project;
    }
}

$csv->eol("\r\n");

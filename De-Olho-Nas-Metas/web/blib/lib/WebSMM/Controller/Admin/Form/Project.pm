package WebSMM::Controller::Admin::Form::Project;
use Moose;
use namespace::autoclean;
use DateTime;
use JSON::XS;
use utf8;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/admin/form/base') : PathPart('') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

sub download : Chained('base') : PathPart('project') : CaptureArgs(0) {
    my ( $self, $c ) = @_;

    @{ $c->stash->{header} } = (
        "nome",
        "endereço",
        "latitude",
        "longitude",
        "orçamento executado",
        "id da região",
        "id da meta",
        "porcentagem",
        "progresso qualitativo 1",
        "progresso qualitativo 2",
        "progresso qualitativo 3",
        "progresso qualitativo 4",
        "progresso qualitativo 5",
        "progresso qualitativo 6"
    );
}

sub process : Chained('base') : PathPart('project') : Args(0) {
    my ( $self, $c ) = @_;

    my $api    = $c->model('API');
    my $params = { %{ $c->req->params } };
    $api->stash_result(
        $c, ['projects'],
        method => 'POST',
        body   => $params
    );
    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    }

    $c->detach( '/form/redirect_ok',
        [ '/admin/project/index', {}, 'Cadastrado com sucesso!' ] );
}

sub upload : Chained('base') : PathPart('upload_project') : Args(0) {
    my ( $self, $c ) = @_;
    my $api = $c->model('API');

    my $upload = $c->req->upload('archive');
    if ( !$upload ) {
        $c->stash->{error} = 'form_error';
        $c->stash->{form_error} = { 'archive', 'missing' };
        $c->detach('/form/redirect_error');
    }
    elsif ( $upload->filename !~ /(.xlsx?|.csv)$/i ) {
        $c->stash->{error}      = 'form_error';
        $c->stash->{form_error} = { 'archive', 'invalid' };
        $c->stash->{form_error} = { 'archive:help', 'use XLS, XLSX or CSV' };
        $c->detach( '/form/redirect_error4adm',
            [ anchor => 'usuario/blacklist/upload' ] );
    }
    my $status = $api->stash_result(
        $c,
        [ 'upload', 'projects' ],

        body => [
            'orignal_filename ' => $upload->filename,
            'file'              => [ $upload->tempname ]
        ],
        method => 'upload',
    );
    if ( $c->stash->{status}{error} eq 'header_found' ) {
        $c->stash->{error}      = 'form_error';
        $c->stash->{form_error} = {
            'archive',      'invalid',
            'archive:help', 'cabeçalho não encontrado.'
        };

        $c->detach( '/form/redirect_error', );
    }
    elsif ( $c->stash->{error} ) {

        $c->stash->{error}      = $status->{error};
        $c->stash->{form_error} = $status->{form_error}
          if exists $status->{form_error};
        $c->stash->{error} = 'form_error' if $status->{error_is_form_error};

        if ( ref $c->stash->{form_error} eq 'HASH' ) {
            my %new;

            # porrra de macros.tt q nao entende os varios tipos de erros..
            while ( my ( $k, $v ) = each %{ $c->stash->{form_error} } ) {
                $new{$k} = $v;
                if ( $v !~ /(invalid|missing)/ ) {
                    $new{"$k:help"} = $v;
                    $new{$k} = 'invalid';
                }
            }
            $c->stash->{form_error} = \%new;
        }

        $c->detach( '/form/redirect_error', );

    }
    else {

        $c->detach(
            '/form/redirect_ok',
            [
                \'/admin/project/upload',
                status_msg => 'Importado com sucesso',
                status     => $c->stash->{status}
            ],
        );

    }

}

sub process_edit : Chained('base') : PathPart('project') : Args(1) {
    my ( $self, $c, $id ) = @_;

    my $api    = $c->model('API');
    my $params = { %{ $c->req->params } };

    $api->stash_result(
        $c, [ 'projects', $id ],
        method => 'PUT',
        body   => $params
    );

    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    }
    else {
        $c->detach( '/form/redirect_ok',
            [ '/admin/project/index', {}, 'Alterado com sucesso!' ] );
    }
}

sub process_delete : Chained('base') : PathPart('remove_project') : Args(1) {
    my ( $self, $c, $id ) = @_;

    my $api = $c->model('API');

    $api->stash_result( $c, [ 'projects', $id ], method => 'DELETE' );

    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    }
    else {
        $c->detach( '/form/redirect_ok',
            [ '/admin/project/index', {}, 'Removido com sucesso!' ] );
    }
}

sub csv : Chained('download') : PathPart('csv') : Args(0) {
    my ( $self, $c ) = @_;
    my $api  = $c->model('API');
    my $file = $c->model('File');

    my %lines;
    $c->stash->{type} = 'csv';
    push @{ $lines{main} }, $c->stash->{header};
    $file->_download( $c, 'project', \%lines );

}

sub xls : Chained('download') : PathPart('xls') : Args(0) {
    my ( $self, $c ) = @_;
    my $api  = $c->model('API');
    my $file = $c->model('File');

    my %lines;
    $c->stash->{type} = 'xls';
    push @{ $lines{main} }, $c->stash->{header};
    $file->_download( $c, 'project', \%lines );

}

sub xlsx : Chained('download') : PathPart('xlsx') : Args(0) {
    my ( $self, $c ) = @_;
    my $api  = $c->model('API');
    my $file = $c->model('File');

    my %lines;
    $c->stash->{type} = 'csv';
    push @{ $lines{main} }, $c->stash->{header};
    $file->_download( $c, 'project', \%lines );

}

sub goal : Chained('download') : PathPart('goal') : Args(0) {
    my ( $self, $c ) = @_;
    my $api  = $c->model('API');
    my $file = $c->model('File');

    my %lines;
    $c->stash->{type} = 'xls';

    $api->stash_result( $c, 'goals' );

    push @{ $lines{main} }, [ 'id', 'name' ];
    push @{ $lines{main} }, [ $_->{id}, $_->{name} ]
      for @{ $c->stash->{goals} };
    $file->_download( $c, 'metas', \%lines );

}

sub region : Chained('download') : PathPart('region') : Args(0) {
    my ( $self, $c ) = @_;
    my $api  = $c->model('API');
    my $file = $c->model('File');

    my %lines;
    $c->stash->{type} = 'xls';

    $api->stash_result( $c, 'regions' );

    push @{ $lines{main} }, [ 'id', 'name' ];
    push @{ $lines{main} }, [ $_->{id}, $_->{name} ]
      for @{ $c->stash->{regions} };
    $file->_download( $c, 'regioes', \%lines );

}
__PACKAGE__->meta->make_immutable;

1;

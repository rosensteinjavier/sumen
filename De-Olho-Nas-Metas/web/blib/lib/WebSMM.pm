package WebSMM;
use Moose;
use CatalystX::RoleApplicator;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

# Set flags and add plugins for the application.
#
# Note that ORDERING IS IMPORTANT here as plugins are initialized in order,
# therefore you almost certainly want to keep ConfigLoader at the head of the
# list if you're using it.
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use Catalyst qw/
  ConfigLoader
  Static::Simple

  Assets
  StatusMessage

  Authentication
  Session::DynamicExpiry
  Session

  +CatalystX::Plugin::Lexicon
  Session::Store::File
  Session::State::Cookie
  Session::PerUser
  Static::Simple
  /;

extends 'Catalyst';

our $VERSION = '0.01';

# Configure the application.
#
# Note that settings in webpi.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

__PACKAGE__->config(
    name     => 'WebSMM',
    encoding => 'UTF-8',

    # Disable deprecated behavior needed by old applications
    disable_component_resolution_regex_fallback => 1,
    enable_catalyst_header                      => 1,   # Send X-Catalyst header

    'Plugin::Assets' => {

        path        => '/static',
        output_path => 'built/',
        minify      => 1,
        stash_var   => 'assets'
    },
    'View::TT' => {
        expose_methods => [
            'days_of_week_human',   'hour_human',
            'format_date_to_human', 'format_cnpj_to_human',
            'birthdate_to_age',     'meter_to_kilometer',
            'ymd_to_human',         'month_name',
            'l'
        ]
    },
);

after 'setup_components' => sub {
    my $app = shift;
    for ( keys %{ $app->components } ) {
        if ( $app->components->{$_}->can('initialize_after_setup') ) {
            $app->components->{$_}->initialize_after_setup($app);
        }
    }
};
after setup_finalize => sub {
    my $app = shift;

    for ( $app->registered_plugins ) {
        if ( $_->can('initialize_after_setup') ) {
            $_->initialize_after_setup($app);
        }
    }
};

# Start the application
__PACKAGE__->setup();

=encoding utf8

=head1 NAME

WebSMM - Catalyst based application

=head1 SYNOPSIS

    script/webpi_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<WebSMM::Controller::Root>, L<Catalyst>

=head1 AUTHOR

renato,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

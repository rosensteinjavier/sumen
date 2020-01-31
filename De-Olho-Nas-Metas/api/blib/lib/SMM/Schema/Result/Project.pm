use utf8;

package SMM::Schema::Result::Project;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SMM::Schema::Result::Project

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::TimeStamp>

=item * L<DBIx::Class::PassphraseColumn>

=back

=cut

__PACKAGE__->load_components( "InflateColumn::DateTime", "TimeStamp",
    "PassphraseColumn" );

=head1 TABLE: C<project>

=cut

__PACKAGE__->table("project");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'project_id_seq'

=head2 name

  data_type: 'text'
  is_nullable: 0

=head2 address

  data_type: 'text'
  is_nullable: 1

=head2 latitude

  data_type: 'text'
  is_nullable: 1

=head2 longitude

  data_type: 'text'
  is_nullable: 1

=head2 budget_executed

  data_type: 'double precision'
  is_nullable: 1

=head2 created_at

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 1
  original: {default_value => \"now()"}

=head2 updated_at

  data_type: 'timestamp'
  is_nullable: 1

=head2 region_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 project_number

  data_type: 'integer'
  is_nullable: 1

=head2 qualitative_progress_6

  data_type: 'text'
  is_nullable: 1

=head2 qualitative_progress_5

  data_type: 'text'
  is_nullable: 1

=head2 qualitative_progress_4

  data_type: 'text'
  is_nullable: 1

=head2 qualitative_progress_3

  data_type: 'text'
  is_nullable: 1

=head2 qualitative_progress_2

  data_type: 'text'
  is_nullable: 1

=head2 qualitative_progress_1

  data_type: 'text'
  is_nullable: 1

=head2 percentage

  data_type: 'numeric'
  is_nullable: 1

=head2 type

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 goal_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
    "id",
    {
        data_type         => "integer",
        is_auto_increment => 1,
        is_nullable       => 0,
        sequence          => "project_id_seq",
    },
    "name",
    { data_type => "text", is_nullable => 0 },
    "address",
    { data_type => "text", is_nullable => 1 },
    "latitude",
    { data_type => "text", is_nullable => 1 },
    "longitude",
    { data_type => "text", is_nullable => 1 },
    "budget_executed",
    { data_type => "double precision", is_nullable => 1 },
    "created_at",
    {
        data_type     => "timestamp",
        default_value => \"current_timestamp",
        is_nullable   => 1,
        original      => { default_value => \"now()" },
    },
    "updated_at",
    { data_type => "timestamp", is_nullable => 1 },
    "region_id",
    { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
    "project_number",
    { data_type => "integer", is_nullable => 1 },
    "qualitative_progress_6",
    { data_type => "text", is_nullable => 1 },
    "qualitative_progress_5",
    { data_type => "text", is_nullable => 1 },
    "qualitative_progress_4",
    { data_type => "text", is_nullable => 1 },
    "qualitative_progress_3",
    { data_type => "text", is_nullable => 1 },
    "qualitative_progress_2",
    { data_type => "text", is_nullable => 1 },
    "qualitative_progress_1",
    { data_type => "text", is_nullable => 1 },
    "percentage",
    { data_type => "numeric", is_nullable => 1 },
    "type",
    { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
    "goal_id",
    { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 campaigns

Type: has_many

Related object: L<SMM::Schema::Result::Campaign>

=cut

__PACKAGE__->has_many(
    "campaigns",
    "SMM::Schema::Result::Campaign",
    { "foreign.project_id" => "self.id" },
    { cascade_copy         => 0, cascade_delete => 0 },
);

=head2 comment_projects

Type: has_many

Related object: L<SMM::Schema::Result::CommentProject>

=cut

__PACKAGE__->has_many(
    "comment_projects",
    "SMM::Schema::Result::CommentProject",
    { "foreign.project_id" => "self.id" },
    { cascade_copy         => 0, cascade_delete => 0 },
);

=head2 goal

Type: belongs_to

Related object: L<SMM::Schema::Result::Goal>

=cut

__PACKAGE__->belongs_to(
    "goal_tb",
    "SMM::Schema::Result::Goal",
    { id => "goal_id" },
    {
        is_deferrable => 0,
        join_type     => "LEFT",
        on_delete     => "NO ACTION",
        on_update     => "NO ACTION",
    },
);

=head2 goal_projects

Type: has_many

Related object: L<SMM::Schema::Result::GoalProject>

=cut

__PACKAGE__->has_many(
    "goal_projects",
    "SMM::Schema::Result::GoalProject",
    { "foreign.project_id" => "self.id" },
    { cascade_copy         => 0, cascade_delete => 0 },
);

=head2 images_projects

Type: has_many

Related object: L<SMM::Schema::Result::ImagesProject>

=cut

__PACKAGE__->has_many(
    "images_projects",
    "SMM::Schema::Result::ImagesProject",
    { "foreign.project_id" => "self.id" },
    { cascade_copy         => 0, cascade_delete => 0 },
);

=head2 project_accept_porcentages

Type: has_many

Related object: L<SMM::Schema::Result::ProjectAcceptPorcentage>

=cut

__PACKAGE__->has_many(
    "project_accept_porcentages",
    "SMM::Schema::Result::ProjectAcceptPorcentage",
    { "foreign.project_id" => "self.id" },
    { cascade_copy         => 0, cascade_delete => 0 },
);

=head2 project_events

Type: has_many

Related object: L<SMM::Schema::Result::ProjectEvent>

=cut

__PACKAGE__->has_many(
    "project_events",
    "SMM::Schema::Result::ProjectEvent",
    { "foreign.project_id" => "self.id" },
    { cascade_copy         => 0, cascade_delete => 0 },
);

=head2 project_images

Type: has_many

Related object: L<SMM::Schema::Result::ProjectImage>

=cut

__PACKAGE__->has_many(
    "project_images",
    "SMM::Schema::Result::ProjectImage",
    { "foreign.project_id" => "self.id" },
    { cascade_copy         => 0, cascade_delete => 0 },
);

=head2 project_milestones

Type: has_many

Related object: L<SMM::Schema::Result::ProjectMilestone>

=cut

__PACKAGE__->has_many(
    "project_milestones",
    "SMM::Schema::Result::ProjectMilestone",
    { "foreign.project_id" => "self.id" },
    { cascade_copy         => 0, cascade_delete => 0 },
);

=head2 project_prefectures

Type: has_many

Related object: L<SMM::Schema::Result::ProjectPrefecture>

=cut

__PACKAGE__->has_many(
    "project_prefectures",
    "SMM::Schema::Result::ProjectPrefecture",
    { "foreign.project_id" => "self.id" },
    { cascade_copy         => 0, cascade_delete => 0 },
);

=head2 project_progresses

Type: has_many

Related object: L<SMM::Schema::Result::ProjectProgress>

=cut

__PACKAGE__->has_many(
    "project_progresses",
    "SMM::Schema::Result::ProjectProgress",
    { "foreign.project_id" => "self.id" },
    { cascade_copy         => 0, cascade_delete => 0 },
);

=head2 project_regions

Type: has_many

Related object: L<SMM::Schema::Result::ProjectRegion>

=cut

__PACKAGE__->has_many(
    "project_regions",
    "SMM::Schema::Result::ProjectRegion",
    { "foreign.project_id" => "self.id" },
    { cascade_copy         => 0, cascade_delete => 0 },
);

=head2 region

Type: belongs_to

Related object: L<SMM::Schema::Result::Region>

=cut

__PACKAGE__->belongs_to(
    "region",
    "SMM::Schema::Result::Region",
    { id => "region_id" },
    {
        is_deferrable => 0,
        join_type     => "LEFT",
        on_delete     => "NO ACTION",
        on_update     => "NO ACTION",
    },
);

=head2 type

Type: belongs_to

Related object: L<SMM::Schema::Result::ProjectType>

=cut

__PACKAGE__->belongs_to(
    "type",
    "SMM::Schema::Result::ProjectType",
    { id => "type" },
    {
        is_deferrable => 0,
        join_type     => "LEFT",
        on_delete     => "NO ACTION",
        on_update     => "NO ACTION",
    },
);

=head2 user_follow_projects

Type: has_many

Related object: L<SMM::Schema::Result::UserFollowProject>

=cut

__PACKAGE__->has_many(
    "user_follow_projects",
    "SMM::Schema::Result::UserFollowProject",
    { "foreign.project_id" => "self.id" },
    { cascade_copy         => 0, cascade_delete => 0 },
);

# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-04-16 13:52:47
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ne+aZmlUrl4HUjPBhBDkOQ

__PACKAGE__->has_many(
    approved_comments => 'SMM::Schema::Result::CommentProject',
    sub {
        my $args = shift;

        return {
            "$args->{foreign_alias}.project_id" =>
              { -ident => "$args->{self_alias}.id" },
            "$args->{foreign_alias}.approved" => 1,
        };
    },
    { cascade_copy => 0, cascade_delete => 0 },
);

__PACKAGE__->has_many(
    approved_project_events => 'SMM::Schema::Result::ProjectEvent',
    sub {
        my $args = shift;

        return {
            "$args->{foreign_alias}.project_id" =>
              { -ident => "$args->{self_alias}.id" },
            "$args->{foreign_alias}.approved" => 1,
        };
    },
    { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->many_to_many( goals => goal_projects => 'goal' );

__PACKAGE__->many_to_many( prefectures => project_prefectures => 'prefecture' );

with 'SMM::Role::Verification';
with 'SMM::Role::Verification::TransactionalActions::DBIC';
with 'SMM::Schema::Role::ResultsetFind';

use Data::Verifier;
use MooseX::Types::Email qw/EmailAddress/;
use SMM::Types qw /DataStr TimeStr/;

sub verifiers_specs {
    my $self = shift;
    return {
        update => Data::Verifier->new(
            filters => [qw(trim)],
            profile => {
                name => {
                    required => 0,
                    type     => 'Str',
                },
                address => {
                    required => 0,
                    type     => 'Str',
                },
                latitude => {
                    required => 0,
                    type     => 'Str',
                },
                longitude => {
                    required => 0,
                    type     => 'Str',
                },
                region_id => {
                    required => 0,
                    type     => 'Int',
                },
                project_number => {
                    required => 0,
                    type     => 'Int',
                },
                qualitative_progress_1 => {
                    required => 0,
                    type     => 'Str',
                },
                qualitative_progress_2 => {
                    required => 0,
                    type     => 'Str',
                },
                qualitative_progress_3 => {
                    required => 0,
                    type     => 'Str',
                },
                qualitative_progress_4 => {
                    required => 0,
                    type     => 'Str',
                },
                qualitative_progress_5 => {
                    required => 0,
                    type     => 'Str',
                },
                qualitative_progress_6 => {
                    required => 0,
                    type     => 'Str',
                },
                percentage => {
                    required => 0,
                    type     => 'Str',
                },
                updated_at => {
                    required => 0,
                    type     => DataStr,
                },
            }
        ),
    };
}

sub action_specs {
    my $self = shift;
    return {
        update => sub {
            my %values = shift->valid_values;

            not defined $values{$_} and delete $values{$_} for keys %values;

            my $project = $self->update( \%values );

            return $project;
        },

    };
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;

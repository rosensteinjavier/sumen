use utf8;
package SMM::Schema::Result::Milestone;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SMM::Schema::Result::Milestone

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

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "PassphraseColumn");

=head1 TABLE: C<milestones>

=cut

__PACKAGE__->table("milestones");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'milestones_id_seq'

=head2 name

  data_type: 'text'
  is_nullable: 0

=head2 project_type_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 percentage

  data_type: 'integer'
  is_nullable: 1

=head2 sequence

  accessor: 'column_sequence'
  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "milestones_id_seq",
  },
  "name",
  { data_type => "text", is_nullable => 0 },
  "project_type_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "percentage",
  { data_type => "integer", is_nullable => 1 },
  "sequence",
  { accessor => "column_sequence", data_type => "integer", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 project_milestones

Type: has_many

Related object: L<SMM::Schema::Result::ProjectMilestone>

=cut

__PACKAGE__->has_many(
  "project_milestones",
  "SMM::Schema::Result::ProjectMilestone",
  { "foreign.milestone" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 project_type

Type: belongs_to

Related object: L<SMM::Schema::Result::ProjectType>

=cut

__PACKAGE__->belongs_to(
  "project_type",
  "SMM::Schema::Result::ProjectType",
  { id => "project_type_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-03-24 03:18:53
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:8mgfvRKUG4RDJFiEeQhP7w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;

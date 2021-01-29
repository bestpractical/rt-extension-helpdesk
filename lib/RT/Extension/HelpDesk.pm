use strict;
use warnings;
package RT::Extension::HelpDesk;

our $VERSION = '0.01';

=head1 NAME

RT-Extension-HelpDesk - Simple help desk vertical for RT.

=head1 DESCRIPTION

This extension provides a simple L<initialdata|https://docs.bestpractical.com/rt/latest/initialdata.html/> file
to insert some sane help desk defaults. See the L<CONFIGURATION|CONFIGURATION> section for more information
on these defaults.

=head1 RT VERSION

Works with RT 5.

=head1 INSTALLATION

=over

=item C<perl Makefile.PL>

=item C<make>

=item C<make install>

May need root permissions

=item C<make initdb>

Only run this the first time you install this module.

If you run this twice, you may end up with duplicate data
in your database.

If you are upgrading this module, check for upgrading instructions
in case changes need to be made to your database.

=item Edit your F</opt/rt5/etc/RT_SiteConfig.pm>

Add this line:

    Plugin('RT::Extension::HelpDesk');

=item Clear your mason cache

    rm -rf /opt/rt5/var/mason_data/obj

=item Restart your webserver

=back

=head1 CONFIGURATION

=over

=item Support Queue

This extension creates a new queue named "Support". This queue is
where incoming support request should be created.

=item Support Group

This group is created by the extension and granted rights to perform typical
support opperations on tickets in the support group. You should add any support
representative users to this group.

=item On Requestor Correspond Update Status To "waiting for support"

Automation to switch ticket status to "waiting for support" when a requestor replies to a ticket,
the requestor is typically the customer who is asking for support.

=item On Non-Requestor Correspond Update Status To "waiting for customer"

Automation to switch ticket status to "waiting for customer" when a user
who is not a requestor on the ticket replies on the ticket. This usually means
the support representative in charge of the ticket sent an email to the customer
and is waiting for some feedback.

=back

=head1 AUTHOR

Best Practical Solutions, LLC E<lt>modules@bestpractical.comE<gt>

=for html <p>All bugs should be reported via email to <a
href="mailto:bug-RT-Extension-HelpDesk@rt.cpan.org">bug-RT-Extension-HelpDesk@rt.cpan.org</a>
or via the web at <a
href="http://rt.cpan.org/Public/Dist/Display.html?Name=RT-Extension-HelpDesk">rt.cpan.org</a>.</p>

=for text
    All bugs should be reported via email to
        bug-RT-Extension-HelpDesk@rt.cpan.org
    or via the web at
        http://rt.cpan.org/Public/Dist/Display.html?Name=RT-Extension-HelpDesk

=head1 LICENSE AND COPYRIGHT

This software is Copyright (c) 2021 by Best Practical LLC

This is free software, licensed under:

  The GNU General Public License, Version 2, June 1991

=cut

1;

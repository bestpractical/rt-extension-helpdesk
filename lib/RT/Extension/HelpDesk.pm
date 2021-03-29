use strict;
use warnings;
package RT::Extension::HelpDesk;

our $VERSION = '0.01';

=head1 NAME

RT-Extension-HelpDesk - Default Help desk configuration for Request Tracker

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

=head1 DESCRIPTION

One common use for Request Tracker (RT) is tracking user issues,
typically related to IT services. The "help desk" is often a department,
either a designated help desk with many agents for large organizations,
or sometimes only a one or two people who handle all IT services for a
smaller organization.

RT is used to track incoming user requests so they don't get lost
and can be assigned to individual people to handle. It's also useful
for gathering general reporting on the volume of user IT requests
and what types of issues seem to generate the most issues.

This extension provides an L<initialdata|https://docs.bestpractical.com/rt/latest/initialdata.html/> file
to configure a queue with some sensible default rights configuration
for a typical help desk. Once installed, you can then edit the
configuration to best suit your needs.

=head2 Support Queue

It creates a new queue called L<Support> for tracking all of the
incoming help desk requests. You can change the name to anything you
like after installing. In a typical configuration, you will also
want to assign an RT email address, like support@example.com or
helpdesk@example.com to create tickets in this queue.

=head2 Rights

Some typical initial rights are set on the L<Support> queue. The
system group "Everyone" gets a default set of rights to allow end
users to create tickets. Everyone is system group provided with RT,
and as the name implies it encompasses every user in RT.

=begin HTML

<p><img width="500px" src="https://static.bestpractical.com/images/helpdesk/everyone_group_rights.png"
alt="Group rights for 'Everyone' group on 'Support' queue" /></p>

=end HTML

These rights are usually the minimum needed for a typical support
desk. Anyone is able to write into our support address with a help
desk question, and they can reply and follow-up on that request if
we send them some questions.

The extension also grants "ShowTicket" to the Requestor role. If your
end users have access to RT's self service interface, this allows them
to see only tickets where they are the Requestor, which should be
the tickets they opened.

Our internal support representatives will need many more rights to
work on tickets. To make it easy to add and remove access for
staff users, this extension creates a L<Support Group>. Rights are
granted to the group, so membership in the group is all a user needs
to get those rights.

=begin HTML

<p><img width="500px" src="https://static.bestpractical.com/images/helpdesk/support_group_rights.png"
alt="Group rights for 'Support' group on 'Support' queue" /></p>

=end HTML

=head2 Support Lifecycle

RT allows you to create and configure custom workflows for each queue
in the system.  In RT a ticket workflow is known as a L<Lifecycle|https://docs.bestpractical.com/rt/latest/customizing/lifecycles.html>.
This extension provies a custom lifecycle called "support" that
defines the various statuses a ticket can be in.

=begin HTML

<p><img width="500px" src="https://static.bestpractical.com/images/helpdesk/support_lifecycle.png"
alt="Lifecycle for 'Support' queue" /></p>

=end HTML

The custom statuses "waiting for customer" and "waiting for support" triggers
some automation around replying to support requests.

The automation applied to the support queue is designed to allow support staff
to more easily keep track of support requests that need attention. There are
two new Scrips that do the following:

=over

=item On Requestor Correspond Update Status To "waiting for support"

Updates the ticket status to "waiting for support" when a requestor replies
to a ticket. The requestor is typically the end user who is asking for
support.

=item On Non-Requestor Correspond Update Status To "waiting for customer"

Updates the ticket status to "waiting for customer" when a user
who is not a requestor on the ticket replies on the ticket. This usually means
the support representative in charge of the ticket sent an email to the customer
and is waiting for some feedback.

=item Support Dashboard

This extension created a new dashboard called "Support" in which any member of the support group can view.
This dashboard has a default saved search added to it, "Highest severity tickets waiting on support".

=head2 Next Steps

Once the Help Desk extension is installed, there are a few optional steps to take to
improve the help desk experience.

1.As an RT admin set the L<default queue|https://docs.bestpractical.com/rt/5.0.1/RT_Config.html#DefaultQueue> for the ticket create page to the "support" queue.

2. Got to Admin->Global->Modify Reports MenuAdd and add the 'Support' dashboard to the "Reports" menu.

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

/*
 * Copyright (c) 2017-2018 elementary LLC (https://elementary.io)
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Library General Public License as published by
 * the Free Software Foundation, either version 2.1 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

public class Network.VpnMenuItem : Gtk.ListBoxRow {
    public signal void user_action ();
    public NM.RemoteConnection? connection { get; private set; }
    public string id {
        get {
            return connection.get_id ();
        }
    }
    public Network.State vpn_state { get; set; default = Network.State.DISCONNECTED; }

    Gtk.Spinner spinner;
    Gtk.Image error_img;

    private Gtk.Label vpn_label;
    private Gtk.Label vpn_state_label;

    public VpnMenuItem (NM.RemoteConnection? _connection) {
        connection = _connection;
        connection.changed.connect (update);

        vpn_label = new Gtk.Label(null);
        vpn_label.halign = Gtk.Align.START;
        vpn_label.expand = true;
        vpn_label.margin_start = 6;
        vpn_state_label = new Gtk.Label(null);
        vpn_state_label.halign = Gtk.Align.START;
        vpn_state_label.expand = true;
        vpn_state_label.margin_start = 6;

        error_img = new Gtk.Image.from_icon_name ("process-error-symbolic", Gtk.IconSize.MENU);
        error_img.margin_start = 6;
        error_img.set_tooltip_text (_("This Virtual Private Network could not be connected to."));

        spinner = new Gtk.Spinner ();
        spinner.start ();
        spinner.visible = false;
        spinner.no_show_all = !spinner.visible;

        var grid = new Gtk.Grid ();
        grid.column_spacing = 6;
        grid.attach (vpn_label, 0, 0, 1, 1);
        grid.attach_next_to (vpn_state_label, vpn_label, Gtk.PositionType.BOTTOM, 1, 1);
        grid.attach_next_to (spinner, vpn_label, Gtk.PositionType.RIGHT, 1, 2);
        grid.attach_next_to (error_img, spinner, Gtk.PositionType.RIGHT, 1, 2);

        add (grid);
        get_style_context ().add_class ("menuitem");

        notify["vpn_state"].connect (update);

        update ();
    }

    private void update () {
        vpn_label.label = connection.get_id ();
        hide_item (error_img);
        hide_item (spinner);

        switch (vpn_state) {
            case State.FAILED_VPN:
                show_item (error_img);
                vpn_state_label.label = _("Failed to connect");
                break;
            case State.CONNECTING_VPN:
                show_item (spinner);
                vpn_state_label.label = _("Connecting");
                break;
            case State.CONNECTED_VPN:
                vpn_state_label.label = _("Connected");
                break;
            default:
                vpn_state_label.label = _("Disconnected");
                break;
        }
    }

    void show_item (Gtk.Widget w) {
        w.visible = true;
        w.no_show_all = w.visible;
    }

    void hide_item (Gtk.Widget w) {
        w.visible = false;
        w.no_show_all = !w.visible;
        w.hide ();
    }
}

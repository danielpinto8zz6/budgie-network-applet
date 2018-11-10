/*
 * Copyright (c) 2018 Daniel Pinto (https://github.com/danielpinto8zz6/budgie-network-applet)
 * Copyright (c) 2011-2018 elementary, Inc. (https://elementary.io)
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public
 * License along with this program; if not, write to the
 * Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301 USA.
 */

public class Network.Widgets.Switch : Gtk.Button {
    public bool active { get; set; }
    public string caption { owned get; set; }
    public string icon_name { owned get; construct; }

    private Gtk.Label button_label;
    private Gtk.Image button_image;
    private Gtk.Switch button_switch;

    public Switch (string caption, string icon_name) {
        Object (caption: caption, icon_name: icon_name);
    }

    construct {
        var content_widget = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        content_widget.hexpand = true;
        add (content_widget);

        var style_context = this.get_style_context ();
        style_context.add_class(Gtk.STYLE_CLASS_FLAT);
        style_context.add_class (Gtk.STYLE_CLASS_MENUITEM);
        style_context.remove_class (Gtk.STYLE_CLASS_BUTTON);
        style_context.remove_class ("text-button");
        

        button_image = new Gtk.Image.from_icon_name (icon_name, Gtk.IconSize.MENU);
        button_image.halign = Gtk.Align.START;

        button_label = new Gtk.Label (null);
        button_label.halign = Gtk.Align.START;
        button_label.margin_start = 6;
        button_label.margin_end = 10;

        button_switch = new Gtk.Switch ();
        button_switch.active = active;
        button_switch.halign = Gtk.Align.END;
        button_switch.hexpand = true;

        content_widget.add (button_image);
        content_widget.add (button_label);
        content_widget.add (button_switch);

        clicked.connect (() => {
            button_switch.activate ();
        });

        bind_property ("active", button_switch, "active", GLib.BindingFlags.SYNC_CREATE|GLib.BindingFlags.BIDIRECTIONAL);
        bind_property ("caption", button_label, "label", GLib.BindingFlags.SYNC_CREATE|GLib.BindingFlags.BIDIRECTIONAL);
    }
}
public class Network.Widgets.OverlayIcon : Gtk.Overlay {
    private Gtk.Image main_image;
    private Gtk.Image overlay_image;

    public OverlayIcon (string icon_name) {
        main_image.icon_name = icon_name;
    }

    construct {
        main_image = new Gtk.Image ();
        main_image.icon_size = Gtk.IconSize.MENU;

        overlay_image = new Gtk.Image ();
        overlay_image.icon_size = Gtk.IconSize.MENU;

        add (main_image);
        add_overlay (overlay_image);
    }

    public void set_name (string main_image_icon_name, string? overlay_image_icon_name = null) {
        main_image.icon_name = main_image_icon_name;
        overlay_image.icon_name = overlay_image_icon_name;
    }
}
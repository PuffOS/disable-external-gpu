import gi, os
gi.require_version('Gtk', '3.0')
from gi.repository import GLib, Gio, Gtk, Gdk
builder = Gtk.Builder()
builder.add_from_file(os.path.dirname(os.path.abspath(__file__)) + "/main.ui")
enabled = not os.path.exists("/var/cache/disable-gpu")

def button_event(widget):
    if not enabled:
        os.system("pkexec bash -c 'rm -f /var/cache/disable-gpu && reboot'")
    else:
        os.system("pkexec bash -c 'touch /var/cache/disable-gpu && reboot'")

button = builder.get_object("button")
button.connect("clicked",button_event)

if enabled:
    button.set_label("Disable External GPU")
else:
    button.set_label("Enable External GPU")


window = builder.get_object("window")
window.connect("destroy",Gtk.main_quit)
window.show_all()

Gtk.main()



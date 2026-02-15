{ ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Key mappings
  # ────────────────────────────────────────────────────────────────────────────

  services.keyd = {
    enable = true;

    keyboards = {
      elecom = {
        ids = [ "056e:0131" ];
        # usb-ELECOM_TrackBall_Mouse_DEFT_Pro_TrackBall-event-mouse

        settings = {
          main = {
            # task = "C-w";
            mouse2 = "pageup";
            mouse1 = "pagedown";
            # hwheel_left = "C-pageup";
            # hwheel_right = "C-pagedown";
            mouseforward = "middlemouse";
            mouseback = "A-tab";
          };
        };
      };
    };
  };

}

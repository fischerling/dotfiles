function start_uni_wlan --description "starts wpa_supplicant and dhcpcd"
    sudo wpa_supplicant -B -iwlp2s0 -D wext -c /etc/wpa_supplicant/fau_stud.conf
    sudo dhcpcd wlp2s0
end

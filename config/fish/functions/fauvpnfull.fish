function fauvpnfull --description "route all traffic through the fau vpn"
    pushd .;
	and cd $HOME/Documents/MyDocuments/Study/FAU\ Erlangen/Allgemein/;
    and sudo openvpn FAU-Fulltunnel.ovpn;
    and popd;
end

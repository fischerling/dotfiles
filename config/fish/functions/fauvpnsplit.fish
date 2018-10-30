function fauvpnsplit --description "route all fau-related traffic through the fau vpn"
	pushd .;
	and cd $HOME/Documents/MyDocuments/Study/FAU-Erlangen/Allgemein/
	and sudo openvpn FAU-Splittunnel.ovpn;
	popd;
end

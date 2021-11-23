function jllocal -d 'Open a ssh tunnel port with the jupyter lab local server'
    set port 5678
    set remote_username alejandromorales
    set remote_hostname 192.168.0.40
    set url "http://localhost:$port"
    echo "Opening $url"
    open "$url"
    set cmd "ssh -CNL localhost:"$port":localhost:"$port" $remote_username@$remote_hostname" 
    echo "Running '$cmd'"
    eval "$cmd"
end

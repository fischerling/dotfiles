from subprocess import check_output

def get_passwd(account):
    return check_output("pass email/" + account, shell=True).rstrip().split("\n")[0]

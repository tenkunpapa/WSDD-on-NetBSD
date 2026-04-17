#!/bin/sh
#
# $NetBSD: wsdd.sh,v 1.1 2003/01/21 06:02:42 lukem Exp $
#

# PROVIDE: wsdd
# REQUIRE: DAEMON LOGIN mountall
# KEYWORD: shutdown

# Note: this needs NetBSD 9.4 amd64 + Python 3.13  or newer
#

. /etc/rc.subr

name="wsdd"
rcvar=${name}
command="/usr/local/bin/python"
procname="/usr/local/libexec/${name}"
required_files="/usr/local/etc/${name}.conf"
start_cmd=wsdd_start
stop_cmd=wsdd_stop
restart_cmd=wsdd_restart
onestart_cmd=wsdd_start
onestop_cmd=wsdd_stop
onerestart_cmd=wsdd_restart

. ${required_files}

if ${allowed_address_family+:} false; then
	wsdd_flags="${wsdd_flags} -4"
fi

if ${interfaces+:} false; then
	wsdd_flags="${wsdd_flags} -i ${interfaces}"
fi

if ${member_of+:} false; then
	wsdd_flags="${wsdd_flags} -w ${member_of}"
fi

if ${user_group+:} false; then
	wsdd_flags="${wsdd_flags} -u ${user_group}"
fi

if ${hostname+:} false; then
	wsdd_flags="${wsdd_flags} -n ${hostname}"
fi

# echo "[$wsdd_flags]"

wsdd_start()
{
	echo -n " Starting wsdd"
	${command} ${procname} ${wsdd_flags} &
	ps ax | grep "${procname}" | grep -v "grep" | awk '{print $1}' >${pid_file}
	echo "."
}

wsdd_stop()
{
	echo -n " Stopping wsdd"
	kill -9 `cat ${pid_file}` && rm ${pid_file}
	echo "."
}

wsdd_restart()
{
	wsdd_stop
	wsdd_start
}

load_rc_config ${name}
run_rc_command "$1"

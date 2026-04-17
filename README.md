# WSDD-for-NetBSD
Please modify wsdd.conf to your environment, and
<ul>
<li>cp wsdd.conf /usr/local/etc/wsdd.conf</li>
<li>cp wsdd.sh /etc/rc.d/wsdd</li>
<li>chmod a+x /etc/rc.d/wsdd</li>
<li>cp wsdd-nb9.4amd64-py3.13.py /usr/local/libexec/wsdd</li>
<li>chmod a+x /usr/local/libexec/wsdd</li>
<li>ln -s /usr/pkg/bin/python#.## /usr/local/bin/python3</li>
</ul>
